import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_screen.dart';

class StatusScreen extends StatelessWidget {
  final Function addStatusCallBack;

  StatusScreen(this.addStatusCallBack);

  @override
  Widget build(BuildContext context) {
    String status;

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Comment',
                  hintStyle: GoogleFonts.philosopher(color: Colors.grey),
                ),
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  status = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FlatButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: ThemeData.dark().accentColor,
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
              label: Text(
                'OK',
                style:
                    GoogleFonts.philosopher(fontSize: 20, color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
                addStatusCallBack(status);
              },
            ),
          ),
        ],
      ),
    );
  }
}
