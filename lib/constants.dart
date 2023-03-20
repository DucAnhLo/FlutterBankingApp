enum Trans {
  send(-1),
  receive(1);

  const Trans(this.value);
  final num value;
}