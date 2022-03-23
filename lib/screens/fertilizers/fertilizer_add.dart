import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/models/fertilizer_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/constants.dart';

class FertilizerAdd extends StatefulWidget {
  const FertilizerAdd({Key? key}) : super(key: key);

  static String routeName = Constants.routNameFertilizerAdd;

  @override
  State<FertilizerAdd> createState() => _FertilizerAddState();
}

class _FertilizerAddState extends State<FertilizerAdd> {
  final _formKey = GlobalKey<FormState>();

  final _brandName = TextEditingController();
  String _type = "";
  final _nitrogienValue = TextEditingController();
  final _phosporosValue = TextEditingController();
  final _potasiamValue = TextEditingController();
  final _description = TextEditingController();
  final _imageUri = Constants.fertilizerSampleImage;

  String? selectedValue;
  String imageLink = "";
  UploadTask? task;
  File? image;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(Constants.fertilizerDropdownItemTextChemical),
          value: Constants.fertilizerDropdownItemTextChemical),
      const DropdownMenuItem(
          child: Text(Constants.fertilizerDropdownItemTextFoliar),
          value: Constants.fertilizerDropdownItemTextFoliar),
      const DropdownMenuItem(
          child: Text(Constants.fertilizerDropdownItemTextOrganic),
          value: Constants.fertilizerDropdownItemTextOrganic),
      const DropdownMenuItem(
          child: Text(Constants.fertilizerDropdownItemTextSimple),
          value: Constants.fertilizerDropdownItemTextSimple),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Fertilizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image != null
                        ? Image.file(
                            image!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/flower-info-logo.png',
                            height: 100,
                            width: 100,
                          ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () => selectImage(ImageSource.camera),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.folder,
                            size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () => selectImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: Constants.fertilizerLabelType,
                      labelStyle: TextStyle(color: Colors.green),
                      helperText: ' ',
                    ),
                    validator: (value) =>
                        value == null ? "Select a type" : null,
                    value: selectedValue,
                    // style: const TextStyle(
                    //   color: Colors.black,
                    //   fontSize: 16
                    // ),
                    focusColor: Colors.green,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        _type = selectedValue!;
                      });
                    },
                    items: dropdownItems),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    focusColor: Colors.green,
                    labelText: Constants.fertilizerLabelBrandName,
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _brandName,
                ),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.green)),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green),
                //     ),
                //     helperText: ' ',
                //     labelText: 'Type of fertilizer',
                //     labelStyle: TextStyle(
                //         color: Colors.green
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Please enter the field!";
                //     }
                //     return null;
                //   },
                //   controller: _type,
                //   minLines: 1,
                //   maxLines: 10,
                // ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelNitrogenValue,
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _nitrogienValue,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelPhosphorusValue,
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _phosporosValue,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: '',
                    labelText: Constants.fertilizerLabelPotassiumValue,
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _potasiamValue,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: '',
                    labelText: Constants.fertilizerLabelDescription,
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _description,
                  minLines: 1,
                  maxLines: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 2.0, right: 2.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSubmit,
                      child: const Text('Add Fertilizer'),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Image Selector Method
  Future selectImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 10);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (error) {
      if (kDebugMode) {
        print('Failed to select image : $error');
      }
    }
  }

  void _onSubmit() async {
    if (image != null) {
      if (_formKey.currentState!.validate()) {
        String newId = "";

        Fertilizer fertilizer = Fertilizer(
          brandName: _brandName.text,
          type: _type,
          nitrogienValue: _nitrogienValue.text,
          phosporosValue: _phosporosValue.text,
          potasiamValue: _potasiamValue.text,
          description: _description.text,
          image: _imageUri,
        );

        DocumentReference result =
            await _createFertilizer(fertilizer).then((value) {
          newId = value.id;
          return value;
        });
        if (kDebugMode) {
          print(result);
        }
        if (image != null) {
          _notification('Image Uploading!');
          await uploadImage(newId);
          updateImageUrl(newId, imageLink);
        }
        _clearFields();
        _notification('Created successfully!');
        Navigator.pop(context);
      }
    } else {
      _notification('Please select an image or take a photo!');
    }
  }

  // Image Uploading Process
  Future uploadImage(String newId) async {
    if (image == null) return;
    task = FertilizerApi.uploadImage(newId, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      imageLink = urlDownload;
    });

    if (kDebugMode) {
      print('Image Link : $imageLink');
    }
  }

// CRUD : Create Method Caller
  Future<DocumentReference> _createFertilizer(Fertilizer fertilizer) {
    return FertilizerApi.addFertilizer(fertilizer);
  }

  // CRUD : Update Image URL Method Caller
  void updateImageUrl(String documentId, String link) {
    FertilizerApi.updateImageLink(documentId, link);
  }

// Common Notification
  void _notification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
            widthFactor: double.infinity,
            heightFactor: 1,
            child: Text(message)),
      ),
    );
  }

// Clear Form Fields
  void _clearFields() {
    _brandName.clear();
    _nitrogienValue.clear();
    _phosporosValue.clear();
    _potasiamValue.clear();
    _description.clear();
  }
}
