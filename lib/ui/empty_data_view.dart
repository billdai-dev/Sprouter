import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imgWidth = constraints.maxWidth * 0.33;
        double imgHeight = imgWidth * 3 / 4;
        return Container(
          width: imgWidth,
          height: constraints.maxHeight,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/images/not_found_404.png",
                width: imgWidth,
                height: imgHeight,
              ),
              Text(
                "暫無資料",
                style: Theme.of(context).primaryTextTheme.title,
              )
            ],
          ),
        );
      },
    );
  }
}
