import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/http_client.dart';
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getAll(String token);
  Future<BookModel> create(String token, BookModel book, File? image);
  Future<BookModel> update(String token, int id, BookModel book, File? image);
  Future<void> delete(String token, int id);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final HttpClient httpClient;

  BookRemoteDataSourceImpl(this.httpClient);

  @override
  Future<List<BookModel>> getAll(String token) async {
    final response = await http.get(
      httpClient.buildUrl(ApiConstants.books),
      headers: httpClient.headersWithToken(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Token inválido');
    } else {
      throw ServerException('Error al obtener libros');
    }
  }

  @override
  Future<BookModel> create(String token, BookModel book, File? image) async {
    final request = http.MultipartRequest(
      'POST',
      httpClient.buildUrl(ApiConstants.books),
    );

    request.headers['authorization'] = token;
    request.fields['title'] = book.title;
    request.fields['author'] = book.author;
    request.fields['genre'] = book.genre;
    request.fields['year'] = book.year.toString();
    request.fields['stock'] = book.stock.toString();

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return BookModel.fromJson(jsonDecode(response.body)['book']);
    } else {
      throw ServerException('Error al crear libro');
    }
  }

  @override
  Future<BookModel> update(String token, int id, BookModel book, File? image) async {
    final request = http.MultipartRequest(
      'PUT',
      httpClient.buildUrl('${ApiConstants.books}/$id'),
    );

    request.headers['authorization'] = token;
    request.fields['title'] = book.title;
    request.fields['author'] = book.author;
    request.fields['genre'] = book.genre;
    request.fields['year'] = book.year.toString();
    request.fields['stock'] = book.stock.toString();

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return BookModel.fromJson(jsonDecode(response.body)['book']);
    } else {
      throw ServerException('Error al actualizar libro');
    }
  }

  @override
  Future<void> delete(String token, int id) async {
    final response = await http.delete(
      httpClient.buildUrl('${ApiConstants.books}/$id'),
      headers: httpClient.headersWithToken(token),
    );

    if (response.statusCode != 200) {
      throw ServerException('Error al eliminar libro');
    }
  }
}