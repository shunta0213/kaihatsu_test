import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  const Date({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double devidceWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('M月d日');
    String formattedDate = dateFormat.format(now);

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        width: devidceWidth * 0.8,
        height: deviceHeight * 0.2,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          formattedDate,
          style: TextStyle(
            fontSize: 60,
          ),
        ),
      ),
    );
  }
}
