import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/disease_model.dart';

class DiseaseAdd extends StatefulWidget {
  const DiseaseAdd({Key? key}) : super(key: key);

  static String routeName = "/admin/disease/disease-add";

  @override
  State<DiseaseAdd> createState() => _DiseaseAddState();
}

class _DiseaseAddState extends State<DiseaseAdd> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _look = TextEditingController();
  final _cause = TextEditingController();
  final _treat = TextEditingController();
  final _prevent = TextEditingController();
  final _imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/disease_images%2Fdisease1.jpg?alt=media&token=1ed7ed0f-d257-474d-a42d-dcdf7a83dc8b";
  String imageLink = "";
  UploadTask? task;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Disease Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'Name of Diseases/Pests',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _name,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'What Does it Look Like?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _look,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'What Causes it?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _cause,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'How to Treat it?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _treat,
                  minLines: 1,
                  maxLines: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: ' ',
                    labelText: 'How to Prevent it?',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _prevent,
                  minLines: 1,
                  maxLines: 10,
                ),
                ElevatedButton(
                  onPressed: processingData,
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  // New Document Creating Process
  void processingData() async {
    if (image != null) {
      if (_formKey.currentState!.validate()) {
        _notification('Processing Data');

        String newId = "";

        Disease disease = Disease(
            name: _name.text,
            look: _look.text,
            cause: _cause.text,
            treat: _treat.text,
            prevent: _prevent.text,
            image: _imageUrl);

        DocumentReference res = await _createDisease(disease).then((value) {
          newId = value.id;
          return value;
        });

        print(res);

        if (image != null) {
          _notification('Image Uploading!');
          await uploadImage(newId);
          updateImageUrl(newId, imageLink);
        }

        _clearFields();
        _notification('Done!');
      }
    } else {
      _notification('Please select an image or take a photo!');
    }
  }

  // Image Uploading Process
  Future uploadImage(String newId) async {
    if (image == null) return;
    task = DiseaseApi.uploadImage(newId, image!);
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
  Future<DocumentReference> _createDisease(Disease disease) {
    return DiseaseApi.addDisease(disease);
  }

  // CRUD : Update Image URL Method Caller
  void updateImageUrl(String documentId, String link) {
    DiseaseApi.updateImageLink(documentId, link);
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
    _name.clear();
    _look.clear();
    _cause.clear();
    _treat.clear();
    _prevent.clear();
  }
}
