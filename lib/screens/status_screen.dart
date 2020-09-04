import 'package:flutter/material.dart';
import 'list_screen.dart';

class StatusScreen extends StatelessWidget {
  final Function addStatusCallBack;

  StatusScreen(this.addStatusCallBack);

  @override
  Widget build(BuildContext context) {
    String status;

    return Container(
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Status',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                status = newText;
              },
            ),
            FlatButton(
              color: Colors.lightBlueAccent,
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                addStatusCallBack(status);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContentList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
