Class {
	#name : #MNMario,
	#superclass : #Object,
	#instVars : [
		'position',
		'phase',
		'nbOfMovements',
		'isAnimated',
		'game',
		'isFalling'
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

{ #category : #accessing }
MNMario >> game [
	^ game
]

{ #category : #accessing }
MNMario >> game: anObject [
	game := anObject
]

{ #category : #initialization }
MNMario >> initialize [
	super initialize.
	isAnimated := false.
	position := 0 @ 0.
	isFalling := false.
]

{ #category : #'as yet unclassified' }
MNMario >> isAnimated [
	^ isAnimated
]

{ #category : #accessing }
MNMario >> isFalling [
	^ isFalling
]

{ #category : #'as yet unclassified' }
MNMario >> jump [
	isAnimated ifTrue: [ ^ self ].
	isFalling ifTrue: [ ^ self ].
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

{ #category : #initialization }
MNMario >> setAsFalling [
	isFalling := true
]

{ #category : #initialization }
MNMario >> setAsNotFalling [
	isFalling := false
]

{ #category : #actions }
MNMario >> translateBy: aDeltaPosition [
	(game getCellAt: (position + aDeltaPosition)) = 0 ifFalse: [ ^ self ].
	position := position + aDeltaPosition
]

{ #category : #actions }
MNMario >> translateTo: aPosition [
	position := aPosition
]
