import 'package:flutter/material.dart';
import 'data_model.dart';
import 'add_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'status_screen.dart';

class ContentList extends StatefulWidget {
  @override
  _ContentListState createState() => _ContentListState();
}

List<DataModel> myList = [];

class _ContentListState extends State<ContentList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            'My List',
            style: GoogleFonts.baskervville(),
          ),
          Container(
            height: 700,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return (myList.length == null)
                          ? Text(
                              'nothing in content list',
                              style: TextStyle(color: Colors.white),
                            )
                          : Card(
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
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            StatusScreen((status) {
                                          setState(() {
                                            myList[index].status = status;
                                          });
                                          Navigator.pop(context);
                                        }),
                                      );
                                    }),
                              ),
                            );
                    },
                    childCount: myList.length,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
