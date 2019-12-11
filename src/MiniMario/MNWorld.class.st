Class {
	#name : #MNWorld,
	#superclass : #Object,
	#instVars : [
		'world',
		'mario',
		'view',
		'random',
		'monsters',
		'gameIsRunning'
	],
	#category : #MiniMario
}

{ #category : #initialization }
MNWorld >> addBrick: position [
	(self isInWorld: position)
		ifTrue: [ world at: position y at: position x put: 1 ]
]

{ #category : #initialization }
MNWorld >> addMonster: aMonster [
	monsters add: aMonster.
	aMonster game: self.
]

{ #category : #initialization }
MNWorld >> addPlatform: position [
	-2 to: 2 do: [ :i |
		self addBrick: position + (i @ 0) ]
]

{ #category : #initialization }
MNWorld >> addTube: positionX [
 	| indexY |
	indexY := self size y - 1.
	3 timesRepeat: [ 
		self addTubeCell: positionX @ indexY.
		indexY := indexY - 1 ].
]

{ #category : #initialization }
MNWorld >> addTubeCell: position [
	(self isInWorld: position)
		ifTrue: [ world at: position y at: position x put: 2 ]
]

{ #category : #'as yet unclassified' }
MNWorld >> beat [
	gameIsRunning ifFalse: [ ^ self ].
	monsters do: #beat.
	mario beat.
	self refreshView
]

{ #category : #accessing }
MNWorld >> gameOver [
	gameIsRunning := false.
	view ifNil: [ ^ self ].
	view add: ((RTLabel new color: Color red; text: 'GAME OVER') element translateBy: 0 @ -100)
]

{ #category : #'as yet unclassified' }
MNWorld >> generateUI [

	| e upperBounds lowerBounds cellSizeInPixel |
	view := RTView new.
	
	cellSizeInPixel := 25.
	upperBounds := self windowSize // 2.
	lowerBounds := upperBounds negated.
	lowerBounds to: upperBounds do: [ :x |
		lowerBounds to: upperBounds do: [ :y |
			e := RTBox new size: cellSizeInPixel + 1; elementOn: x @ y.
			view add: e.
			e translateTo: (x @ y) * cellSizeInPixel ] ].
	
	view when: TRKeyDown do: [ :evt | 
		evt keyValue = 100 ifTrue: [ mario moveRight ].
		evt keyValue = 97 ifTrue: [ mario moveLeft ].
		evt keyValue = 119 ifTrue: [ mario jump ] ].
	
	view addAnimation: (RTActiveAnimation new intervalInMilliseconds: 30; blockToExecute: [ self beat ]).
	self refreshView.

]

{ #category : #'as yet unclassified' }
MNWorld >> generateWorld [
	world := Array2D rows: self size y columns: self size x element: 0.
	1 to: self size x do: [ :x | self addBrick: (x @ self size y); addBrick: (x @ 1) ].
	1 to: self size y do: [ :y | self addBrick: (1 @ y); addBrick: (self size x @ y) ].

	100 timesRepeat: [ 
		self addPlatform: (random nextInt: self size x) @ (random nextInt: self size y) ].
	
	30 timesRepeat: [ self addTube: (random nextInt: self size x) ]
]

{ #category : #initialization }
MNWorld >> getCellAt: aPoint [
	^ world at: aPoint y at: aPoint x
]

{ #category : #initialization }
MNWorld >> initialize [
	super initialize.
	self initializeMario.
	self seed: 42.
	self initializeMonsters.
	gameIsRunning := true
]

{ #category : #initialization }
MNWorld >> initializeMario [
	mario := MNMario new.
	mario translateTo: 2 @ 2.
	mario game: self.
]

{ #category : #initialization }
MNWorld >> initializeMonsters [
	monsters := OrderedCollection new.
	10 timesRepeat: [ 
		| m |
		m := MNMonster new translateTo: (random nextInt: self size x) @ 2.
		self addMonster: m ]
]

{ #category : #initialization }
MNWorld >> isInWorld: position [
	^ (1 @ 1 extent: self size) containsPoint: position
]

{ #category : #'as yet unclassified' }
MNWorld >> mario [
	^ mario
]

{ #category : #'as yet unclassified' }
MNWorld >> mario: aMario [
	mario := aMario.
	mario game: self.
	mario translateTo: 2 @ 2
]

{ #category : #accessing }
MNWorld >> monsters [
	^ monsters
]

{ #category : #'as yet unclassified' }
MNWorld >> open [
	<script: 'MNWorld new open'>
	self inspect.
	self generateUI.
	^ view open
]

{ #category : #'as yet unclassified' }
MNWorld >> refreshView [
	| p t color |
	view isNil ifTrue: [ ^ self ].
	gameIsRunning ifFalse: [ ^ self ].
	p := mario position.

	view elements doWithIndex: [ :e :index |
		t := p + e model.
		(self isInWorld: t) 
			ifTrue: [ 
				(world at: t y at: t x) = 0 ifTrue: [ color := Color blue ].
				(world at: t y at: t x) = 1 ifTrue: [ color := Color brown ].
				(world at: t y at: t x) = 2 ifTrue: [ color := Color green ] ]	
			ifFalse: [ color := Color black ].
		
		e model = (0 @ 0) ifTrue: [ color := Color red ].
		e trachelShape color: color.
	 ].

	monsters do: [ :m |
		t := m position - p.
		t x abs < 10 ifTrue: [ 
			| cell |
			cell := view elements elementFromModel: t.
			cell notNil ifTrue: [ cell trachelShape color: Color yellow ] ]. 
	].
	view signalUpdate.

	
]

{ #category : #initialization }
MNWorld >> seed: aNumber [
	random := Random seed: aNumber.
	self generateWorld.

]

{ #category : #initialization }
MNWorld >> size [
	^ 300 @ 10
]

{ #category : #'as yet unclassified' }
MNWorld >> whatMarioSees [
	| result p t upperBounds lowerBounds |
	result := OrderedCollection new.
	p := mario position.
	
	upperBounds := self windowSize // 2.
	lowerBounds := upperBounds negated.
	lowerBounds to: upperBounds do: [ :x |
		lowerBounds to: upperBounds do: [ :y |
			t := p + (x @ y).
			(self isInWorld: t) 
			ifTrue: [ result add: (world at: t y at: t x) ]
			ifFalse: [ result add: 1 ] ] ].
	^ result
]

{ #category : #'as yet unclassified' }
MNWorld >> windowSize [
	^ 10
]
