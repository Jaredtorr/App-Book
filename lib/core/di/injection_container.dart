import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';
import '../../features/books/data/datasources/book_remote_datasource.dart';
import '../../features/books/data/repositories/book_repository_impl.dart';
import '../../features/books/domain/usecases/create_book_usecase.dart';
import '../../features/books/domain/usecases/delete_book_usecase.dart';
import '../../features/books/domain/usecases/get_all_books_usecase.dart';
import '../../features/books/domain/usecases/update_book_usecase.dart';
import '../../features/books/presentation/provider/book_provider.dart';
import '../network/http_client.dart';

class InjectionContainer {

  static final httpClient = HttpClient();

  // Auth
  static final authDataSource = AuthRemoteDataSourceImpl(httpClient);
  static final authRepository = AuthRepositoryImpl(authDataSource);
  static final loginUseCase = LoginUseCase(authRepository);
  static final registerUseCase = RegisterUseCase(authRepository);
  static final authProvider = AuthProvider(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
  );


  static final bookDataSource = BookRemoteDataSourceImpl(httpClient);
  static final bookRepository = BookRepositoryImpl(bookDataSource);
  static final getAllBooksUseCase = GetAllBooksUseCase(bookRepository);
  static final createBookUseCase = CreateBookUseCase(bookRepository);
  static final updateBookUseCase = UpdateBookUseCase(bookRepository);
  static final deleteBookUseCase = DeleteBookUseCase(bookRepository);
  static final bookProvider = BookProvider(
    getAllBooksUseCase: getAllBooksUseCase,
    createBookUseCase: createBookUseCase,
    updateBookUseCase: updateBookUseCase,
    deleteBookUseCase: deleteBookUseCase,
  );
}