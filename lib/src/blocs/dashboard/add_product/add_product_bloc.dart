import 'package:dio/dio.dart';
import 'package:flower_store/src/blocs/dashboard/add_product/add_product_event.dart';
import 'package:flower_store/src/blocs/dashboard/add_product/add_product_state.dart';
import 'package:flower_store/src/services/product/product_provider.dart';
import 'package:flower_store/src/utils/helper/app_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState(loading: false)) {
    on<AddProductChooseImage>((event, emit) async {
      final image = await openImagePicker();
      if (image != null) {
        emit(state.copyWith(image: image.path));
      } else
        emit(state.copyWith(image: ""));
    });
    on<AddProductAddNewProduct>(
      (event, emit) async {
        emit(state.copyWith(loading: true));
        try {
          await ProductProvider().submitProduct(
              name: event.name,
              image: state.image,
              description: event.description,
              basePrice: event.basePrice);
          emit(state.copyWith(loading: false));
          if (event.onComplete != null) event.onComplete!(true);
        } on DioError catch (e) {
          print(e);
          print(" res ${e.response!.data}");
          emit(state.copyWith(loading: false));
          if (event.onComplete != null) event.onComplete!(false);
        } catch (e) {
          emit(state.copyWith(loading: false));
          await Future.delayed(Duration(milliseconds: 500));
          if (event.onComplete != null) event.onComplete!(false);
        }
      },
    );
  }
}
