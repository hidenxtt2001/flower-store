import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_store/src/blocs/auth/auth.dart';
import 'package:flower_store/src/models/base/bill/detail_bill.dart';

import 'package:flower_store/src/models/cart/cart_product.dart';
import 'package:flower_store/src/models/enums.dart';
import 'package:flower_store/src/models/invoice/customer.dart';
import 'package:flower_store/src/models/invoice/invoice.dart';
import 'package:flower_store/src/models/request/request.dart';
import 'package:flower_store/src/services/app_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final AuthBloc authBloc;
  CheckoutBloc(
      {required this.authBloc, required List<CartProduct> productsInCart})
      : super(CheckoutState(
          detailBills: productsInCart
              .map(
                (e) => DetailBill.fromCartProduct(cartProduct: e),
              )
              .toList(),
        )) {
    on<NameCustomerChanged>((event, emit) {
      emit(state.copyWith(nameCustomer: event.nameCustomer));
    });
    on<EmailCustomerChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PhoneCustomerChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });
    on<BillOrder>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        if ((authBloc.state as AuthenticationAuthenticated).staff.role ==
            RoleType.Seller) {
          _validation(state);
          await AppRepository().invoice.create(
                invoice: Invoice(
                  customer: Customer(
                    name: state.nameCustomer,
                    phone: state.phone,
                    email: state.email,
                  ),
                  details: state.detailBills,
                  totalPrice: state.detailBills
                      .map((e) => e.totalPrice)
                      .reduce((value, element) => value! + element!),
                ),
              );
        } else if ((authBloc.state as AuthenticationAuthenticated).staff.role ==
            RoleType.Warehouse) {
          await AppRepository().request.create(
                request: Request(
                  details: state.detailBills,
                  totalPrice: state.detailBills
                      .map((e) => e.totalPrice)
                      .reduce((value, element) => value! + element!),
                ),
              );
        }

        emit(state.copyWith(isSuccess: true));
      } catch (error) {
        await Future.delayed(Duration(milliseconds: 300));
        if (error is Response)
          emit(state.copyWith(isError: true, message: error.data["message"]));
        else
          emit(state.copyWith(isError: true, message: error.toString()));
      }
    });
  }
}

void _validation(CheckoutState state) {
  if (state.nameCustomer.trim().length <= 3) {
    throw new Exception('Name is not valid');
  }
  // Valid Phone
  if (state.phone.isNotEmpty) {
    final regexPhone = RegExp(r"(84|0[3|5|7|8|9])+([0-9]{8})\b");
    if (!regexPhone.hasMatch(state.phone))
      throw new Exception('Phone not valid');
  } else if (state.email.isNotEmpty) {
    // Valid Email
    final regexEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!regexEmail.hasMatch(state.email))
      throw new Exception('Email not valid');
  } else {
    throw new Exception('Please input info');
  }
}
