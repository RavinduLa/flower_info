/*
* @author IT19240848 - H.G. Malwatta
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* UI/UX Standards
* https://youtu.be/ExKYjqgswJg
*
* */

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Back'),),
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(35, 209, 207, 207)),
        //This is added for handle the background items
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: size.width * 0.45,
                child: Image.asset(
                  "assets/images/common/flower_with_branch.png",
                  width: size.width * 0.6,
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
