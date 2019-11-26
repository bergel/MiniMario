Class {
	#name : #MNElement,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNElement >> beat [
	
]

{ #category : #'as yet unclassified' }
MNElement >> collideWith: aPosition [
	^ position extent: extent
]

{ #category : #accessing }
MNElement >> position [
	^ position
]

{ #category : #actions }
MNElement >> translateBy: aDeltaPosition [
	position := position + aDeltaPosition
]

{ #category : #actions }
MNElement >> translateTo: aPosition [
	position := aPosition
]
