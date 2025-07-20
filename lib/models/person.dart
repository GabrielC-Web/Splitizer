class Participant {
  final String name;
  final List<double> purchases;

  Participant({required this.name, this.purchases = const []});

  double get subtotal => purchases.fold(0.0, (sum, item) => sum + item);
}