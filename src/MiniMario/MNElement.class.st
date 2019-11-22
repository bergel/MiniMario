Class {
	#name : #MNElement,
	#superclass : #Object,
	#instVars : [
		'roassalElement'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNElement >> beat [
	
]

{ #category : #'as yet unclassified' }
MNElement >> collideWith: anotherElement [
	^ self element encompassingRectangle intersects: anotherElement element encompassingRectangle
]

{ #category : #'as yet unclassified' }
MNElement >> createElement [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MNElement >> element [
	roassalElement ifNil: [ roassalElement := self createElement ].
	^ roassalElement
	
]

{ #category : #actions }
MNElement >> translateBy: aDeltaPosition [
	self element translateBy: aDeltaPosition
]

{ #category : #actions }
MNElement >> translateTo: aPosition [
	self element translateTo: aPosition
]
