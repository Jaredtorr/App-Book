import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/books/presentation/pages/book_page.dart';
import '../../features/auth/presentation/provider/auth_provider.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String books = '/books';

  static GoRouter router(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: login,
      routes: [
        GoRoute(
          path: login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: books,
          builder: (context, state) => const BookPage(),
        ),
      ],
    );
  }
}