import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPhotoPage extends StatelessWidget {
  final String _imageUrl;
  final String _token;

  DetailPhotoPage(this._imageUrl, this._token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Center(
          child: Hero(
            tag: "photo",
            child: CachedNetworkImage(
              placeholder: CircularProgressIndicator(),
              imageUrl: _imageUrl,
              fit: BoxFit.contain,
              httpHeaders: {"Authorization": "Bearer $_token"},
            ),
          ),
        ),
      ),
    );
  }
}
