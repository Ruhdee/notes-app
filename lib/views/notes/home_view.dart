import 'package:flutter/material.dart';
import '../../view_models/auth_view_model.dart';
import '../../view_models/notes_view_model.dart';
import 'add_note_view.dart';
import '../../models/note.dart';

class HomeView extends StatefulWidget {
  final AuthViewModel authVM;
  final NotesViewModel notesVM;
  const HomeView({required this.authVM, required this.notesVM, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    widget.notesVM.addListener(_onChange);
  }

  void _onChange() => setState(() {});
  @override
  void dispose() {
    widget.notesVM.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton<String>(
            initialValue: widget.notesVM.category,
            onSelected: (v) => widget.notesVM.setCategory(v),
            itemBuilder: (context) => ['All', 'Personal', 'Work']
                .map((cat) => PopupMenuItem(value: cat, child: Text(cat)))
                .toList(),
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => widget.authVM.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: widget.notesVM.notesStream,
        builder: (ctx, snap) {
          if (snap.hasError) return Text('Error: ${snap.error}');
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final notes = snap.data ?? [];
          if (notes.isEmpty) return const Center(child: Text('No notes yet.'));
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (ctx, i) {
              final note = notes[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.content),
                      const SizedBox(height: 4),
                      Chip(
                        label: Text(note.category),
                        backgroundColor: theme.colorScheme.secondary
                            .withOpacity(0.15),
                        labelStyle: TextStyle(color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: theme.colorScheme.primary),
                    onPressed: () => widget.notesVM.deleteNote(note.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddNoteView(notesVM: widget.notesVM),
          ),
        ),
        child: Icon(Icons.add, color: theme.colorScheme.primary),
      ),
    );
  }
}
