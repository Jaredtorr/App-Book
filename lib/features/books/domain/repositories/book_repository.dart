import 'dart:io';
import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getAll(String token);
  Future<BookEntity> create(String token, BookEntity book, {File? image});
  Future<BookEntity> update(String token, int id, BookEntity book, {File? image});
  Future<void> delete(String token, int id);
}