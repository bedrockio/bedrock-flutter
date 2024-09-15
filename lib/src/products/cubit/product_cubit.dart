import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/src/network/meta_data.dart';
import '/src/products/cubit/product_repository.dart';
import '/src/products/model/product_model.dart';
import '/src/utils/error_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_cubit.freezed.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  final List<Product> products = [];

  MetaData? meta;

  ProductCubit(this.repository) : super(const ProductState.loading());

  void fetchProducts({String? query, String? sortField, String? sortOrder}) async {
    try {
      if ((meta != null && (meta!.total > meta!.skip + meta!.limit)) || meta == null) {
        if (meta == null) {
          emit(const ProductState.loading());
        } else {
          emit(const ProductState.loadingMore());
        }

        final response = await repository.getProducts(
            query: query,
            sortField: sortField,
            sortOrder: sortOrder,
            skip: meta != null ? (meta!.skip + meta!.limit) : null);

        if (meta == null) {
          products.clear();
        }

        meta = response.meta;

        products.addAll(response.items);
        emit(ProductState.loaded(products));
      }
    } catch (e) {
      emit(const ProductState.error());

      ErrorHelper.broadcastError(e);
    }
  }
}
