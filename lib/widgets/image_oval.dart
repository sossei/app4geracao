import 'package:flutter/material.dart';

class OvalImage extends StatelessWidget {
  final String networkurl;
  final String placeholder;
  final double size;

  const OvalImage({Key key, this.networkurl, this.placeholder, this.size = 48})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _buildIamge();
  }

  _buildIamge() {
    return Container(
      height: size,
      width: size,
      child: ClipOval(
        child: networkurl != null
            ? FadeInImage.assetNetwork(
                placeholder: placeholder,
                image: networkurl,
                fit: BoxFit.fitWidth,
                imageErrorBuilder: (context, obj, _) {
                  return Image.asset(placeholder);
                },
              )
            : Image.asset(placeholder),
      ),
    );
  }
}
