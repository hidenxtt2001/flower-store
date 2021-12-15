import 'package:flower_store/src/blocs/cart/cart_event.dart';
import 'package:flower_store/src/blocs/cart/cart_state.dart';
import 'package:flower_store/src/models/cart/cart_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(selectedProduct: null, cartProducts: [])) {
    on<CartBottomDialogAmountIncrementPressed>((event, emit) {
      if (state.selectedProduct == null) return;

      final selectedProduct = state.selectedProduct
          ?.copyWith(quantity: state.selectedProduct!.quantity + 1);
      final newState =
          state.copyWith(selectedProduct: Optional.ofNullable(selectedProduct));
      emit(newState);
    });
    on<CartBottomDialogAmountDecrementPressed>((event, emit) {
      final selectedProduct;
      if (state.selectedProduct == null) return;
      if (state.selectedProduct!.quantity <= 1) {
        selectedProduct = state.selectedProduct?.copyWith(quantity: 1);
        return;
      }
      selectedProduct = state.selectedProduct
          ?.copyWith(quantity: state.selectedProduct!.quantity - 1);
      emit(state.copyWith(
          selectedProduct: Optional.ofNullable(selectedProduct)));
    });
    on<CartBottomDialogPressed>((event, emit) {
      emit(state.copyWith(
          selectedProduct: Optional.ofNullable(event.selectedProduct)));
    });
    on<CartBottomDialogAddPress>((event, emit) {
      emit(state.copyWith(
          selectedProduct: Optional.ofNullable(state.selectedProduct),
          cartProducts: [...state.cartProducts, state.selectedProduct!]));
    });
  }
}
