enum Trans {
  send(1),
  receive(2);

  const Trans(this.value);
  final num value;
}