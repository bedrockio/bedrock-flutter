import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageRender extends StatelessWidget {
  final String url;
  final Size? size;

  const ImageRender(this.url, {super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: DefaultCacheManager(),
      imageUrl: url,
      width: size?.width ?? 50,
      height: size?.height ?? 50,
      progressIndicatorBuilder: (context, url, progress) {
        return const Center(child: CircularProgressIndicator(color: BRColors.primary));
      },
      errorWidget: (context, _, __) {
        return ImagePlaceholder(size: Size(size?.width ?? 50, size?.height ?? 50));
      },
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final Size? size;

  const ImagePlaceholder({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size?.width ?? 50,
        height: size?.height ?? 50,
        decoration: BoxDecoration(color: BRColors.primaryAccent, borderRadius: BorderRadius.circular(BRPadding.small)));
  }
}
