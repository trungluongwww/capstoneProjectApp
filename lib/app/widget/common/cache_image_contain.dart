// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roomeasy/app/widget/common/center_content_something_loading.dart';

class CacheImageContain extends StatelessWidget {
  final String url;
  const CacheImageContain({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: url,
      placeholder: (context, url) => const CenterContentSomethingLoading(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
