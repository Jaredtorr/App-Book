import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<String> login(String email, String password) async {
    return await dataSource.login(email, password);
  }

  @override
  Future<void> register(String name, String email, String password) async {
    await dataSource.register(name, email, password);
  }
}