import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/usecases/get_all_books_usecase.dart';
import '../../domain/usecases/create_book_usecase.dart';
import '../../domain/usecases/update_book_usecase.dart';
import '../../domain/usecases/delete_book_usecase.dart';

class BookProvider extends ChangeNotifier {
  final GetAllBooksUseCase getAllBooksUseCase;
  final CreateBookUseCase createBookUseCase;
  final UpdateBookUseCase updateBookUseCase;
  final DeleteBookUseCase deleteBookUseCase;

  BookProvider({
    required this.getAllBooksUseCase,
    required this.createBookUseCase,
    required this.updateBookUseCase,
    required this.deleteBookUseCase,
  });

  List<BookEntity> _books = [];
  bool _isLoading = false;
  String? _error;

  List<BookEntity> get books => _books;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getAll(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _books = await getAllBooksUseCase.call(GetAllBooksParams(token: token));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> create(String token, BookEntity book, {File? image}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newBook = await createBookUseCase.call(
        CreateBookParams(token: token, book: book, image: image),
      );
      _books.add(newBook);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update(String token, int id, BookEntity book, {File? image}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedBook = await updateBookUseCase.call(
        UpdateBookParams(token: token, id: id, book: book, image: image),
      );
      final index = _books.indexWhere((b) => b.id == id);
      _books[index] = updatedBook;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete(String token, int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await deleteBookUseCase.call(DeleteBookParams(token: token, id: id));
      _books.removeWhere((b) => b.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}