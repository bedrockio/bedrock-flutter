import 'package:bedrock_flutter/src/network/meta_data.dart';
import 'package:bedrock_flutter/src/products/cubit/product_repository.dart';
import 'package:bedrock_flutter/src/products/model/product_model.dart';
import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  final List<Product> products = [];

  MetaData? meta;

  ProductCubit(this.repository) : super(ProductsLoading());

  void fetchProducts({String? query, String? sortField, String? sortOrder}) async {
    try {
      if ((meta != null && (meta!.total > meta!.skip + meta!.limit)) || meta == null) {
        if (meta == null) {
          emit(ProductsLoading());
        } else {
          emit(ProductsLoadingMore());
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
        emit(ProductsLoaded(products));
      }
    } catch (e) {
      ErrorHelper.broadcastError(e);
    }
  }
}
