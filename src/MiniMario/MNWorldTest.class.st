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
MNWorldTest >> testRunSeveralBeats [
	"No error should occur"
	100 timesRepeat: [ world beat ]
]
