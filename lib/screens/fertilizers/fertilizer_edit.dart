/*
* @author IT19240848 - H.G. Malwatta
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase Firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
*
* CRUD Operations
* https://youtu.be/21vHY9P90jE
* https://youtu.be/G4INTsatBew
* https://youtu.be/w3krSTSGmaw
*
* Firebase Storage
* https://youtu.be/dmZ9Tg9k13U
*
* Image capture & picker
* https://youtu.be/MSv38jO4EJk
*
* DropDownButton Creation
* https://blog.logrocket.com/creating-dropdown-list-flutter/
*
* Cached Network Image
* https://pub.dev/packages/cached_network_image
*
* */

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/components/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/fertilizer_model_id.dart';

class FertilizerEdit extends StatefulWidget {
  const FertilizerEdit({Key? key}) : super(key: key);

  static String routeName = Constants.routNameFertilizerEdit;

  @override
  State<FertilizerEdit> createState() => _FertilizerEditState();
}

class _FertilizerEditState extends State<FertilizerEdit> {
  final _formKey = GlobalKey<FormState>();

  final _brandName = TextEditingController();
  String _type = "";
  final _nitrogienValue = TextEditingController();
  final _phosporosValue = TextEditingController();
  final _potasiamValue = TextEditingController();
  final _description = TextEditingController();

  late String selectedValue;
  String _imageLink = "";
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

    //Fetching data and Set values to the TextFields
    final data =
        ModalRoute.of(context)!.settings.arguments as FertilizerSingleView;
    _brandName.text = data.fertilizer.brandName;
    selectedValue = data.fertilizer.type;
    _nitrogienValue.text = data.fertilizer.nitrogienValue;
    _phosporosValue.text = data.fertilizer.phosporosValue;
    _potasiamValue.text = data.fertilizer.potasiamValue;
    _description.text = data.fertilizer.description;
    _imageLink = data.fertilizer.image;

    //Update Fertilizer
    void _onSubmit() async {
      if (_type.isEmpty) {
        setState(() {
          _type = selectedValue.toString();
        });
      }

      if (_formKey.currentState!.validate()) {
        FertilizerWithId fertilizer = FertilizerWithId(
          documentId: data.fertilizer.documentId,
          brandName: _brandName.text,
          type: _type,
          nitrogienValue: _nitrogienValue.text,
          phosporosValue: _phosporosValue.text,
          potasiamValue: _potasiamValue.text,
          description: _description.text,
          image: _imageLink,
        );

        Future<void> result = _updateFertilizer(fertilizer);

        if (image != null) {
          await uploadImage(data.fertilizer.documentId);
          updateImageUrl(data.fertilizer.documentId, _imageLink);
          if (kDebugMode) {
            print("Image Uploading Processed!");
          }
        }
        if (kDebugMode) {
          print(result);
        }
        _notification('Updated Done!');
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fertilizer Update"),
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
                const SizedBox(height: 25),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: Constants.fertilizerLabelType,
                      labelStyle: TextStyle(color: Colors.green),
                      helperText: ' ',
                    ),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        _type = selectedValue;
                      });
                    },
                    items: dropdownItems),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelBrandName,
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
                //         borderSide: BorderSide(color: Colors.cyan)),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.green),
                //     ),
                //     helperText: ' ',
                //     labelText: 'Type of Fertilizer',
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
                        borderSide: BorderSide(color: Colors.cyan)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelNitrogenValue,
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
                        borderSide: BorderSide(color: Colors.cyan)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelPhosphorusValue,
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
                        borderSide: BorderSide(color: Colors.cyan)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelPotassiumValue,
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
                        borderSide: BorderSide(color: Colors.cyan)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    helperText: ' ',
                    labelText: Constants.fertilizerLabelDescription,
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
                      child: const Text('Save Changes'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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

  // CRUD : Called Fertilizer Update Method and Passed Fertilizer Object
  Future<void> _updateFertilizer(FertilizerWithId fertilizer) async {
    FertilizerApi.updateFertilizer(fertilizer);
  }

  // CRUD : Called Update Image URL Method and Passed Image ID and Link
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
}
