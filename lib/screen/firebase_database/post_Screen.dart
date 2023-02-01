import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseproject/screen/authentication/login_Screen.dart';
import 'package:flutterfirebaseproject/screen/firebase_database/add_post.dart';
import 'package:flutterfirebaseproject/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';

class Post_Screen extends StatefulWidget {
  const Post_Screen({super.key});

  @override
  State<Post_Screen> createState() => _Post_ScreenState();
}

class _Post_ScreenState extends State<Post_Screen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Post Screen'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login_Screen(),
                  ),
                );
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {

          //       if (!snapshot.hasData) {
          //         return CircularProgressIndicator();
          //       } else {
          //         Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //         List <dynamic> list = [];
          //         list.clear();
          //         list = map.values.toList();
          //         return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(list[index]['Title']),
          //               subtitle: Text(list[index]['ID']),
          //             );
          //           },
          //         );
          //       }
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),

          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Text('Loading'),
              itemBuilder: (context, DataSnapshot, Animation, Index) {
                final title = DataSnapshot.child('Title').value.toString();
                if (searchController.text.isEmpty) {
                  return ListTile(
                    title: Text(DataSnapshot.child('Title').value.toString()),
                    subtitle: Text(DataSnapshot.child('ID').value.toString()),
                    trailing: PopupMenuButton(
                      icon:const Icon(Icons.more_vert_rounded),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              ShowMyDilog(
                                title: title,
                                id: DataSnapshot.child('ID').value.toString(),
                              );
                            },
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              ref.child(DataSnapshot.child('ID').value.toString()).remove();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (title.toLowerCase().contains(
                      searchController.text.toLowerCase().toLowerCase(),
                    )) {
                  return ListTile(
                    title: Text(
                      DataSnapshot.child('Title').value.toString(),
                    ),
                    subtitle: Text(
                      DataSnapshot.child('ID').value.toString(),
                    )
                  );
                    
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Add_Post_Screen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> ShowMyDilog({required String title, required String id}) async {
    final editcontroller = TextEditingController();
    editcontroller.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editcontroller,
                decoration: InputDecoration(
                  hintText: 'Edit here',
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.child(id).update({
                    'Title': editcontroller.text.toLowerCase()
                  }).then((value) {
                    Utils().toastMessage('Updated');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text('Update'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }
}
