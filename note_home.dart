import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Note model — matches a Firestore "notes" doc: { title, content, updatedAt }
// ---------------------------------------------------------------------------
class Note {
  String id;
  String title;
  String content;

  Note({required this.id, required this.title, required this.content});
}


class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const NotesListPage(),
    );
  }
}

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  // In-memory list for now — swap for a Firestore stream later:
  //   .collection('notes').snapshots()
  final List<Note> notes = [
    Note(id: '1', title: 'Welcome', content: 'This is your first note.'),
  ];

  // TODO(firebase): FirebaseFirestore.instance.collection('notes').add({...})
  void _addOrEditNote({Note? existing}) async {
    final result = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => NoteEditPage(note: existing)),
    );
    if (result == null) return;

    setState(() {
      if (existing == null) {
        notes.add(result);
      } else {
        existing.title = result.title;
        existing.content = result.content;
      }
    });
  }

  // TODO(firebase): FirebaseFirestore.instance.collection('notes').doc(id).delete()
  void _deleteNote(Note note) {
    setState(() => notes.remove(note));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Dismissible(
            key: ValueKey(note.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _deleteNote(note),
            child: ListTile(
              title: Text(note.title.isEmpty ? 'Untitled' : note.title),
              subtitle: Text(
                note.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => _addOrEditNote(existing: note),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditNote(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteEditPage extends StatefulWidget {
  final Note? note;

  const NoteEditPage({super.key, this.note});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late final TextEditingController titleCtrl =
  TextEditingController(text: widget.note?.title ?? '');
  late final TextEditingController contentCtrl =
  TextEditingController(text: widget.note?.content ?? '');

  // TODO(firebase): FirebaseFirestore.instance.collection('notes').doc(id).update({...})
  void _save() {
    final note = Note(
      id: widget.note?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: titleCtrl.text,
      content: contentCtrl.text,
    );
    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New note' : 'Edit note'),
        actions: [
          IconButton(onPressed: _save, icon: const Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleCtrl,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
            ),
            const Divider(),
            Expanded(
              child: TextField(
                controller: contentCtrl,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start writing...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}