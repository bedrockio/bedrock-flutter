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
          backgroundColor: BRColors.primary,
          centerTitle: true,
          title: const Text('Products', style: TextStyle(color: BRColors.secondary)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: BRColors.secondary,
                ))
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
            bloc: context.read<ProductCubit>()..fetchProducts(),
            buildWhen: (previous, current) => current is ProductsLoading || current is ProductsLoaded,
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator(color: BRColors.primary));
              }

              if (state is ProductsLoaded) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: BRPadding.xsmall),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return ProductListItem(product: state.products[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(thickness: 1, color: BRColors.primary.withOpacity(0.5));
                    },
                    itemCount: state.products.length);
              }

              return Container();
            }));
  }
}
