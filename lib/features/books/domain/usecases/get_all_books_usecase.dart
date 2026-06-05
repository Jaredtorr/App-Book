import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class GetAllBooksParams {
  final String token;
  GetAllBooksParams({required this.token});
}

class GetAllBooksUseCase {
  final BookRepository repository;

  GetAllBooksUseCase(this.repository);

  Future<List<BookEntity>> call(GetAllBooksParams params) async {
    return await repository.getAll(params.token);
  }
}