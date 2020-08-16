import 'package:flutter/material.dart';
import 'networking.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_model.dart';
import 'list_screen.dart';
import 'status_screen.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String titleName;
  String properName;
  String genre;
  String plot;
  String language;
  String posterURL;
  String type;

  void updateUI(String titleName) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$URL?apiKey=$apiKey&t=$titleName');
    var titleData = await networkHelper.getData();
    setState(() {
      properName = (titleData['Title'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Title'];
      plot = (titleData['Plot'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Plot'];
      genre = (titleData['Genre'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Genre'];
      language = (titleData['Language'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Language'];
      posterURL = (titleData['Poster'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Poster'];
      type = (titleData['Type'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Type'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: kTextFieldInputDecoration,
                      onChanged: (value) {
                        titleName = value;
                      },
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  color: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      updateUI(titleName);
                    },
                  ),
                )
              ],
            ),
            Text(
              (properName == null) ? '' : properName,
              style: GoogleFonts.pacifico(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              (type == null) ? '' : type,
              style: GoogleFonts.pacifico(),
            ),
            (posterURL == null)
                ? Text('Search Title')
                : Image(
                    height: 300,
                    image: NetworkImage(posterURL),
                  ),
            Text(
              (language == null) ? '' : language,
              style: GoogleFonts.lato(),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              (plot == null) ? '' : plot,
              style: GoogleFonts.lato(),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              (genre == null) ? '' : genre,
              style: GoogleFonts.lato(),
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
              color: Colors.greenAccent,
              onPressed: (properName == 'sorry can\'t fetch data')
                  ? null
                  : () {
                      DataModel dataModel = DataModel(
                          contentGenre: genre,
                          contentLanguage: language,
                          contentName: properName,
                          contentPlot: plot,
                          contentPosterURL: posterURL,
                          contentType: type);

                      showModalBottomSheet(
                        context: context,
                        builder: (context) => StatusScreen((status) {
                          setState(() {
                            dataModel.status = status;
                            myList.add(dataModel);
                          });
                          Navigator.pop(context);
                        }),
                      );
                    },
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
