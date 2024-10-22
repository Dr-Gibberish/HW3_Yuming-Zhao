import 'package:flutter/material.dart';
import 'book.dart';

class BookImageWidget extends StatelessWidget {
  final Book book;
  final double width;
  final double height;

  const BookImageWidget({
    super.key, 
    required this.book, 
    this.width = 120, 
    this.height = 180
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        book.imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Icon(Icons.book, size: width / 2, color: Colors.grey),
    );
  }
}