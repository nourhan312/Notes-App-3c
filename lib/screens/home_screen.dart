import 'package:flutter/material.dart';
import 'package:note_app_adam/models/note_model.dart';
import 'package:note_app_adam/widgets/note_card.dart';
import '../services/firebase_auth.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> notes = [
    NoteModel(
      title: "Test Note",
      content: "Hello",
      color: Colors.pink.shade300,
    ),
    NoteModel(
      title: "Welcome",
      content: "Session One",
      color: Colors.blue.shade300,
    ),
    NoteModel(
      title: "Flutter",
      content: "Reusable Widgets",
      color: Colors.orange.shade300,
    ),
    NoteModel(
      title: "Note App",
      content: "GridView Builder",
      color: Colors.green.shade300,
    ),
  ];

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: Colors.black,

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Note",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text("Add Note"),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter title";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: contentController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter note content";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Content",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      titleController.clear();
                      contentController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        notes.add(
                          NoteModel(
                            title: titleController.text,
                            content: contentController.text,
                           color: Colors.deepOrange.shade300
                          )
                        );

                        setState(() {});

                        titleController.clear();
                        contentController.clear();

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
      ),

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Notify",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Recent Notes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                itemCount: notes.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return NoteCard(
                    model: notes[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}