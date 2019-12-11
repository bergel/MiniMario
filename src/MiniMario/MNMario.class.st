Class {
	#name : #MNMario,
	#superclass : #MNAbstractCharacter,
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNMario >> beat [
	super beat.
	self position x = (game size x - 1) ifTrue: [ game gameOver ].
	
	game monsters do: [ :m |
		(m position = self position) ifTrue: [ game gameOver ] ]
]
