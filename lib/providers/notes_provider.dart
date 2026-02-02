import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/note_model.dart';
import '../models/category_model.dart';
import '../core/services/firestore_service.dart';

enum NoteStatuts { active, archived, deleted }

class NotesProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<NoteModel> _notes = [];
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  StreamSubscription? _notesSubscription;
  StreamSubscription? _categorySubscription;
  bool _isLoading = false;
  bool _isLoadingCategory = false;

  NotesProvider() {
    listenToNotes();
    listenToCategory();
  }

  List<NoteModel> get notes => _notes;
  bool get isLoading => _isLoading;

  List<NoteModel> get archivedNotes =>
      _notes.where((note) => note.status == 'archived').toList();

  List<NoteModel> get deletedNotes =>
      _notes.where((note) => note.status == 'deleted').toList();

  List<NoteModel> get activeNotes =>
      _notes.where((note) => note.status == 'active').toList();

  void listenToNotes() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _notes = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();
    _notesSubscription?.cancel();

    _notesSubscription = _service.getNotes(user.uid).listen((notesData) {
      _notes = notesData;
      _isLoading = false;

      print(" تم جلب ${_notes.length} ملاحظة من الفايربيس");

      notifyListeners();
    });
  }

  void listenToCategory() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _categories = [];
      notifyListeners();
      return;
    }

    _isLoadingCategory = true;
    notifyListeners();

    _categorySubscription?.cancel();

    _notesSubscription = _service.getCategories(user.uid).listen((notesData) {
      _categories = notesData;
      _isLoadingCategory = false;

      print(" تم جلب ${_categories.length} تصنيف من الفايربيس");

      notifyListeners();
    });
  }

  Future<void> addNote(
    String title,
    String content, {
    CategoryModel? category,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final newNote = NoteModel(
      id: '',
      title: title.isEmpty ? "بدون عنوان" : title,
      content: content,
      createdAt: DateTime.now(),
      lastUpdate: DateTime.now(),
      userId: user.uid,
      categoryId: category?.id,
      categoryName: category?.name,
      categoryColor: category?.color,
      status: 'active',
    );

    await _service.addNote(newNote);
  }

  NoteModel? emptyNote() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final newNote = NoteModel(
      id: '',
      title: '',
      content: '',
      createdAt: DateTime.now(),
      lastUpdate: DateTime.now(),
      userId: user.uid,
      categoryId: '',
      categoryName: '',
      categoryColor: 0,
      status: 'active',
    );

    return newNote;
  }

  Future<void> updateNote(
    NoteModel oldNote,
    String newTitle,
    String newContent, {
    CategoryModel? newCategory,
  }) async {
    final updatedNote = NoteModel(
      id: oldNote.id,
      title: newTitle,
      content: newContent,
      createdAt: oldNote.createdAt,
      lastUpdate: DateTime.now(),
      userId: oldNote.userId,
      categoryId: newCategory?.id ?? oldNote.categoryId,
      categoryName: newCategory?.name ?? oldNote.categoryName,
      categoryColor: newCategory?.color ?? oldNote.categoryColor,
      status: oldNote.status,
    );

    await _service.updateNote(updatedNote);
  }

  Future<void> moveNote(NoteModel note, String newStatus) async {
    final updatedNote = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      lastUpdate: DateTime.now(),
      userId: note.userId,
      status: newStatus,
      categoryId: note.categoryId,
      categoryName: note.categoryName,
      categoryColor: note.categoryColor,
    );
    await _service.updateNote(updatedNote);
  }

  Future<void> deleteForever(String noteId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await _service.deleteNote(noteId, user.uid);
  }

  Future<void> addCategory(String catName, String catColor) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final newNote = CategoryModel(
      id: '',
      color: catColor.isEmpty ? 0 : int.parse(catColor),
      name: catName.isEmpty ? "تصنيف بدون اسم" : catName,
    );

    await _service.addCategory(newNote, user.uid);
  }

  Future<void> changeNoteCategory(
    NoteModel note,
    CategoryModel? newCategory,
  ) async {
    final updatedNote = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      lastUpdate: DateTime.now(),
      userId: note.userId,
      status: note.status,
      categoryId: newCategory?.id,
      categoryName: newCategory?.name,
      categoryColor: newCategory?.color,
    );
    await _service.updateNote(updatedNote);
  }

  @override
  void dispose() {
    _notesSubscription?.cancel();
    super.dispose();
  }
}
