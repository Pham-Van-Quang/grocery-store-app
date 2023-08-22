import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/views/cart/view_models/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(quantity: 1));

  void increasement({int step = 1}) {
    emit(state.copyWith(quantity: state.quantity + step));
  }

  void decreasement({int step = 1}) {
    emit(state.copyWith(quantity: state.quantity - step));
  }
}
