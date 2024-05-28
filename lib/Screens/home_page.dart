import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../Boxes/Boxes.dart';
import '../Models/Cloths.dart';
import '../common/common_dropdown.dart';
import '../common/common_text.dart';
import 'add_dialog.dart';
import 'edit_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Function to delete cloth item
  Future<void> delete(Cloths cloths) async {
    try {
      await cloths.delete();
    } catch (e) {
      // Handle any potential errors
      print("Error deleting cloth: $e");
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  // Function to add cloth item
  Future<void> addCloth() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AddClothesDialog(),
      );
    } catch (e) {
      // Handle any potential errors
      print("Error adding cloth: $e");
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Cloths Counting",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepOrangeAccent,
          toolbarHeight: 90,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<Cloths>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<Cloths>();
            return ListView.builder(
              itemCount: box.length,
              // reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DateTime? date = data[index].date;
                String formattedDate = date != null
                    ? DateFormat('dd-MM-yyyy').format(date)
                    : 'No Date';
                return Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClothesItemWidget(
                          title: 'Date',
                          value: formattedDate,
                        ),
                        ClothesItemWidget(
                          title: 'Pants',
                          value: data[index].pants.toString(),
                        ),
                        // Add other ClothesItemWidget here
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => EditClothesDialog(
                                    cloths: data[index],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.note_alt_outlined,
                                color: Colors.orange,
                                size: 35,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                try {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this item?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await delete(data[index]);
                                              const snackBar = SnackBar(
                                                content: Text(
                                                  'Your request was successfully deleted',
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                backgroundColor: Colors.red,
                                                padding: EdgeInsets.all(16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                behavior:
                                                SnackBarBehavior.floating,
                                                duration: Duration(seconds: 5),
                                                dismissDirection:
                                                DismissDirection.horizontal,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } catch (e) {
                                  print("Error deleting item: $e");
                                }
                              },
                              icon: const Icon(
                                Icons.done_all,
                                color: Colors.red,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              await addCloth();
            } catch (e) {
              print("Error adding cloth: $e");
            }
          },
          backgroundColor: Colors.deepOrangeAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: BorderSide.strokeAlignCenter,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
