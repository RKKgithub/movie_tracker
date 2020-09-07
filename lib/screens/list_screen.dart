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
List<DataModel> futureList = [];
List<DataModel> recommendationsList = [];

bool deltaClicked = false;
bool _isButtonTapped = false;

int pageNo = 0;

final controller = PageController(initialPage: 0);

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
          child: PageView(
            onPageChanged: (int page) {
              setState(() {
                pageNo = page;
              });
            },
            controller: controller,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ReorderableListView(
                  header: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'My List',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fenix(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  children: [
                    for (DataModel item in myList)
                      Padding(
                        key: Key(item.contentName),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Builder(
                          builder: (context) => Dismissible(
                            background: Container(color: Colors.red),
                            key: Key(item.contentName),
                            onDismissed: (direction) {
                              setState(() {
                                myList.remove(item);
                              });

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Text("${item.contentName} removed"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!_isButtonTapped) {
                                            _isButtonTapped = true;
                                            setState(() {
                                              myList.add(item);
                                            });
                                            Future.delayed(
                                                Duration(
                                                  seconds: 4,
                                                ), () {
                                              _isButtonTapped = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Undo',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                            item.status = status;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReorderableListView(
                  header: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'To Watch List',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fenix(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  children: [
                    for (DataModel item in futureList)
                      Padding(
                        key: Key(item.contentName),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Builder(
                          builder: (context) => Dismissible(
                            background: Container(color: Colors.red),
                            key: Key(item.contentName),
                            onDismissed: (direction) {
                              setState(() {
                                futureList.remove(item);
                              });

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Text("${item.contentName} removed"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!_isButtonTapped) {
                                            _isButtonTapped = true;
                                            setState(() {
                                              myList.add(item);
                                            });
                                            Future.delayed(
                                                Duration(
                                                  seconds: 4,
                                                ), () {
                                              _isButtonTapped = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Undo',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.blueGrey[700],
                              child: ListTile(
                                title: Text((futureList.length == null)
                                    ? 'nothing added to list'
                                    : item.contentName),
                                subtitle: Text((futureList.length == null)
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
                                            item.status = status;
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
                      ),
                  ],
                  onReorder: (int start, int current) {
                    // dragging from top to bottom
                    if (start < current) {
                      int end = current - 1;
                      DataModel startItem = futureList[start];
                      int i = 0;
                      int local = start;
                      do {
                        futureList[local] = futureList[++local];
                        i++;
                      } while (i < end - start);
                      futureList[end] = startItem;
                    }
                    // dragging from bottom to top
                    else if (start > current) {
                      DataModel startItem = futureList[start];
                      for (int i = start; i > current; i--) {
                        futureList[i] = futureList[i - 1];
                      }
                      futureList[current] = startItem;
                    }
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ReorderableListView(
                  header: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Recommendations List',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fenix(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  children: [
                    for (DataModel item in recommendationsList)
                      Padding(
                        key: Key(item.contentName),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Builder(
                          builder: (context) => Dismissible(
                            background: Container(color: Colors.red),
                            key: Key(item.contentName),
                            onDismissed: (direction) {
                              setState(() {
                                recommendationsList.remove(item);
                              });

                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Text("${item.contentName} removed"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!_isButtonTapped) {
                                            _isButtonTapped = true;
                                            setState(() {
                                              myList.add(item);
                                            });
                                            Future.delayed(
                                                Duration(
                                                  seconds: 4,
                                                ), () {
                                              _isButtonTapped = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Undo',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.blueGrey[700],
                              child: ListTile(
                                title: Text((recommendationsList.length == null)
                                    ? 'nothing added to list'
                                    : item.contentName),
                                subtitle: Text((recommendationsList.length ==
                                        null)
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
                                            item.status = status;
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
                      ),
                  ],
                  onReorder: (int start, int current) {
                    // dragging from top to bottom
                    if (start < current) {
                      int end = current - 1;
                      DataModel startItem = recommendationsList[start];
                      int i = 0;
                      int local = start;
                      do {
                        recommendationsList[local] =
                            recommendationsList[++local];
                        i++;
                      } while (i < end - start);
                      recommendationsList[end] = startItem;
                    }
                    // dragging from bottom to top
                    else if (start > current) {
                      DataModel startItem = recommendationsList[start];
                      for (int i = start; i > current; i--) {
                        recommendationsList[i] = recommendationsList[i - 1];
                      }
                      recommendationsList[current] = startItem;
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
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
            if (pageNo == 0) {
              setState(() {
                myList.length = myList.length;
              });
            } else if (pageNo == 1) {
              setState(() {
                futureList.length = futureList.length;
              });
            } else {
              setState(() {
                recommendationsList.length = recommendationsList.length;
              });
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
