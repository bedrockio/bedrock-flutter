import 'package:bedrock_flutter/src/network/upload_model.dart';
import 'package:bedrock_flutter/src/products/cubit/product_cubit.dart';
import 'package:bedrock_flutter/src/utils/constants/colors.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/widgets/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BRColors.black,
          centerTitle: true,
          title: const Text('Products', style: TextStyle(color: BRColors.white)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: BRColors.white,
                ))
          ],
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
            bloc: context.read<ProductCubit>()..fetchProducts(),
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator(color: BRColors.brown));
              }

              if (state is ProductsLoaded) {
                return ListView.separated(
                    padding: const EdgeInsets.only(top: BRPadding.xsmall),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: BRPadding.small, vertical: BRPadding.xsmall),
                          child: Row(children: [
                            (state.data.items[index].images.isNotEmpty)
                                ? ImageRender(state.data.items[index].images.first.rawUrl)
                                : const ImagePlaceholder(size: Size(50, 50)),
                            const SizedBox(width: BRPadding.xsmall),
                            Text(state.data.items[index].name)
                          ]));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(thickness: 1, color: BRColors.brown.withOpacity(0.5));
                    },
                    itemCount: state.data.items.length);
              }

              return Container();
            }));
  }
}
