import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/di/injection_container.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/books/presentation/provider/book_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => InjectionContainer.authProvider,
        ),
        ChangeNotifierProvider<BookProvider>(
          create: (_) => InjectionContainer.bookProvider,
        ),
      ],
      child: const App(),
    ),
  );
}