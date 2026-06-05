import 'dart:io';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_datasource.dart';
import '../models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource dataSource;

  BookRepositoryImpl(this.dataSource);

  @override
  Future<List<BookEntity>> getAll(String token) async {
    return await dataSource.getAll(token);
  }

  @override
  Future<BookEntity> create(String token, BookEntity book, {File? image}) async {
    return await dataSource.create(token, book as BookModel, image);
  }

  @override
  Future<BookEntity> update(String token, int id, BookEntity book, {File? image}) async {
    return await dataSource.update(token, id, book as BookModel, image);
  }

  @override
  Future<void> delete(String token, int id) async {
    await dataSource.delete(token, id);
  }
}