import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../Boxes/Boxes.dart';
import '../Models/Cloths.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _pantsController = TextEditingController();
  final _shirtsController = TextEditingController();
  final _tshirtsController = TextEditingController();
  final _shortsController = TextEditingController();
  final _towelController = TextEditingController();
  final _tracksController = TextEditingController();
  final _coverController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _pantsController.dispose();
    _shirtsController.dispose();
    _tshirtsController.dispose();
    _shortsController.dispose();
    _towelController.dispose();
    _tracksController.dispose();
    _coverController.dispose();
    super.dispose();
  }

  void clearAll() {
    _dateController.clear();
    _pantsController.clear();
    _shirtsController.clear();
    _tshirtsController.clear();
    _shortsController.clear();
    _towelController.clear();
    _tracksController.clear();
    _coverController.clear();
  }

  void delete(Cloths cloths) async {
    await cloths.delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Cloths Counting",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              )),
          backgroundColor: Colors.deepOrangeAccent,
          toolbarHeight: 90,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)))),
      body: ValueListenableBuilder<Box<Cloths>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<Cloths>();
            return ListView.builder(
                itemCount: box.length,
                reverse: true,
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
                          Text(
                            'Date: $formattedDate',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Pants: ${data[index].pants}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Shirts: ${data[index].shirts}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Tshirts: ${data[index].tshirts}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Shorts: ${data[index].shorts}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Towel: ${data[index].towel}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Tracks: ${data[index].tracks}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Covers: ${data[index].covers}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total Cloths: ${data[index].total}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _editDialog(
                                        data[index],
                                        data[index].date as DateTime,
                                        data[index].pants as int,
                                        data[index].shirts as int,
                                        data[index].tshirts as int,
                                        data[index].shorts as int,
                                        data[index].towel as int,
                                        data[index].tracks as int,
                                        data[index].covers as int);
                                  },
                                  icon: const Icon(
                                    Icons.note_alt_outlined,
                                    color: Colors.orange,
                                    size: 35,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirm Delete'),
                                          content: Text('Are you sure you want to delete this item?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                delete(data[index]); // Call the delete function if confirmed
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.done_all,
                                    color: Colors.red,
                                    size: 35,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _addDialog();
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.add, color: Colors.white, shadows: [
          Shadow(
              color: Colors.black,
              blurRadius: BorderSide.strokeAlignCenter,
              offset: Offset(2, 2))
        ]),
      ),
    ));
  }

  Future<void> _editDialog(Cloths cloths, DateTime date, int pants, int shirts,
      int tshirts, int shorts, int towel, int tracks, int covers) async {
    _dateController.text = DateFormat('yyyy-MM-dd').format(date);
    _pantsController.text = pants.toString();
    _shirtsController.text = shirts.toString();
    _tshirtsController.text = tshirts.toString();
    _shortsController.text = shorts.toString();
    _towelController.text = towel.toString();
    _tracksController.text = tracks.toString();
    _coverController.text = covers.toString();

    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async {
              clearAll();
              return true;
            },
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Edit Clothes list',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _dateController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 30)),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      _dateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Date',
                                  hintText: 'Enter Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a date';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _pantsController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _pantsController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        15,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Pants",
                                        hintText: "Enter Pants",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 14) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _shirtsController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _shirtsController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        15,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Shirts",
                                        hintText: "Enter Shirts",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 14) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _tshirtsController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _tshirtsController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        15,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "T-shirt",
                                        hintText: "Enter T-shirt",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 14) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _shortsController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _shortsController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        15,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Shorts",
                                        hintText: "Enter Shorts",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 14) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _towelController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _towelController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        3,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Towel",
                                        hintText: "Enter Towel",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 14) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _coverController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _coverController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        3,
                                        (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Covers",
                                        hintText: "Enter Covers",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 3) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _tracksController.text, // Initially select 0
                                      onChanged: (newValue) {
                                        setState(() {
                                          _tracksController.text =
                                              newValue.toString();
                                        });
                                      },
                                      items: List.generate(
                                        15,
                                            (index) => DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(index.toString()),
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Tracks",
                                        hintText: "Enter Tracks",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value < 0 ||
                                            value > 14) {
                                          return 'Please select a value between 0 and 14';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                                  const SizedBox(width: 10.0),
                                  const Expanded(child: Text("")),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      clearAll();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style:
                                          TextStyle(color: Colors.deepOrange),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        int pants1 =
                                        _pantsController.text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _pantsController.text);
                                        int shirt1 =
                                        _shirtsController.text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _shirtsController.text);
                                        int tshirts1 = _tshirtsController
                                            .text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _tshirtsController.text);
                                        int shorts1 =
                                        _shortsController.text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _shortsController.text);
                                        int towels1 =
                                        _towelController.text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _towelController.text);
                                        int tracks1 =
                                        _tracksController.text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _tracksController.text);
                                        int covers1 =
                                        _coverController.text.isEmpty
                                            ? 0
                                            : int.parse(
                                            _coverController.text);

                                        int total = pants1 +
                                            shirt1 +
                                            tshirts1 +
                                            shorts1 +
                                            towels1 +
                                            tracks1 +
                                            covers1;



                                        cloths.date = DateTime.parse(
                                            _dateController.text);
                                        cloths.pants =
                                            pants1;
                                        cloths.shirts =
                                            shirt1;
                                        cloths.tshirts =
                                            tshirts1;
                                        cloths.shorts =
                                            shorts1;
                                        cloths.towel =
                                            towels1;
                                        cloths.tracks =
                                            tracks1;
                                        cloths.covers =
                                            covers1;
                                        cloths.total = total;

                                        cloths.save();

                                        Navigator.pop(context);
                                        clearAll();
                                      }
                                    },
                                    child: const Text(
                                      'Edit',
                                      style:
                                          TextStyle(color: Colors.deepOrange),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                ))));
      },
    );
  }

  Future<void> _addDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async {
              clearAll();
              return true;
            },
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: SingleChildScrollView(
                    child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Add Clothes list',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    controller: _dateController,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 15)),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          _dateController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Date',
                                      hintText: 'Enter Date',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a date';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _pantsController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            15,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Pants",
                                            hintText: "Enter Pants",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 14) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _shirtsController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            15,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Shirts",
                                            hintText: "Enter Shirts",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 14) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _tshirtsController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            15,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "T-Shirts",
                                            hintText: "Enter T-Shirt",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 14) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _shortsController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            15,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Shorts",
                                            hintText: "Enter Shorts",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 14) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _towelController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            3,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Towels",
                                            hintText: "Enter Towels",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 3) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _coverController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            2,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Covers",
                                            hintText: "Enter Covers",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 3) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<int>(
                                          value: 0, // Initially select 0
                                          onChanged: (newValue) {
                                            setState(() {
                                              _tracksController.text =
                                                  newValue.toString();
                                            });
                                          },
                                          items: List.generate(
                                            15,
                                            (index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(index.toString()),
                                            ),
                                          ),
                                          decoration: InputDecoration(
                                            labelText: "Tracks",
                                            hintText: "Enter Tracks",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value < 0 ||
                                                value > 14) {
                                              return 'Please select a value between 0 and 14';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      const Expanded(child: Text("")),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          clearAll();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      TextButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            int pants1 =
                                                _pantsController.text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        _pantsController.text);
                                            int shirt1 =
                                                _shirtsController.text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        _shirtsController.text);
                                            int tshirts1 = _tshirtsController
                                                    .text.isEmpty
                                                ? 0
                                                : int.parse(
                                                    _tshirtsController.text);
                                            int shorts1 =
                                                _shortsController.text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        _shortsController.text);
                                            int towels1 =
                                                _towelController.text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        _towelController.text);
                                            int tracks1 =
                                                _tracksController.text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        _tracksController.text);
                                            int covers1 =
                                                _coverController.text.isEmpty
                                                    ? 0
                                                    : int.parse(
                                                        _coverController.text);

                                            int total = pants1 +
                                                shirt1 +
                                                tshirts1 +
                                                shorts1 +
                                                towels1 +
                                                tracks1 +
                                                covers1;

                                            final data = Cloths(
                                                date: DateTime.parse(
                                                    _dateController.text),
                                                pants: pants1,
                                                shirts: shirt1,
                                                tshirts: tshirts1,
                                                shorts: shorts1,
                                                towel: towels1,
                                                tracks: tracks1,
                                                covers: covers1,
                                                total: total);

                                            final box = Boxes.getData();
                                            box.add(data);

                                            data.save();
                                            print(box);
                                            Navigator.pop(context);
                                            clearAll();
                                          }
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]))
                      ]),
                ))));
      },
    );
  }
}
