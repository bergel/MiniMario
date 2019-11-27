Class {
	#name : #MNWorld,
	#superclass : #Object,
	#instVars : [
		'world',
		'mario',
		'view'
	],
	#category : #MiniMario
}

{ #category : #initialization }
MNWorld >> addBrick: position [
	(self isInWorld: position)
		ifTrue: [ world at: position y at: position x put: 1 ]
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
	mario beat.
	mario isJumping ifFalse: [ 
		"is mario falling?"
		(self getCellAt: mario position + (0 @ 1)) = 0 
			ifTrue: [ 
				mario setAsFalling.
				mario translateBy: 0 @ 1 ]
			ifFalse: [ mario setAsNotFalling ] ].
	self refreshView
]

{ #category : #'as yet unclassified' }
MNWorld >> generateUI [

	| e |
	view := RTView new.
	-5 to: 5 do: [ :x |
		-5 to: 5 do: [ :y |
			e := RTBox new size: 11; elementOn: x @ y.
			view add: e.
			e translateTo: (x @ y) * 10 ] ].
	
	view when: TRKeyDown do: [ :evt | 
		evt keyValue = 100 ifTrue: [ mario moveRight ].
		evt keyValue = 97 ifTrue: [ mario moveLeft ].
		evt keyValue = 119 ifTrue: [ mario jump ].
		 ].
	
	view addAnimation: (RTActiveAnimation new intervalInMilliseconds: 30; blockToExecute: [ self beat ]).
	self refreshView.

]

{ #category : #'as yet unclassified' }
MNWorld >> generateWorld [
	| r|
	world := Array2D rows: self size y columns: self size x element: 0.
	r := Random seed: 42.
	20 timesRepeat: [ 
		self addPlatform: (r nextInt: self size x) @ (r nextInt: self size y) ].
	
	0 to: self size x do: [ :x | self addBrick: (x @ self size y) ].
	0 to: self size y do: [ :y | self addBrick: (1 @ y); addBrick: (self size x @ y) ].
	
	10 timesRepeat: [ self addTube: (r nextInt: self size x) ]
]

{ #category : #initialization }
MNWorld >> getCellAt: aPoint [
	^ world at: aPoint y at: aPoint x
]

{ #category : #initialization }
MNWorld >> initialize [
	super initialize.
	self initializeMario.
	self generateWorld.
	self generateUI
]

{ #category : #initialization }
MNWorld >> initializeMario [
	mario := MNMario new.
	mario translateTo: 2 @ 2.
	mario game: self.
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

{ #category : #'as yet unclassified' }
MNWorld >> open [
	<script: 'MNWorld new open'>
	self inspect.
	^ view open
]

{ #category : #'as yet unclassified' }
MNWorld >> refreshView [
	| p t color |
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
	view signalUpdate.

	
]

{ #category : #initialization }
MNWorld >> size [
	^ 300 @ 20
]

{ #category : #'as yet unclassified' }
MNWorld >> whatMarioSees [
	| result p t |
	result := OrderedCollection new.
	p := mario position.
	view elements doWithIndex: [ :e :index |
		t := p + e model.
		(self isInWorld: t) 
			ifTrue: [ result add: (world at: t y at: t x) ]
			ifFalse: [ result add: 1 ].	
	 ].
	^ result
]
