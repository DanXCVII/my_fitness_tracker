import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OverviewTile extends StatelessWidget {
  final String imageLocation;
  final String value;
  final String label;

  const OverviewTile(
    this.value,
    this.label,
    this.imageLocation, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff1D1D1D),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 1,
            spreadRadius: 0.5,
            color: Colors.black26,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            imageLocation,
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
          Spacer(),
          Text(value, style: TextStyle(fontSize: 26)),
          Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 2),
            child: Text(label, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
