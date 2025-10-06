import 'package:flutter/material.dart';
import '../models/note.dart';
import '../repositories/notes_repository.dart';

class NotesViewModel extends ChangeNotifier {
  final NotesRepository repo;
  String _category = 'All';
  bool _isLoading = false;
  String? _error;

  NotesViewModel(this.repo);

  String get category => _category;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Stream<List<Note>> get notesStream => _category == 'All'
      ? repo.getAllNotes()
      : repo.getNotesByCategory(_category);

  void setCategory(String cat) {
    _category = cat;
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await repo.addNote(note);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    try {
      await repo.deleteNote(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
