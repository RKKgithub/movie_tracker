import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tracker/utilities/data_model.dart';
import 'list_screen.dart';
import 'status_screen.dart';

class AddScreen extends StatefulWidget {
  final String properName;
  final String genre;
  final String plot;
  final String language;
  final String posterURL;
  final String type;

  AddScreen(
      {this.properName,
      this.genre,
      this.language,
      this.plot,
      this.posterURL,
      this.type});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: ThemeData.dark().accentColor,
        title: Text(
          'Title Info',
          style: GoogleFonts.baskervville(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        (widget.properName == null) ? '' : widget.properName,
                        style: GoogleFonts.pacifico(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        (widget.type == null) ? '' : widget.type,
                        style: GoogleFonts.pacifico(fontSize: 15),
                      ),
                      (widget.posterURL == null)
                          ? Text('Search Title')
                          : Image(
                              image: NetworkImage(widget.posterURL),
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        (widget.language == null) ? '' : widget.language,
                        style: GoogleFonts.lato(),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          (widget.plot == null) ? '' : widget.plot,
                          style: GoogleFonts.lato(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        (widget.genre == null) ? '' : widget.genre,
                        style: GoogleFonts.lato(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              color: ThemeData.dark().accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: (widget.properName == 'sorry can\'t fetch data')
                  ? null
                  : () {
                      DataModel dataModel = DataModel(
                          contentGenre: widget.genre,
                          contentLanguage: widget.language,
                          contentName: widget.properName,
                          contentPlot: widget.plot,
                          contentPosterURL: widget.posterURL,
                          contentType: widget.type);

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
                      //Navigator.pop(context);
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: Text(
                  'Next',
                  style: GoogleFonts.philosopher(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
