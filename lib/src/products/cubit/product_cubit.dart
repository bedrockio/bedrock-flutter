import 'package:bedrock_flutter/src/products/cubit/product_repository.dart';
import 'package:bedrock_flutter/src/products/model/product_list_response.dart';
import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductsLoading());

  void fetchProducts() async {
    emit(ProductsLoading());
    try {
      final response = await repository.getProducts();

      emit(ProductsLoaded(response));
    } catch (e) {
      ErrorHelper.broadcastError(e);
    }
  }
}
