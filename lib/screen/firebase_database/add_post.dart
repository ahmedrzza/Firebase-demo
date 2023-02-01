import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Add_Post_Screen extends StatefulWidget {
  const Add_Post_Screen({super.key});

  @override
  State<Add_Post_Screen> createState() => _Add_Post_ScreenState();
}

class _Add_Post_ScreenState extends State<Add_Post_Screen> {
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('Post');
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: postcontroller,
                maxLines: 4,
                decoration:const InputDecoration(
                  hintText: 'What is your mind',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseref
                      .child(id)
                      .set({
                    'ID': id,
                    'Title': postcontroller.text.toString()
                  });
                },
                child: const Text(
                  'Add',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
