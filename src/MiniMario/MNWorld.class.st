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

{ #category : #'as yet unclassified' }
MNWorld >> beat [
	<script: 'self new beat'>
	"mario beat."
	mario isAnimated ifFalse: [ 
		"is mario falling?"
		(world at: mario position y + 1 at: mario position x) = 0 ifTrue: [ mario translateBy: 0 @ 1 ] ].
	self refreshView
]

{ #category : #initialization }
MNWorld >> example [
	<script: 'self new example'>
	| w win |
	w := MNWorld new.
	w generateWorld.
	win := w open.
	"win delete."
	100 timesRepeat: [ w beat ].
	self halt.
]

{ #category : #'as yet unclassified' }
MNWorld >> generateWorld [
	| r|
	r := Random seed: 42.
	20 timesRepeat: [ 
		self addPlatform: (r nextInt: self size x) @ (r nextInt: self size y) ].
	0 to: self size x do: [ :x | self addBrick: (x @ self size y) ].
	0 to: self size y do: [ :y | self addBrick: (1 @ y); addBrick: (self size x @ y) ]
	
	
]

{ #category : #initialization }
MNWorld >> initialize [
	super initialize.
	mario := MNMario new.
	mario translateTo: 2 @ 2.
	world := Array2D rows: self size y columns: self size x element: 0
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
MNWorld >> open [
	<script: 'MNWorld new generateWorld; open'>

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
	

	view addAnimation: (RTActiveAnimation new blockToExecute: [ self beat ]).
	self refreshView.
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
				(world at: t y at: t x) = 1 ifTrue: [ color := Color brown ] ]
			ifFalse: [ color := Color black ].
		
		e model = (0 @ 0) ifTrue: [ color := Color red ].
		e trachelShape color: color.
	 ].
	view signalUpdate.

	
]

{ #category : #initialization }
MNWorld >> size [
	^ 50 @ 30
]
