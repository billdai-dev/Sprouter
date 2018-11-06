import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoomable_image/zoomable_image.dart';

class DetailPhotoPage extends StatelessWidget {
  final String _title;
  final String _imageUrl;
  final String _token;

  DetailPhotoPage(this._title, this._imageUrl, this._token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          _title ?? "",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Center(
          child: Hero(
            tag: "photo",
            child: ZoomableImage(
              CachedNetworkImageProvider(
                _imageUrl,
                headers: {"Authorization": "Bearer $_token"},
              ),
              backgroundColor: Colors.transparent,
              placeholder: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
