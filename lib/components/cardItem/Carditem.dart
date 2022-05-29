import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String categoryName;
  final String categoryId;
  final StringCallback callback;

  const CardItem(this.categoryName, this.categoryId, this.callback);

  @override
  Widget build(BuildContext context) {
    bool isSelect = false;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: OutlinedButton(
        child: Text(categoryName),
        onPressed: () {
          callback(categoryId);
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          primary: Colors.black,
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}

typedef void StringCallback(String val);
