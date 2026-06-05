import '../repositories/book_repository.dart';

class DeleteBookParams {
  final String token;
  final int id;

  DeleteBookParams({required this.token, required this.id});
}

class DeleteBookUseCase {
  final BookRepository repository;

  DeleteBookUseCase(this.repository);

  Future<void> call(DeleteBookParams params) async {
    return await repository.delete(params.token, params.id);
  }
}