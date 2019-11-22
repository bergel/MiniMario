Class {
	#name : #MNPlatform,
	#superclass : #MNElement,
	#instVars : [
		'platforms'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNPlatform >> createElement [
	| b |
	b := RTBox new size: 100; height: 10; color: Color brown.
	^ b element
]
