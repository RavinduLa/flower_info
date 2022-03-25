/*
* IT19180526 (S.A.N.L.D. Chandrasiri)
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
* https://youtu.be/21vHY9P90jE
* https://youtu.be/G4INTsatBew
* https://youtu.be/w3krSTSGmaw
*
* Firebase storage
* https://youtu.be/dmZ9Tg9k13U
*
* Image capture & picker
* https://youtu.be/MSv38jO4EJk
*
* Date Formatting
* https://pub.dev/packages/intl
*
* */

import 'dart:io';
import 'package:flower_info/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/diseases/disease_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiseaseAdd extends StatefulWidget {
  const DiseaseAdd({Key? key}) : super(key: key);

  static String routeName = Constants.routeNameDiseaseAdd;

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
  final _imageUrl = Constants.diseaseSampleImage;
  String imageLink = "";
  UploadTask? task;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.diseaseCreate),
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
                            Constants.logoImagePath,
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
                    helperText: '',
                    labelText: Constants.diseaseLabelName,
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.fieldValidation;
                    }
                    return null;
                  },
                  controller: _name,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    helperText: '',
                    labelText: Constants.diseaseLabelLook,
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.fieldValidation;
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
                    helperText: '',
                    labelText: Constants.diseaseLabelCause,
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.fieldValidation;
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
                    helperText: '',
                    labelText: Constants.diseaseLabelTreat,
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.fieldValidation;
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
                    helperText: '',
                    labelText: Constants.diseaseLabelPrevent,
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.fieldValidation;
                    }
                    return null;
                  },
                  controller: _prevent,
                  minLines: 1,
                  maxLines: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: processingData,
                    child: const Text(
                      Constants.diseaseAdd,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Image Selector Method
  Future selectImage(ImageSource source) async {
    if (kDebugMode) {
      print("Image Selection Process!");
    }

    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 10);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      if (kDebugMode) {
        print("Image Selection Successful!");
      }
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
        _notification(Constants.processingData);

        String newId = "";

        String currentTime = DateFormat.yMd().add_jm().format(DateTime.now());

        Disease disease = Disease(
          name: _name.text,
          look: _look.text,
          cause: _cause.text,
          treat: _treat.text,
          prevent: _prevent.text,
          image: _imageUrl,
          created: currentTime,
        );

        DocumentReference res = await _createDisease(disease).then((value) {
          newId = value.id;
          return value;
        });

        if (kDebugMode) {
          print(res);
        }

        // If image selected -> Image will upload
        if (image != null) {
          _notification(Constants.imageUploading);
          await uploadImage(newId);
          updateImageUrl(newId, imageLink);
        }

        _clearFields();
        _notification(Constants.diseaseCreationDone);
      }
    } else {
      _dialogMessage(Constants.imageNotFound, Constants.imageSelectOrTakePhoto, Constants.ok);
    }
  }

  // Image Uploading Process
  Future uploadImage(String newId) async {
    if (kDebugMode) {
      print("Uploading Image Process!");
    }

    if (image == null) return;

    // CRUD: Upload Image to Firebase Storage
    task = DiseaseApi.uploadImage(newId, image!);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // Set the image link
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
        content: Center(
          heightFactor: 1,
          widthFactor: double.infinity,
          child: Text(message),
        ),
      ),
    );
  }

  // Common Dialog Message
  void _dialogMessage(String title, String content, String btnMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              child: Text(btnMessage),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
