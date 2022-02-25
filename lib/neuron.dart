library neat;

class Neuron {
  num activationResponse;

  Neuron(this.activationResponse);

  //defined as having a recurrent loop
  bool get recurrent {
    throw new UnimplementedError();
  }
}