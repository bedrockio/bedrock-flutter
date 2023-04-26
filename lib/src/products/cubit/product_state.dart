part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductState {
  final ProductListResponse data;

  const ProductsLoaded(this.data);
}

class ProductsLoading extends ProductState {}
