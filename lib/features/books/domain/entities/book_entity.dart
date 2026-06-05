class BookEntity {
  final int id;
  final String title;
  final String author;
  final String genre;
  final int year;
  final int stock;
  final String? imageUrl;
  final double rating;

  BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.year,
    required this.stock,
    this.imageUrl,
    this.rating = 0.0,
  });
}