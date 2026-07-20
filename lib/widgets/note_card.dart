import 'package:flutter/material.dart';
import 'package:note_app_adam/models/note_model.dart';

class NoteCard extends StatelessWidget {


  NoteModel model ;

  NoteCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {



    return             Container(
      height: 230,
      width: 230,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: model.color,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.title, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),
          SizedBox(
            height: 13,
          ),
          Expanded(child: Text(model.content, style: TextStyle(fontSize: 15),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.white,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),


            ],
          )
        ],
      ),
    );

  }
}
