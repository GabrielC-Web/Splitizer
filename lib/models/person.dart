class Participant {
  final String name;
  final List<double> purchases;

  Participant({required this.name, this.purchases = const []});

  factory Participant.fromMap(Map<String, dynamic> map) {
    // Note: It's common for JSON to parse to Map<String, dynamic>
    // So, we typically expect `dynamic` values.
    return Participant(
      name: map['name'] as String,
      purchases: map['purchases'] as List<double>,
    );
  }

  double get subtotal => purchases.fold(0.0, (sum, item) => sum + item);
}