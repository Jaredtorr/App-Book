import 'dart:io';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class UpdateBookParams {
  final String token;
  final int id;
  final BookEntity book;
  final File? image;

  UpdateBookParams({required this.token, required this.id, required this.book, this.image});
}

class UpdateBookUseCase {
  final BookRepository repository;

  UpdateBookUseCase(this.repository);

  Future<BookEntity> call(UpdateBookParams params) async {
    return await repository.update(params.token, params.id, params.book, image: params.image);
  }
}