import 'package:equatable/equatable.dart';

import 'package:flower_store/src/blocs/dashboard/home/home_helper.dart';
import 'package:flower_store/src/models/product.dart';

class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeInitState extends HomeState {}

class HomeLoadSucess extends HomeState {
  final List<Product> productList;

  HomeLoadSucess({required this.productList});

  @override
  List<Object> get props => [productList];
}