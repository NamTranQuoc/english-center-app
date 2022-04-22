import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String categoryName;
  final String categoryId;
  final String categoryUrlImage;
  final StringCallback callback;
  const CardItem( this.categoryName,  this.categoryId,  this.categoryUrlImage, this.callback);
  @override
  Widget build(BuildContext context) {
    bool isSelect = false;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0, horizontal: 8.0
      ),
      child: OutlinedButton(
        child: Text(categoryName),
        onPressed: () {
          callback(categoryName);
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          primary: Colors.black,
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
      /*child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: (){
                      callback(categoryName);
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            categoryName,
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),*/
    );
  }
}

typedef void StringCallback(String val);