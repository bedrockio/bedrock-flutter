import '/src/products/cubit/product_cubit.dart';
import '/src/products/widgets/product_list_item.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductsScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      BlocProvider.of<ProductCubit>(context).fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Products'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                ))
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
            bloc: context.read<ProductCubit>()..fetchProducts(),
            buildWhen: (previous, current) =>
                current.maybeWhen(loading: () => true, loaded: (_) => true, error: (_) => true, orElse: () => false),
            builder: (context, state) {
              return state.maybeWhen(loading: () {
                return const Center(child: CircularProgressIndicator());
              }, loaded: (products) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: BRPadding.xsmall),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return ProductListItem(product: products[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(thickness: 1, color: BRColors.primary.withOpacity(0.5));
                    },
                    itemCount: products.length);
              }, orElse: () {
                return Container();
              });
            }));
  }
}
