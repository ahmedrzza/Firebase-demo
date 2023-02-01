import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Verify_Code extends StatefulWidget {
  String verificationId;
  Verify_Code({super.key, required this.verificationId});

  @override
  State<Verify_Code> createState() => _Verify_CodeState();
}

class _Verify_CodeState extends State<Verify_Code> {
  final phonenumbercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TextFormField(
            decoration: InputDecoration(
              
            ),
            
          )
        ],
      ),
    );
  }
}
