Class {
	#name : #MNWorld,
	#superclass : #Object,
	#instVars : [
		'platforms',
		'mario'
	],
	#category : #MiniMario
}

{ #category : #initialization }
MNWorld >> addPlatform: aPlatform [
	platforms add: aPlatform
]

{ #category : #'as yet unclassified' }
MNWorld >> beat [
	platforms do: #beat.
	mario beat.
	
	mario isAnimated ifFalse: [ 
		(platforms noneSatisfy: [ :p | p collideWith: mario ])
			ifTrue: [ mario translateBy: 0 @ 1 ] ]
]

{ #category : #'as yet unclassified' }
MNWorld >> generateWorld [
	| worldWidth worldHeight r p |
	worldWidth := 1000.
	worldHeight := 300.
	r := Random seed: 42.
	20 timesRepeat: [ 
		p := MNPlatform new.
		p translateTo: (r nextInt: worldWidth) @ (r nextInt: worldHeight).
		self addPlatform: p ]
	
]

{ #category : #initialization }
MNWorld >> initialize [
	super initialize.
	mario := MNMario new.
	platforms := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
MNWorld >> mario [
	^ mario
]

{ #category : #'as yet unclassified' }
MNWorld >> open [
	<script: 'MNWorld new generateWorld; open'>

	| v |
	v := RTView new.
	platforms do: [ :p | v add: p element ].
	v add: mario element.
	v addAnimation: (RTActiveAnimation new blockToExecute: [ self beat ]).
	v open

]
