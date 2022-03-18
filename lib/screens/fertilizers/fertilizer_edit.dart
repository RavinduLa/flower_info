import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/models/fertilizer_model_id.dart';
import 'package:flutter/material.dart';

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
  final _imageUri = "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/disease_images%2Fdisease1.jpg?alt=media&token=1ed7ed0f-d257-474d-a42d-dcdf7a83dc8b";

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

    void _onSubmit()  {
      if(_formKey.currentState!.validate()) {
        FertilizerWithId fertilizer = FertilizerWithId(
          documentId: data.fertilizer.documentId,
          brandName: _brandName.text,
          type: _type.text,
          nitrogienValue: _nitrogienValue.text,
          phosporosValue: _phosporosValue.text,
          potasiamValue: _potasiamValue.text,
          description: _description.text,
          image: _imageUri,
        );

        Future<void> result = _updateFertilizer(fertilizer);
        print(result);
        _notification("Updated Success!");
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
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      helperText: ' ',
                      labelText: 'Name of fertilizer brand',
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
                    helperText: ' ',
                    labelText: 'Type of fertilizer',
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
                          borderSide: BorderSide(color: Colors.green)),
                      helperText: ' ',
                      labelText: 'Nitrogien(N) value',
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
                      helperText: ' ',
                      labelText: 'Phosporos(P) value',
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
                      helperText: '',
                      labelText: 'Potasiam(K) value',
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
                      helperText: '',
                      labelText: 'Description',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  // CRUD : Update Method Caller
  Future<void> _updateFertilizer(FertilizerWithId fertilizer) async {
    FertilizerApi.updateFertilizer(fertilizer);
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
