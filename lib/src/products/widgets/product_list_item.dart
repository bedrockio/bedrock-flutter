import 'package:bedrock_flutter/src/products/model/product_model.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/widgets/image_placeholder.dart';
import 'package:bedrock_flutter/src/network/upload_model.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: BRPadding.small, vertical: BRPadding.xsmall),
        child: Row(children: [
          (product.images.isNotEmpty)
              ? ImageRender(product.images.first.rawUrl)
              : const ImagePlaceholder(size: Size(50, 50)),
          const SizedBox(width: BRPadding.xsmall),
          Expanded(
              child: Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ))
        ]));
  }
}
