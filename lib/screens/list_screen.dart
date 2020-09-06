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

List<Padding> listItems = [];

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
          child: ReorderableListView(
            children: [
              for (DataModel item in myList)
                Padding(
                  key: Key(item.contentName),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Dismissible(
                    background: Container(color: Colors.red),
                    key: Key(item.contentName),
                    onDismissed: (direction) {
                      setState(() {
                        myList.remove(item);
                      });

                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item.contentName} removed"),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.blueGrey[700],
                      child: ListTile(
                        title: Text((myList.length == null)
                            ? 'nothing added to list'
                            : item.contentName),
                        subtitle: Text((myList.length == null)
                            ? 'nothing added to list'
                            : 'Type: ${item.contentType} | Comment: ${item.status}'),
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
                                    print('oo');
                                    item.status = status;
                                    print(item.status);
                                  });
                                  Navigator.pop(context);
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
                    ),
                  ),
                ),
            ],
            onReorder: (int start, int current) {
              // dragging from top to bottom
              if (start < current) {
                int end = current - 1;
                DataModel startItem = myList[start];
                int i = 0;
                int local = start;
                do {
                  myList[local] = myList[++local];
                  i++;
                } while (i < end - start);
                myList[end] = startItem;
              }
              // dragging from bottom to top
              else if (start > current) {
                DataModel startItem = myList[start];
                for (int i = start; i > current; i--) {
                  myList[i] = myList[i - 1];
                }
                myList[current] = startItem;
              }
              setState(() {});
            },
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
              myList.length = myList.length;
            });
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
