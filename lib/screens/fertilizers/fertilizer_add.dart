import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/models/fertilizer_model.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_admin_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FertilizerAdd extends StatefulWidget {
  const FertilizerAdd({Key? key}) : super(key: key);

  static String routeName = "/admin/fertilizer/fertilizer-add";

  @override
  State<FertilizerAdd> createState() => _FertilizerAddState();
}

class _FertilizerAddState extends State<FertilizerAdd> {

  final _formKey = GlobalKey<FormState>();

  final _brandName = TextEditingController();
  final _type = TextEditingController();
  final _nitrogienValue = TextEditingController();
  final _phosporosValue = TextEditingController();
  final _potasiamValue = TextEditingController();
  final _description = TextEditingController();
  final _imageUri = 'https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/fertilizer_images%2F81evxmRskyL._AA100_.jpg?alt=media&token=94d619eb-7756-4d86-b2f6-194f2f8b2ca6';

  String imageLink = "";
  UploadTask? task;
  File? image;

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
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      helperText: ' ',
                      focusColor: Colors.green,
                      labelText: 'Name of fertilizer brand',
                      labelStyle: TextStyle(
                          color: Colors.green
                      ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _brandName,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: 'Type of fertilizer',
                    labelStyle: TextStyle(
                        color: Colors.green
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _type,
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
                      labelText: 'Nitrogien(N) value',
                      labelStyle: TextStyle(
                          color: Colors.green
                      ),
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
                      labelText: 'Phosporos(P) value',
                      labelStyle: TextStyle(
                          color: Colors.green
                      ),
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
                      labelText: 'Potasiam(K) value',
                      labelStyle: TextStyle(
                          color: Colors.green
                      ),
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
                      labelText: 'Description',
                      labelStyle: TextStyle(
                          color: Colors.green
                      ),
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
          type: _type.text,
          nitrogienValue: _nitrogienValue.text,
          phosporosValue: _phosporosValue.text,
          potasiamValue: _potasiamValue.text,
          description: _description.text,
          image: _imageUri,
        );

        DocumentReference result = await _createFertilizer(fertilizer).then(
                (value) {
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
        _notification('Created sucssfully!');
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
        content: Text(message),
      ),
    );
  }

// Clear Form Fields
  void _clearFields() {
    _brandName.clear();
    _type.clear();
    _nitrogienValue.clear();
    _phosporosValue.clear();
    _potasiamValue.clear();
    _description.clear();
  }
}


