import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/components/Fertilizers/fertilizer_item_tile_admin.dart';
import 'package:flower_info/models/fertilizer_model.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_admin_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Fertilizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      helperText: ' ',
                      labelText: 'Name of fertilizer brand',
                      prefixIcon: Icon(
                        Icons.description
                      )
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
                      helperText: ' ',
                      labelText: 'Type of fertilizer',
                        prefixIcon: Icon(
                            Icons.description
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
                      helperText: ' ',
                      labelText: 'Nitrogien(N) value',
                        prefixIcon: Icon(
                            Icons.confirmation_number
                        )
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
                      helperText: ' ',
                      labelText: 'Phosporos(P) value',
                        prefixIcon: Icon(
                            Icons.confirmation_number
                        )
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
                      helperText: '',
                      labelText: 'Potasiam(K) value',
                        prefixIcon: Icon(
                            Icons.confirmation_number
                        )
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
                      helperText: '',
                      labelText: 'Description',
                        prefixIcon: Icon(
                            Icons.description
                        )
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
                  SizedBox(height: size.height * 0.05),
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
                              color: Colors.green,
                              splashColor: Colors.white,
                              onPressed: _onSubmit,
                              child: const Text(
                                'CREATE',
                                style: TextStyle(color: Colors.white, fontSize: 19,fontWeight: FontWeight.w700),
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
                ],
              ),
            ),
          ),
      ),
    );
  }
  void _onSubmit() {
    if(_formKey.currentState!.validate()){

      Fertilizer fertilizer = Fertilizer(
        brandName: _brandName.text,
        type: _type.text,
        nitrogienValue: _nitrogienValue.text,
        phosporosValue: _phosporosValue.text,
        potasiamValue: _potasiamValue.text,
        description: _description.text,
        image: _imageUri,
      );

      Future<DocumentReference> result = _createFertilizer(fertilizer);
      print(result);
      _notification('Creating fertilizer');
      _clearFields();
      _notification('Done!');
      Navigator.pushNamed(context, FertilizerAdmin.routeName);
    }
  }
  // CRUD : Create Method Caller
  Future<DocumentReference> _createFertilizer(Fertilizer fertilizer) {
    return FertilizerApi.addFertilizer(fertilizer);
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


