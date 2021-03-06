Class {
	#name : #MNMonster,
	#superclass : #MNAbstractCharacter,
	#instVars : [
		'movingLeft',
		'pauseCounter'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNMonster >> beat [
	super beat.
	pauseCounter := pauseCounter + 1.
	pauseCounter < 10 ifTrue: [ ^ self ].
	pauseCounter := 0.
"	movingLeft ifTrue: [ movingLeft := self canGoToward: -1 @ 0 ] ifFalse: [ movingLeft := self canGoToward: 1 @ 0 ]."
	
	movingLeft 
		ifTrue: [ (self canGoToward: -1 @ 0) ifFalse: [ movingLeft := false ] ]
		ifFalse: [ (self canGoToward: 1 @ 0) ifFalse: [ movingLeft := true ] ].
	
	
	movingLeft ifTrue: [ self moveLeft ] ifFalse: [ self moveRight ].
]

{ #category : #initialization }
MNMonster >> initialize [
	super initialize.
	movingLeft := true.
	pauseCounter := 0
]
