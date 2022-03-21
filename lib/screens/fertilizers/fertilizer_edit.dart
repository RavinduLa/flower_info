import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/models/fertilizer_model_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'fertilizer_admin_list.dart';

class FertilizerEdit extends StatefulWidget {
  const FertilizerEdit({Key? key}) : super(key: key);

  static String routeName = "/admin/fertilizer/fertilizer-edit";

  @override
  State<FertilizerEdit> createState() => _FertilizerEditState();
}

class _FertilizerEditState extends State<FertilizerEdit> {
  final _formKey = GlobalKey<FormState>();

  final _brandName = TextEditingController();
  final _type = TextEditingController();
  final _nitrogienValue = TextEditingController();
  final _phosporosValue = TextEditingController();
  final _potasiamValue = TextEditingController();
  final _description = TextEditingController();

  String _imageLink = "";
  UploadTask? task;
  File? image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final data = ModalRoute.of(context)!.settings.arguments as FertilizerSingleView;

    _brandName.text = data.fertilizer.brandName;
    _type.text = data.fertilizer.type;
    _nitrogienValue.text = data.fertilizer.nitrogienValue;
    _phosporosValue.text = data.fertilizer.phosporosValue;
    _potasiamValue.text = data.fertilizer.potasiamValue;
    _description.text = data.fertilizer.description;
    _imageLink = data.fertilizer.image;

    void _onSubmit() async {
      if(_formKey.currentState!.validate()) {
        FertilizerWithId fertilizer = FertilizerWithId(
          documentId: data.fertilizer.documentId,
          brandName: _brandName.text,
          type: _type.text,
          nitrogienValue: _nitrogienValue.text,
          phosporosValue: _phosporosValue.text,
          potasiamValue: _potasiamValue.text,
          description: _description.text,
          image: _imageLink,
        );

        Future<void> result = _updateFertilizer(fertilizer);

        if(image != null) {
          await uploadImage(data.fertilizer.documentId);
          updateImageUrl(data.fertilizer.documentId, _imageLink);
          if (kDebugMode) {
            print("Image Uploading Processed!");
          }
        }
        if (kDebugMode) {
          print(result);
        }
        _notification('Done!');
        Navigator.pushNamed(context, FertilizerAdmin.routeName);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Fertilizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
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
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                        : _imageLink.isNotEmpty
                        ? SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: data.fertilizer.image,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(
                            Icons.error,
                            size: 50,
                          ),
                        ),
                      ),
                    )
                        : Image.asset(
                      'assets/images/flower-info-logo.png',
                      height: 150,
                      width: 150,
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
                SizedBox(height: size.height * 0.05),
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
                    // prefixIcon: Icon(
                    //     Icons.description
                    // )
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
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    focusColor: Colors.green,
                    labelText: 'Type of fertilizer',
                    labelStyle: TextStyle(
                        color: Colors.green
                    ),
                    // prefixIcon: Icon(
                    //     Icons.description
                    // ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _type,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    focusColor: Colors.green,
                    labelText: 'Nitrogien(N) value',
                    labelStyle: TextStyle(
                        color: Colors.green
                    ),
                    // prefixIcon: Icon(
                    //     Icons.confirmation_number
                    // )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _nitrogienValue,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    focusColor: Colors.green,
                    labelText: 'Phosporos(P) value',
                    labelStyle: TextStyle(
                        color: Colors.green
                    ),
                    // prefixIcon: Icon(
                    //     Icons.confirmation_number
                    // )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _phosporosValue,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    helperText: '',
                    focusColor: Colors.green,
                    labelText: 'Potasiam(K) value',
                    labelStyle: TextStyle(
                        color: Colors.green
                    ),
                    // prefixIcon: Icon(
                    //     Icons.confirmation_number
                    // )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the field!";
                    }
                    return null;
                  },
                  controller: _potasiamValue,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    helperText: '',
                    focusColor: Colors.green,
                    labelText: 'Description',
                    labelStyle: TextStyle(
                        color: Colors.green
                    ),
                    // prefixIcon: Icon(
                    //     Icons.description
                    // )
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
                SizedBox(height: size.height * 0.01),
                Padding(
                    padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            //borderRadius : new BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 7,
                                offset: const Offset(0, 5), // changes position of shadow
                              ),
                            ],
                          ),
                          child: RaisedButton(
                            color: Colors.yellow,
                            splashColor: Colors.white,
                            onPressed: _onSubmit,
                            child: const Text(
                              'UPDATE',
                              style: TextStyle(color: Colors.black54, fontSize: 19,fontWeight: FontWeight.w700),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: const BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: size.height * 0.03),
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

  // Image Uploading Process
  Future uploadImage(String newId) async {
    if (image == null) return;
    task = FertilizerApi.uploadImage(newId, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      _imageLink = urlDownload;
    });

    if (kDebugMode) {
      print('Image Link : $_imageLink');
    }
  }

  // CRUD : Update Method Caller
  Future<void> _updateFertilizer(FertilizerWithId fertilizer) async {
    FertilizerApi.updateFertilizer(fertilizer);
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
}
