import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/Cloths.dart';
import '../common/common_dropdown.dart';

class EditClothesDialog extends StatefulWidget {
  final Cloths cloths;

  EditClothesDialog({
    required this.cloths,
  });

  @override
  State<EditClothesDialog> createState() => _EditClothesDialogState();
}

class _EditClothesDialogState extends State<EditClothesDialog> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _pantsController = TextEditingController();
  final _shirtsController = TextEditingController();
  final _tshirtsController = TextEditingController();
  final _shortsController = TextEditingController();
  final _towelController = TextEditingController();
  final _tracksController = TextEditingController();
  final _coverController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    _dateController.text =
        DateFormat('yyyy-MM-dd').format(widget.cloths.date ?? DateTime.now());
    _pantsController.text = widget.cloths.pants.toString();
    _shirtsController.text = widget.cloths.shirts.toString();
    _tshirtsController.text = widget.cloths.tshirts.toString();
    _shortsController.text = widget.cloths.shorts.toString();
    _towelController.text = widget.cloths.towel.toString();
    _tracksController.text = widget.cloths.tracks.toString();
    _coverController.text = widget.cloths.covers.toString();

    return Dialog(
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
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 7)),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            // Also update the widget.cloths.date
                            widget.cloths.date = pickedDate;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdown(
                          labelText: "Pants",
                          hintText: "Enter Pants",
                          value: int.parse(_pantsController.text),
                          onChanged: (newValue) {
                            setState(() {
                              _pantsController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            15,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        CustomDropdown(
                          value: int.parse(_shirtsController.text),
                          labelText: "Shirts",
                          hintText: "Enter Shirts",
                          onChanged: (newValue) {
                            setState(() {
                              _shirtsController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            15,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdown(
                          value: int.parse(_tshirtsController.text),
                          labelText: "T-shirt",
                          hintText: "Enter T-shirt",
                          onChanged: (newValue) {
                            setState(() {
                              _tshirtsController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            15,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        CustomDropdown(
                          value: int.parse(_shortsController.text),
                          labelText: "Shorts",
                          hintText: "Enter Shorts",
                          onChanged: (newValue) {
                            setState(() {
                              _shortsController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            15,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdown(
                          value: int.parse(_towelController.text),
                          labelText: "Towel",
                          hintText: "Enter Towel",
                          onChanged: (newValue) {
                            setState(() {
                              _towelController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            3,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        CustomDropdown(
                          value: int.parse(_coverController.text),
                          labelText: "Covers",
                          hintText: "Enter Covers",
                          onChanged: (newValue) {
                            setState(() {
                              _coverController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            3,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdown(
                          value: int.parse(_tracksController.text),
                          labelText: "Tracks",
                          hintText: "Enter Tracks",
                          onChanged: (newValue) {
                            setState(() {
                              _tracksController.text = newValue.toString();
                              updateClothValues();
                            });
                          },
                          items: List.generate(
                            15,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
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
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateClothValues();

                              widget.cloths.save();

                              Navigator.pop(context);
                              clearAll();
                              const snackBar = SnackBar(
                                content: Text(
                                    'Your request was successfully updated',
                                    style: TextStyle(fontSize: 16)),
                                backgroundColor: Colors.deepOrangeAccent,
                                elevation: 5.0,
                                padding: EdgeInsets.all(16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 5),
                                dismissDirection: DismissDirection.horizontal,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBar,
                              );
                            }
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateClothValues() {
    int pants1 =
        _pantsController.text.isEmpty ? 0 : int.parse(_pantsController.text);
    int shirt1 =
        _shirtsController.text.isEmpty ? 0 : int.parse(_shirtsController.text);
    int tshirts1 = _tshirtsController.text.isEmpty
        ? 0
        : int.parse(_tshirtsController.text);
    int shorts1 =
        _shortsController.text.isEmpty ? 0 : int.parse(_shortsController.text);
    int towels1 =
        _towelController.text.isEmpty ? 0 : int.parse(_towelController.text);
    int tracks1 =
        _tracksController.text.isEmpty ? 0 : int.parse(_tracksController.text);
    int covers1 =
        _coverController.text.isEmpty ? 0 : int.parse(_coverController.text);

    int total =
        pants1 + shirt1 + tshirts1 + shorts1 + towels1 + tracks1 + covers1;

    widget.cloths.date = DateTime.parse(_dateController.text);
    widget.cloths.pants = pants1;
    widget.cloths.shirts = shirt1;
    widget.cloths.tshirts = tshirts1;
    widget.cloths.shorts = shorts1;
    widget.cloths.towel = towels1;
    widget.cloths.tracks = tracks1;
    widget.cloths.covers = covers1;
    widget.cloths.total = total;
  }
}
