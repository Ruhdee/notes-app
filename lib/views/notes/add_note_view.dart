import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../view_models/notes_view_model.dart';

import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../view_models/notes_view_model.dart';

class AddNoteView extends StatefulWidget {
  final NotesViewModel notesVM;
  const AddNoteView({required this.notesVM, super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  String _category = 'Personal';

  @override
  void initState() {
    super.initState();
    widget.notesVM.addListener(_onChange);
  }

  void _onChange() => setState(() {});
  @override
  void dispose() {
    widget.notesVM.removeListener(_onChange);
    titleCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: '',
        title: titleCtrl.text,
        content: contentCtrl.text,
        category: _category,
        createdAt: DateTime.now(),
      );
      await widget.notesVM.addNote(note);
      if (widget.notesVM.error == null) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(widget.notesVM.error!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: contentCtrl,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                ),
                maxLines: 4,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter content' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                items: ['Personal', 'Work']
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _category = val!),
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              widget.notesVM.isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveNote,
                        child: const Text('Save'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
