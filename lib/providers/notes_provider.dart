import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';
import '../models/category_model.dart';
import '../core/services/firestore_service.dart';

class NotesProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<NoteModel> _notes = [];

  StreamSubscription? _notesSubscription;

  bool _isLoading = false;
  List<NoteModel> get notes => _notes;
  bool get isLoading => _isLoading;

  //init:
  void listenToNotes() {
    _isLoading = true;
    notifyListeners();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _notes = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _notesSubscription = _service.getNotes(user.uid).listen((notesData) {
      _notes = notesData;
      _isLoading = false;
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
      title: title.isEmpty ? "بدون عنوان - Without Title" : title,
      content: content,
      createdAt: DateTime.now(),
      lastUpdate: DateTime.now(),
      userId: user.uid,
      categoryId: category?.id,
      categoryName: category?.name,
      categoryColor: category?.color,
    );

    await _service.addNote(newNote);
  }

  Future<void> updateNote(
    NoteModel oldNote,
    String newTitle,
    String newContent, {
    CategoryModel? newCategory,
  }) async {
    final updatedNote = NoteModel(
      id: oldNote.id, // نحافظ على نفس الـ ID القديم
      title: newTitle,
      content: newContent,
      createdAt: oldNote.createdAt, // تاريخ الإنشاء لا يتغير
      lastUpdate: DateTime.now(), // نحدث تاريخ التعديل
      userId: oldNote.userId,
      // تحديث التصنيف (إذا تم تمرير تصنيف جديد نستخدمه، وإلا نستخدم القديم)
      categoryId: newCategory?.id ?? oldNote.categoryId,
      categoryName: newCategory?.name ?? oldNote.categoryName,
      categoryColor: newCategory?.color ?? oldNote.categoryColor,
    );

    await _service.updateNote(updatedNote);
  }

  Future<void> deleteNote(String noteId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await _service.deleteNote(noteId, user.uid);
  }


  @override
  void dispose() {
    // يجب إغلاق بث البيانات عند إغلاق البروفايدر لتجنب تسريب الذاكرة
    _notesSubscription?.cancel();
    super.dispose();
  }
}
