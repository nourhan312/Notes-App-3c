

import 'package:flutter/material.dart';
import 'package:note_app_adam/models/note_model.dart';
import 'package:note_app_adam/widgets/note_card.dart';

import '../services/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List <NoteModel> notes = [
    NoteModel(title: "Test Note", content: "Hello ", color: Colors.pink.shade300),
    NoteModel(title: "Welcome", content: "session one in level ", color: Colors.blue.shade300),
    NoteModel(title: "Test Note", content: "Hello ", color: Colors.pink.shade300),
    NoteModel(title: "Welcome", content: "session one in level ", color: Colors.blue.shade300),
  ];


  @override
  Widget build(BuildContext context) {

    AuthService authService = AuthService();


    return Scaffold(
      /// appbar - body - drawer - floating action buttons
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
          label: Text("Add Note", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      icon: Icon(Icons.add,color: Colors.white,),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,

        centerTitle: true,
        title: Text("Notify", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
            },
            icon: Icon(Icons.logout, color: Colors.white,),
          ),
        ],
      ),
      body:   Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your recent Notes", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold ),),
           SizedBox(
             height: 15,
           ),
             Expanded(
               child: GridView.builder(
                   itemCount: notes.length,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisSpacing: 15,
                     mainAxisSpacing: 15,
                   childAspectRatio: 1.5,
                   crossAxisCount: 2),
                   itemBuilder: (context, index){
                     return NoteCard(model: notes[index] );
                   }),
             )
          ],
        ),
      )
     );
  }
}