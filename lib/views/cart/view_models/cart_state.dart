// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartState {
  final int quantity;
  CartState({
    required this.quantity,
  });

  CartState copyWith({
    int? quantity,
  }) {
    return CartState(
      quantity: quantity ?? this.quantity,
    );
  }
}
