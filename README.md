<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

NeuroEvolution of Augmenting Topologies for Flutter! Create and evolve a neural net for solving all (or at least some) of life's hard problems.

## Features

- Serialize your neural net to save and restore
- Doesn't require the tracking of innovation numbers, meaning you can run disconnected and still crossover later
- Includes the mutation of activation functions

## Getting started

1. Create a Neural Network with a certain number of inputs/outputs
2. Generate a new generation
3. Iterate through each genome of the generation
4. Set the inputs and call update, then get the outputs
5. Set the fitness of each genome and set it's fitness
6. Go back to Step 2 and continue until the fitness is good enough

## Usage

Here's an example of teaching a network to count from 0 to 9

```dart
var nn = NeuralNet(0, 1);
nn.createNextGeneration();
num currentFitness = 0;

for (int i=0; i<100; i++) {
  for (var g in nn.currentGeneration) {
    num fitness = 0;
    for (int i=0;i<10;i++) {
      var target = i;
      g.update();
      var result = g.getOutputs().toList().single;
      fitness += Activation.gaussian(result - target);
    }
    g.fitness = fitness;
  }
  nn.createNextGeneration();
}


```

