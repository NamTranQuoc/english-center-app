import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CircleItem extends StatelessWidget {
  final String name;
  final String numberOfStudent;
  final String price;
  final String schedule;

  const CircleItem(this.name, this.numberOfStudent, this.price, this.schedule);

  showDialogFunc(context, name) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'images/Ielts.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(3, 4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 55.0,
                height: 55.0,
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.green,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      AppLocalizations.of(context).labelSchedule +
                          ": " +
                          schedule,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      AppLocalizations.of(context).labelNumberOfStudent +
                          ": " +
                          numberOfStudent,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      AppLocalizations.of(context).labelPrice +
                          ": " +
                          price +
                          "VN??",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                      child: const Text("Register",
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        showDialogFunc(context, name);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        primary: Colors.red[200],
                      )))
            ],
          )
        ],
      ),
    );
  }
}
