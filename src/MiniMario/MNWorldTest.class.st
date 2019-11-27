Class {
	#name : #MNWorldTest,
	#superclass : #TestCase,
	#instVars : [
		'mario',
		'world'
	],
	#category : #MiniMario
}

{ #category : #running }
MNWorldTest >> setUp [
	super setUp.
	world := MNWorld new.
	mario := world mario.
]

{ #category : #tests }
MNWorldTest >> testJumping [
	100 timesRepeat: [ world beat ].
	self assert: mario position equals: 2 @ 15.
	self deny: mario isAnimated.
	mario jump.
	self assert: mario isAnimated.
	world beat.
	self assert: mario position equals: (2 @ 14)
]

{ #category : #tests }
MNWorldTest >> testMovingMario [
	"No error should occur"
	self assert: mario position equals: 2 @ 2.
	mario moveRight.
	self assert: mario position equals: 3 @ 2.
	mario moveLeft.
	self assert: mario position equals: 2 @ 2.	
	mario moveLeft.
	self assert: mario position equals: 2 @ 2.
]

{ #category : #tests }
MNWorldTest >> testRunSeveralBeats [
	"No error should occur"
	self assert: mario position equals: 2 @ 2.
	100 timesRepeat: [ world beat ].
	self assert: mario position equals: 2 @ 15.
]
