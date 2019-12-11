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
MNWorldTest >> testFalling [
	self assert: mario isFalling.
	world beat.
	self assert: mario isFalling.
	100 timesRepeat: [ world beat ].
	self deny: mario isFalling.

]

{ #category : #tests }
MNWorldTest >> testJumping [
	100 timesRepeat: [ world beat ].
	self assert: mario position equals: 2 @ 5.
	self deny: mario isJumping.
	mario jump.
	self assert: mario isJumping.
	world beat.
	self assert: mario position equals: (2 @ 4)
]

{ #category : #tests }
MNWorldTest >> testJumpingAndFalling [
	self assert: mario isFalling.
	self deny: mario isJumping.
	world beat.
	self assert: mario isFalling.
	self deny: mario isJumping.
	
	mario jump.
	self assert: mario isFalling.
	self deny: mario isJumping.

]

{ #category : #tests }
MNWorldTest >> testMonster [
	| w |
	w := MNWorld new.
	w addMonster: (MNMonster new translateTo: 3 @ 3).
	100 timesRepeat: [ w beat ]
]

{ #category : #tests }
MNWorldTest >> testMonster2 [
	| w |
	w := MNWorld new.
	w addMonster: (MNMonster new translateTo: 2 @ 2).
	100 timesRepeat: [ w beat ]
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
	self assert: mario position equals: 2 @ 5.
]

{ #category : #tests }
MNWorldTest >> testWhatMarioSees [
	"No error should occur"
	| s |
	s := world whatMarioSees
]
