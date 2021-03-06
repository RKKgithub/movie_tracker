import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/constants.dart';
import 'package:movie_tracker/utilities/networking.dart';
import 'add_screen.dart';
import 'package:movie_tracker/utilities/data_model.dart';

class SearchScreen extends StatelessWidget {
  String titleName;
  String properName;
  String genre;
  String plot;
  String language;
  String posterURL;
  String type;
  String rating;
  String cast;

  Future<DataModel> updateUI(String titleName) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$URL?apiKey=$apiKey&t=$titleName');

    try {
      var titleData = await networkHelper.getData();
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
      rating = (titleData['imdbRating'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['imdbRating'];
      cast = (titleData['Actors'] == null)
          ? 'sorry can\'t fetch data'
          : titleData['Actors'];

      return DataModel(
        contentGenre: genre,
        contentLanguage: language,
        contentName: properName,
        contentPlot: plot,
        contentPosterURL: posterURL,
        contentType: type,
        contentRating: rating,
        contentCast: cast,
      );
    } catch (e) {
      print(e);
      return DataModel(
        contentGenre: null,
        contentLanguage: null,
        contentName: null,
        contentPlot: null,
        contentPosterURL: null,
        contentType: null,
        contentRating: null,
        contentCast: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Movie/Series Name',
                  hintStyle: GoogleFonts.philosopher(color: Colors.grey),
                ),
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  titleName = value;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: ThemeData.dark().accentColor,
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Cancel',
                    style: GoogleFonts.philosopher(
                        fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                ),
                FlatButton.icon(
                  color: ThemeData.dark().accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Search',
                    style: GoogleFonts.philosopher(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    var data = await updateUI(titleName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddScreen(
                          properName: data.contentName,
                          type: data.contentType,
                          posterURL: data.contentPosterURL,
                          language: data.contentLanguage,
                          plot: data.contentPlot,
                          genre: data.contentGenre,
                          rating: data.contentRating,
                          cast: data.contentCast,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
