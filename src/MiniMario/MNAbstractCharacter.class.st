Class {
	#name : #MNAbstractCharacter,
	#superclass : #Object,
	#instVars : [
		'position',
		'nbOfMovements',
		'phase',
		'game',
		'isFalling',
		'isJumping'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNAbstractCharacter >> beat [
	isJumping ifTrue: [ 
		phase == #goingUp ifTrue: [ self translateBy: 0 @ -1 ].
		phase == #doingDown ifTrue: [ self translateBy: 0 @ 1 ].
		nbOfMovements := nbOfMovements + 1.
		nbOfMovements = 5 ifTrue: [ phase := #doingDown ].
		nbOfMovements = 10 ifTrue: [ isJumping := false ].
		 ].
	
	self isJumping ifFalse: [ 
		"is mario falling?"
		(game getCellAt: self position + (0 @ 1)) = 0 
			ifTrue: [ 
				self setAsFalling.
				self translateBy: 0 @ 1 ]
			ifFalse: [ self setAsNotFalling ] ].
]

{ #category : #actions }
MNAbstractCharacter >> canGoToward: aDeltaPosition [
	^ (game getCellAt: position + aDeltaPosition) = 0
]

{ #category : #accessing }
MNAbstractCharacter >> game [
	^ game
]

{ #category : #accessing }
MNAbstractCharacter >> game: anObject [
	game := anObject
]

{ #category : #initialization }
MNAbstractCharacter >> initialize [
	super initialize.
	isJumping := false.
	position := 0 @ 0.
	isFalling := true.
]

{ #category : #accessing }
MNAbstractCharacter >> isFalling [
	^ isFalling
]

{ #category : #'as yet unclassified' }
MNAbstractCharacter >> isJumping [
	^ isJumping
]

{ #category : #'as yet unclassified' }
MNAbstractCharacter >> jump [
	isJumping ifTrue: [ ^ self ].
	isFalling ifTrue: [ ^ self ].
	(game getCellAt: (self position + (0 @ 1))) = 0 ifTrue: [ ^ self ].
	isJumping := true.
	phase := #goingUp.
	nbOfMovements := 0.
]

{ #category : #'as yet unclassified' }
MNAbstractCharacter >> moveLeft [
	self translateBy: -1 @ 0
]

{ #category : #'as yet unclassified' }
MNAbstractCharacter >> moveRight [
	self translateBy: 1 @ 0
]

{ #category : #accessing }
MNAbstractCharacter >> position [
	^ position
]

{ #category : #initialization }
MNAbstractCharacter >> setAsFalling [
	isFalling := true
]

{ #category : #initialization }
MNAbstractCharacter >> setAsNotFalling [
	isFalling := false
]

{ #category : #actions }
MNAbstractCharacter >> translateBy: aDeltaPosition [
	(self canGoToward: aDeltaPosition) ifFalse: [ ^ self ].
	position := position + aDeltaPosition
]

{ #category : #actions }
MNAbstractCharacter >> translateTo: aPosition [
	position := aPosition
]
