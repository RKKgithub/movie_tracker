import 'package:flutter/material.dart';
import '../utilities/data_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_screen.dart';
import 'status_screen.dart';

class ContentList extends StatefulWidget {
  @override
  _ContentListState createState() => _ContentListState();
}

List<DataModel> myList = [];
bool deltaClicked = false;

class _ContentListState extends State<ContentList> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: ThemeData.dark().accentColor,
        title: Text(
          'Movie Tracker',
          style: GoogleFonts.baskervville(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                final item = myList[index].contentName;
                return Dismissible(
                  background: Container(color: Colors.red),
                  key: Key(item),
                  onDismissed: (direction) {
                    setState(() {
                      myList.removeAt(index);
                    });

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$item removed"),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text((myList.length == null)
                        ? 'nothing added to list'
                        : myList[index].contentName),
                    subtitle: Text((myList.length == null)
                        ? 'nothing added to list'
                        : 'Type: ${myList[index].contentType} | Status: ${myList[index].status}'),
                    trailing: IconButton(
                      icon: Icon(Icons.change_history),
                      onPressed: () {
                        setState(() {
                          deltaClicked = true;
                        });
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => StatusScreen(
                            (status) {
                              setState(() {
                                myList[index].status = status;
                              });
                            },
                          ),
                        ).then((value) {
                          setState(() {
                            deltaClicked = false;
                          });
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.search),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SearchScreen(),
          ).then((value) {
            setState(() {
              print(myList.length);
            });
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
