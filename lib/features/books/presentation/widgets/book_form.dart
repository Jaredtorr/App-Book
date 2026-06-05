import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/book_entity.dart';
import '../../data/models/book_model.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../core/constants/api_constants.dart';

class BookForm extends StatefulWidget {
  final BookEntity? book;
  final Function(BookEntity, File?) onSubmit;

  const BookForm({
    super.key,
    this.book,
    required this.onSubmit,
  });

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _genreController;
  late final TextEditingController _yearController;
  late final TextEditingController _stockController;
  late final TextEditingController _ratingController;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _genreController = TextEditingController(text: widget.book?.genre ?? '');
    _yearController = TextEditingController(text: widget.book?.year.toString() ?? '');
    _stockController = TextEditingController(text: widget.book?.stock.toString() ?? '');
    _ratingController = TextEditingController(text: widget.book?.rating.toString() ?? '0.0');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _yearController.dispose();
    _stockController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.background,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: _selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(_selectedImage!, fit: BoxFit.cover),
            )
                : widget.book?.imageUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                '${ApiConstants.baseUrl}/${widget.book!.imageUrl}',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.add_photo_alternate_outlined,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
            )
                : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate_outlined,
                    color: AppColors.primary, size: 40),
                SizedBox(height: 8),
                Text('Agregar portada',
                    style: TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _titleController,
          label: 'Título del libro',
          icon: Icons.book_outlined,
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _authorController,
          label: 'Autor',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _genreController,
          label: 'Género',
          icon: Icons.category_outlined,
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _yearController,
          label: 'Año de publicación',
          icon: Icons.calendar_today_outlined,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _stockController,
          label: 'Stock disponible',
          icon: Icons.inventory_outlined,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _ratingController,
          label: 'Rating (0.0 - 5.0)',
          icon: Icons.star_outline,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              final book = BookModel(
                id: widget.book?.id ?? 0,
                title: _titleController.text.trim(),
                author: _authorController.text.trim(),
                genre: _genreController.text.trim(),
                year: int.tryParse(_yearController.text.trim()) ?? 0,
                stock: int.tryParse(_stockController.text.trim()) ?? 0,
                rating: double.tryParse(_ratingController.text.trim()) ?? 0.0,
              );
              widget.onSubmit(book, _selectedImage);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.transparent,
              shadowColor: AppColors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              widget.book == null ? 'Agregar libro' : 'Guardar cambios',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}