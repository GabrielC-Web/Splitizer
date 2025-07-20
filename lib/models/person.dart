class Participant {
  final String name;
  final List<Purchase> purchases;

  Participant({required this.name, this.purchases = const []});

  factory Participant.fromMap(Map<String, dynamic> map) {
    // Note: It's common for JSON to parse to Map<String, dynamic>
    // So, we typically expect `dynamic` values.
    return Participant(
      name: map['name'] as String,
      purchases: map['purchases'] as List<Purchase>,
    );
  }

  void removePurchase(int index) {
    purchases.removeAt(index);
  }

  double get subtotal => purchases.fold(0.0, (sum, item) => sum + item.amount);
}

class Purchase {
  final String item;
  final double amount;

  Purchase({required this.item, required this.amount});

  factory Purchase.fromMap(Map<String, dynamic> map) {
    // Note: It's common for JSON to parse to Map<String, dynamic>
    // So, we typically expect `dynamic` values.
    return Purchase(
      item: map['item'] as String,
      amount: map['amount'] as double,
    );
  }
}
