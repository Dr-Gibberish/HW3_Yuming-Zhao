import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_list_cubit.dart';
import 'book.dart';
import 'book_image_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Club App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => BookListCubit(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookListCubit, BookListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Book Club Home'),
            actions: [
              TextButton(
                onPressed: () => context.read<BookListCubit>().toggleSort(),
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text('Sort by ${state.sortBy == SortBy.author ? 'Title' : 'Author'}'),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Books',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (state.isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.books.length,
                    itemBuilder: (context, index) => BookItem(book: state.books[index]),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailPage(book: book)),
      ),
      child: Container(
        width: 140, 
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            BookImageWidget(book: book, width: 120, height: 180),
            const SizedBox(height: 8),
            Text(
              book.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Book book;

  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BookImageWidget(book: book, width: 200, height: 300),
              ),
              const SizedBox(height: 16),
              Text(book.title, style: Theme.of(context).textTheme.titleLarge),
              Text(book.author, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              Text(book.description),
            ],
          ),
        ),
      ),
    );
  }
}

