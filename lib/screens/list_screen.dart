import 'package:flutter/material.dart';
import '../utilities/data_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_screen.dart';
import 'search_screen.dart';
import 'status_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ContentList extends StatefulWidget {
  @override
  _ContentListState createState() => _ContentListState();
}

SharedPreferences prefs;

Future<void> assignPrefs() async {
  prefs = await SharedPreferences.getInstance();
}

void saveList(List list, String key) {
  prefs.setStringList(key, list);
}

List<String> getList(String key) {
  assignPrefs();
  List list = prefs.getStringList(key);
  return list;
}

List<DataModel> myList = [];
List<DataModel> futureList = [];
List<DataModel> recommendationsList = [];

List<String> myJson = [];
List<String> futureJson = [];
List<String> recommendationsJson = [];

bool _isButtonTapped = false;

int pageNo = 0;

final controller = PageController(initialPage: 0);

class _ContentListState extends State<ContentList> {
  @override
  Widget build(BuildContext context) {
    assignPrefs();

    if (prefs != null) {
      if (getList('my') != null) {
        setState(() {
          myJson = getList('my');
        });
      }

      if (getList('future') != null) {
        setState(() {
          futureJson = getList('future');
        });
      }

      if (getList('recommendations') != null) {
        setState(() {
          recommendationsJson = getList('recommendations');
        });
      }
    }

    if (myJson.length != null) {
      setState(() {
        myList = [];
      });
      for (String jsonString in myJson) {
        setState(() {
          myList.add(
            DataModel.fromJson(
              json.decode(jsonString),
            ),
          );
        });
      }
    }

    if (futureJson.length != null) {
      setState(() {
        futureList = [];
      });
      for (String jsonString in futureJson) {
        setState(() {
          futureList.add(
            DataModel.fromJson(
              json.decode(jsonString),
            ),
          );
        });
      }
    }

    if (recommendationsJson.length != null) {
      setState(() {
        recommendationsList = [];
      });
      for (String jsonString in recommendationsJson) {
        setState(() {
          recommendationsList.add(
            DataModel.fromJson(
              json.decode(jsonString),
            ),
          );
        });
      }
    }

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
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final DataModel item = myList.removeAt(oldIndex);
                      final String jsonItem = myJson.removeAt(oldIndex);
                      myList.insert(newIndex, item);
                      myJson.insert(newIndex, jsonItem);
                      saveList(myJson, 'my');
                    });
                  },
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
                                myJson.remove(
                                  json.encode(
                                    item.toJson(),
                                  ),
                                );
                                saveList(myJson, 'my');
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
                                              myJson.add(
                                                json.encode(
                                                  item.toJson(),
                                                ),
                                              );
                                              saveList(myJson, 'my');
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddScreen(
                                          properName: item.contentName,
                                          type: item.contentType,
                                          posterURL: item.contentPosterURL,
                                          language: item.contentLanguage,
                                          plot: item.contentPlot,
                                          genre: item.contentGenre,
                                          rating: item.contentRating,
                                          cast: item.contentCast,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final DataModel item = futureList.removeAt(oldIndex);
                      final String jsonItem = futureJson.removeAt(oldIndex);
                      futureList.insert(newIndex, item);
                      futureJson.insert(newIndex, jsonItem);
                      saveList(futureJson, 'future');
                    });
                  },
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
                                futureJson.remove(
                                  json.encode(
                                    item.toJson(),
                                  ),
                                );
                                saveList(futureJson, 'future');
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
                                              futureList.add(item);
                                              futureJson.add(
                                                json.encode(
                                                  item.toJson(),
                                                ),
                                              );
                                              saveList(futureJson, 'future');
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddScreen(
                                          properName: item.contentName,
                                          type: item.contentType,
                                          posterURL: item.contentPosterURL,
                                          language: item.contentLanguage,
                                          plot: item.contentPlot,
                                          genre: item.contentGenre,
                                          rating: item.contentRating,
                                          cast: item.contentCast,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final DataModel item =
                          recommendationsList.removeAt(oldIndex);
                      final String jsonItem =
                          recommendationsJson.removeAt(oldIndex);
                      recommendationsList.insert(newIndex, item);
                      recommendationsJson.insert(newIndex, jsonItem);
                      saveList(recommendationsJson, 'recommendations');
                    });
                  },
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
                                recommendationsJson.remove(
                                  json.encode(
                                    item.toJson(),
                                  ),
                                );
                                saveList(
                                    recommendationsJson, 'recommendations');
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
                                              recommendationsList.add(item);
                                              recommendationsJson.add(
                                                json.encode(
                                                  item.toJson(),
                                                ),
                                              );
                                              saveList(recommendationsJson,
                                                  'recommendations');
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddScreen(
                                          properName: item.contentName,
                                          type: item.contentType,
                                          posterURL: item.contentPosterURL,
                                          language: item.contentLanguage,
                                          plot: item.contentPlot,
                                          genre: item.contentGenre,
                                          rating: item.contentRating,
                                          cast: item.contentCast,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                  // onReorder: (int start, int current) {
                  //   // dragging from top to bottom
                  //   if (start < current) {
                  //     int end = current - 1;
                  //     DataModel startItem = recommendationsList[start];
                  //     int i = 0;
                  //     int local = start;
                  //     do {
                  //       recommendationsList[local] =
                  //           recommendationsList[++local];
                  //       i++;
                  //     } while (i < end - start);
                  //     recommendationsList[end] = startItem;
                  //   }
                  //   // dragging from bottom to top
                  //   else if (start > current) {
                  //     DataModel startItem = recommendationsList[start];
                  //     for (int i = start; i > current; i--) {
                  //       recommendationsList[i] = recommendationsList[i - 1];
                  //     }
                  //     recommendationsList[current] = startItem;
                  //   }
                  // },
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
