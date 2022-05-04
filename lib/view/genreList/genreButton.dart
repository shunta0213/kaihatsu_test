import 'package:flutter/material.dart';

import '../../const/images.dart';

/// ジャンルページのボタン
class GenreButton extends StatelessWidget {
  final double height;
  final Widget image;
  final String genre;

  const GenreButton(
      {required this.genre,
      required this.height,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: SizedBox(
          height: height,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/$genre'),
            child: image,
            style: buttonStyle(height),
          )),
    );
  }
}

ButtonStyle buttonStyle(double height) {
  return ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.black,
    fixedSize: Size(height - 12, height - 12),
    shape: const CircleBorder(
      side: BorderSide(
        color: Colors.black,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
  );
}
