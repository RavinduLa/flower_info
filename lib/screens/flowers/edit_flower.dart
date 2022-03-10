import 'package:flower_info/models/flower_admin_single_view_arguments.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flutter/material.dart';

class EditFlower extends StatefulWidget {
  const EditFlower({
    Key? key,
  }) : super(key: key);
  static String routeName = "/admin/flowers/edit-flower";

  @override
  _EditFlowerState createState() => _EditFlowerState();
}

class _EditFlowerState extends State<EditFlower> {
  final _formKey = GlobalKey<FormState>();
  final _controllerCommonName = TextEditingController();
  final _controllerScientificName = TextEditingController();
  final _controllerMatureSize = TextEditingController();
  final _controllerNativeRegion = TextEditingController();
  final _tempImageLink =
      "https://firebasestorage.googleapis.com/v0/b/flower-info.appspot.com/o/flower_images%2Flotus.jpg?alt=media&token=62c2e541-b42c-4d6a-8681-c3d67d41ea4c";

  

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FlowerAdminSingleViewArguments;
    _controllerCommonName.text = args.flowerWithId.commonName;
    _controllerScientificName.text = args.flowerWithId.scientificName;
    _controllerMatureSize.text = args.flowerWithId.matureSize;
    _controllerNativeRegion.text = args.flowerWithId.nativeRegion;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Flower"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controllerCommonName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Common Name'),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _controllerScientificName,
                  decoration:
                      const InputDecoration(hintText: 'Scientific Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _controllerMatureSize,
                  decoration: const InputDecoration(hintText: 'Mature Size'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _controllerNativeRegion,
                  decoration: const InputDecoration(hintText: 'Native Region'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Update details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
