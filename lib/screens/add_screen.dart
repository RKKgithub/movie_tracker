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
  final String rating;

  AddScreen(
      {this.properName,
      this.genre,
      this.language,
      this.plot,
      this.posterURL,
      this.type,
      this.rating});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (widget.properName == 'sorry can\'t fetch data')
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.amberAccent,
              child: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                if (myList.length == 0) {
                  DataModel dataModel = DataModel(
                    contentGenre: widget.genre,
                    contentLanguage: widget.language,
                    contentName: widget.properName,
                    contentPlot: widget.plot,
                    contentPosterURL: widget.posterURL,
                    contentType: widget.type,
                    contentRating: widget.rating,
                  );

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
                } else {
                  for (DataModel item in myList) {
                    if (widget.properName == item.contentName) {
                      // Scaffold.of(context).showSnackBar(
                      //   SnackBar(
                      //     content:
                      //         Text("title already exists in your list"),
                      //   ),
                      // );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      DataModel dataModel = DataModel(
                        contentGenre: widget.genre,
                        contentLanguage: widget.language,
                        contentName: widget.properName,
                        contentPlot: widget.plot,
                        contentPosterURL: widget.posterURL,
                        contentType: widget.type,
                        contentRating: widget.rating,
                      );

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
                    }
                  }
                }
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: (widget.properName == 'sorry can\'t fetch data')
                    ? Center(
                        child: Container(
                          child: Text(
                              'Sorry can\'t fetch data. Try checking the Title Name.'),
                        ),
                      )
                    : ListView(
                        children: [
                          Text(
                            widget.properName,
                            style: GoogleFonts.pacifico(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Type:  ${widget.type}',
                            style: GoogleFonts.handlee(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          Image(
                            image: NetworkImage(widget.posterURL),
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Language:  ${widget.language}',
                              style: GoogleFonts.handlee(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              widget.plot,
                              style: GoogleFonts.handlee(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'IMDB:  ${widget.rating}',
                              style: GoogleFonts.handlee(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            widget.genre,
                            style: GoogleFonts.handlee(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
