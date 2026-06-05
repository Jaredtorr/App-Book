import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.genre,
    required super.year,
    required super.stock,
    super.imageUrl,
    super.rating = 0.0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      year: json['year'],
      stock: json['stock'],
      imageUrl: json['image_url'],
      rating: json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'year': year,
      'stock': stock,
      'rating': rating,
    };
  }
}