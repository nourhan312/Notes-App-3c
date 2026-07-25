import 'package:flutter/material.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({super.key});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
      title: Text("Add Note"),
      content: Form(
        key: key,
        child: Column(
          children: [
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Enter title";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),

              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Enter Note Content";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Content",
                border: OutlineInputBorder(),

              ),
            ),

          ],
        ),
      ),
      actions: [

        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(onPressed: (){

          if(key.currentState!.validate()){

          }
        }, child: Text("Add"))
      ],
    );
  }
}
