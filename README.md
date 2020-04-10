# MiniMario
Game skeleton for machine learning.

You can open the game, in which Mario is steered by the keyboard (keys: W A D) with:
```Smalltalk
MNWorld new open.
```

Using the [Pharo implementation of NEAT](https://github.com/bergel/NEAT), you can evolve a neural network with:
```Smalltalk
neat := NEAT new.
neat numberOfInputs: 121.
neat numberOfOutputs: 3.
neat populationSize: 200.

neat fitness: [ :ind | 
	w := MNWorld new.
	w mario: (MNAIMario new network: ind).
	450 timesRepeat: [ w beat. ].
	w mario position x ].

neat numberOfGenerations: 120.
neat run.
```
