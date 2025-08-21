part of 'product_cubit.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(List<Product> products) = _Loaded;
  const factory ProductState.loadingMore() = _LoadingMore;
  const factory ProductState.error({DioException? error}) = _Error;
}
