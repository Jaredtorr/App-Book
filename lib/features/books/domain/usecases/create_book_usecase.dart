import 'dart:io';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class CreateBookParams {
  final String token;
  final BookEntity book;
  final File? image;

  CreateBookParams({required this.token, required this.book, this.image});
}

class CreateBookUseCase {
  final BookRepository repository;

  CreateBookUseCase(this.repository);

  Future<BookEntity> call(CreateBookParams params) async {
    return await repository.create(params.token, params.book, image: params.image);
  }
}