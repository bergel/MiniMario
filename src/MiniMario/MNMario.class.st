Class {
	#name : #MNMario,
	#superclass : #MNElement,
	#instVars : [
		'phase',
		'nbOfMovements',
		'isAnimated'
	],
	#category : #MiniMario
}

{ #category : #'as yet unclassified' }
MNMario >> beat [
	isAnimated ifTrue: [ 
		phase == #goingUp ifTrue: [ self translateBy: 0 @ -2 ].
		phase == #doingDown ifTrue: [ self translateBy: 0 @ 2 ].
		nbOfMovements := nbOfMovements + 1.
		nbOfMovements = 20 ifTrue: [ phase := #doingDown ].
		nbOfMovements = 40 ifTrue: [ isAnimated := false ].
		 ]
]

{ #category : #'as yet unclassified' }
MNMario >> createElement [
	| b |
	b := RTBox new size: 10; color: Color red.
	^ b element
]

{ #category : #initialization }
MNMario >> initialize [
	super initialize.
	isAnimated := false.
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
	self translateBy: -10 @ 0
]

{ #category : #'as yet unclassified' }
MNMario >> moveRight [
	self translateBy: 10 @ 0
]
