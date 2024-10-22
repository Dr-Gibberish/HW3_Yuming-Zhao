import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'book.dart';

enum SortBy { author, title }

class BookListState extends Equatable {
  final List<Book> books;
  final SortBy sortBy;
  final bool isLoading;

  const BookListState({
    required this.books,
    this.sortBy = SortBy.author,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [books, sortBy, isLoading];

  BookListState copyWith({
    List<Book>? books,
    SortBy? sortBy,
    bool? isLoading,
  }) {
    return BookListState(
      books: books ?? this.books,
      sortBy: sortBy ?? this.sortBy,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookListCubit extends Cubit<BookListState> {
  BookListCubit() : super(const BookListState(books: [])) {
    _init();
  }

  void _init() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final books = [
      const Book(
        id: '1',
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        description: 'A classic novel about racial injustice in the American South.',
        imageUrl: 'assets/book_covers/To_kill_a_mockingbird.jpg',
      ),
      const Book(
        id: '2',
        title: '1984',
        author: 'George Orwell',
        description: 'A dystopian novel set in a totalitarian society.',
        imageUrl: 'assets/book_covers/1984.jpg',
      ),
      const Book(
        id: '3',
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        description: 'A romantic novel of manners set in Georgian England.',
        imageUrl: 'assets/book_covers/Pride_and_prejudice.jpg',
      ),
      const Book(
        id: '4',
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        description: 'A novel about the American Dream in the Jazz Age.',
        imageUrl: 'assets/book_covers/The_great_gatsby.jpg',
      ),
      const Book(
        id: '5',
        title: 'Moby-Dick',
        author: 'Herman Melville',
        description: 'An epic tale of obsession and adventure at sea.',
        imageUrl: 'assets/book_covers/Moby_Dick.jpg',
      ),
      const Book(
        id: '6',
        title: 'The Catcher in the Rye',
        author: 'J.D. Salinger',
        description: 'A controversial novel about teenage angst and alienation.',
        imageUrl: 'assets/book_covers/The_catcher_in_the_RYE.jpg',
      ),
    ];
    emit(state.copyWith(books: books, isLoading: false));
    _sortBooks();
  }

  void toggleSort() {
    emit(state.copyWith(
      sortBy: state.sortBy == SortBy.author ? SortBy.title : SortBy.author,
      isLoading: true,
    ));
    _sortBooks();
  }

  void _sortBooks() {
    final sortedBooks = List<Book>.from(state.books);
    if (state.sortBy == SortBy.author) {
      sortedBooks.sort((a, b) => a.author.compareTo(b.author));
    } else {
      sortedBooks.sort((a, b) => a.title.compareTo(b.title));
    }
    emit(state.copyWith(books: sortedBooks, isLoading: false));
  }
}