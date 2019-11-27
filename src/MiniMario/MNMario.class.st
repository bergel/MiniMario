Class {
	#name : #MNMario,
	#superclass : #Object,
	#instVars : [
		'position',
		'phase',
		'nbOfMovements',
		'isAnimated'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNMario >> beat [
	isAnimated ifTrue: [ 
		phase == #goingUp ifTrue: [ self translateBy: 0 @ -1 ].
		phase == #doingDown ifTrue: [ self translateBy: 0 @ 1 ].
		nbOfMovements := nbOfMovements + 1.
		nbOfMovements = 5 ifTrue: [ phase := #doingDown ].
		nbOfMovements = 10 ifTrue: [ isAnimated := false ].
		 ]
]

{ #category : #initialization }
MNMario >> initialize [
	super initialize.
	isAnimated := false.
	position := 0 @ 0
]

{ #category : #'as yet unclassified' }
MNMario >> isAnimated [
	^ isAnimated
]

{ #category : #'as yet unclassified' }
MNMario >> jump [
	isAnimated ifTrue: [ ^ self ].
	
	isAnimated := true.
	phase := #goingUp.
	nbOfMovements := 0.
]

{ #category : #'as yet unclassified' }
MNMario >> moveLeft [
	self translateBy: -1 @ 0
]

{ #category : #'as yet unclassified' }
MNMario >> moveRight [
	self translateBy: 1 @ 0
]

{ #category : #accessing }
MNMario >> position [
	^ position
]

{ #category : #actions }
MNMario >> translateBy: aDeltaPosition [
	position := position + aDeltaPosition
]

{ #category : #actions }
MNMario >> translateTo: aPosition [
	position := aPosition
]
