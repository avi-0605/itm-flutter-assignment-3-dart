import 'dart:io';

abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}

mixin Searchable {
  bool matchesTitle(String query);
}

class Book extends LibraryItem with Searchable {
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  Book({
    required String id,
    required String title,
    required String author,
    required int year,
    bool isAvailable = true,
  }) : _id = id,
       _title = title,
       _author = author,
       _year = year,
       _isAvailable = isAvailable;

  String get id => _id;
  String get title => _title;
  String get author => _author;
  int get year => _year;
  bool get isAvailable => _isAvailable;

  set id(String value) {
    if (value.trim().isNotEmpty) {
      _id = value.trim();
    }
  }

  set title(String value) {
    if (value.trim().isNotEmpty) {
      _title = value.trim();
    }
  }

  set author(String value) {
    if (value.trim().isNotEmpty) {
      _author = value.trim();
    }
  }

  set year(int value) {
    if (value > 0) {
      _year = value;
    }
  }

  set isAvailable(bool value) {
    _isAvailable = value;
  }

  @override
  void borrowItem() {
    if (_isAvailable) {
      _isAvailable = false;
      print('Book "$_title" has been borrowed successfully.');
    } else {
      print('Book "$_title" is already borrowed.');
    }
  }

  @override
  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('Book "$_title" has been returned successfully.');
    } else {
      print('Book "$_title" is already available in the library.');
    }
  }

  @override
  void displayInfo() {
    final status = _isAvailable ? 'Available' : 'Borrowed';
    print(
      'ID: $_id | Title: $_title | Author: $_author | Year: $_year | Status: $status',
    );
  }

  @override
  bool matchesTitle(String query) {
    return _title.toLowerCase().contains(query.toLowerCase());
  }
}

class Library {
  final List<Book> _books = [];
  int _nextBookNumber = 1;

  Library() {
    _addSampleBooks();
  }

  void _addSampleBooks() {
    _books.addAll([
      _createBook('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
      _createBook('1984', 'George Orwell', 1949),
      _createBook('To Kill a Mockingbird', 'Harper Lee', 1960),
      _createBook('The Alchemist', 'Paulo Coelho', 1988),
      _createBook('Clean Code', 'Robert C. Martin', 2008),
    ]);
  }

  String _generateBookId() {
    final id = 'B${_nextBookNumber.toString().padLeft(3, '0')}';
    _nextBookNumber++;
    return id;
  }

  Book _createBook(String title, String author, int year) {
    return Book(
      id: _generateBookId(),
      title: title.trim(),
      author: author.trim(),
      year: year,
    );
  }

  bool addBook(String title, String author, int year) {
    if (title.trim().isEmpty || author.trim().isEmpty || year <= 0) {
      print(
        'Invalid book details. Title, author, and valid year are required.',
      );
      return false;
    }

    final book = _createBook(title, author, year);
    _books.add(book);
    print('Book added successfully with ID: ${book.id}');
    return true;
  }

  void displayAllBooks() {
    _displayBooks('All Books', _books);
  }

  void displayAvailableBooks() {
    final availableBooks = _books.where((book) => book.isAvailable).toList();
    _displayBooks('Available Books', availableBooks);
  }

  void displayBorrowedBooks() {
    final borrowedBooks = _books.where((book) => !book.isAvailable).toList();
    _displayBooks('Borrowed Books', borrowedBooks);
  }

  void borrowBook(String id) {
    final book = _findBookById(id);

    if (book == null) {
      print('No book found with ID: ${id.trim()}');
      return;
    }

    book.borrowItem();
  }

  void returnBook(String id) {
    final book = _findBookById(id);

    if (book == null) {
      print('No book found with ID: ${id.trim()}');
      return;
    }

    book.returnItem();
  }

  void searchBooksByTitle(String query) {
    if (query.trim().isEmpty) {
      print('Search text cannot be empty.');
      return;
    }

    final matches = _books
        .where((book) => book.matchesTitle(query.trim()))
        .toList();
    _displayBooks('Search Results for "${query.trim()}"', matches);
  }

  void displayStatistics() {
    final totalBooks = _books.length;
    final availableBooks = _books.where((book) => book.isAvailable).length;
    final borrowedBooks = totalBooks - availableBooks;
    final availabilityPercentage = totalBooks == 0
        ? 0.0
        : (availableBooks / totalBooks) * 100;

    print('\n=== Library Statistics ===');
    print('Total Books: $totalBooks');
    print('Available: $availableBooks');
    print('Borrowed: $borrowedBooks');
    print('Availability: ${availabilityPercentage.toStringAsFixed(2)}%');
  }

  Book? _findBookById(String id) {
    final normalizedId = id.trim().toLowerCase();

    for (final book in _books) {
      if (book.id.toLowerCase() == normalizedId) {
        return book;
      }
    }

    return null;
  }

  void _displayBooks(String heading, List<Book> books) {
    print('\n=== $heading ===');

    if (books.isEmpty) {
      print('No books found.');
      return;
    }

    for (final LibraryItem item in books) {
      item.displayInfo();
    }
  }
}

class LibraryApp {
  final Library _library = Library();

  void start() {
    _displayWelcomeMessage();

    while (true) {
      _displayMenu();
      final choice = _readInput('Enter your choice (1-9): ');

      switch (choice) {
        case '1':
          _library.displayAllBooks();
          _pause();
          break;
        case '2':
          _library.displayAvailableBooks();
          _pause();
          break;
        case '3':
          _library.displayBorrowedBooks();
          _pause();
          break;
        case '4':
          _handleAddBook();
          _pause();
          break;
        case '5':
          _handleBorrowBook();
          _pause();
          break;
        case '6':
          _handleReturnBook();
          _pause();
          break;
        case '7':
          _handleSearchBooks();
          _pause();
          break;
        case '8':
          _library.displayStatistics();
          _pause();
          break;
        case '9':
          print('\nThank you for using the Library Management System.');
          return;
        default:
          print('Invalid choice. Please enter a number from 1 to 9.');
          _pause();
      }
    }
  }

  void _displayWelcomeMessage() {
    print('=' * 60);
    print('WELCOME TO THE LIBRARY MANAGEMENT SYSTEM');
    print('=' * 60);
  }

  void _displayMenu() {
    print('\n' + '-' * 60);
    print('MAIN MENU');
    print('-' * 60);
    print('1. View All Books');
    print('2. View Available Books');
    print('3. View Borrowed Books');
    print('4. Add a New Book');
    print('5. Borrow a Book');
    print('6. Return a Book');
    print('7. Search Books by Title');
    print('8. View Library Statistics');
    print('9. Exit');
    print('-' * 60);
  }

  void _handleAddBook() {
    print('\n=== Add a New Book ===');
    final title = _readInput('Enter book title: ');
    final author = _readInput('Enter author name: ');
    final yearInput = _readInput('Enter publication year: ');
    final year = int.tryParse(yearInput);

    if (year == null) {
      print('Invalid year. Please enter a valid number.');
      return;
    }

    _library.addBook(title, author, year);
  }

  void _handleBorrowBook() {
    print('\n=== Borrow a Book ===');
    final id = _readInput('Enter book ID: ');

    if (id.trim().isEmpty) {
      print('Book ID cannot be empty.');
      return;
    }

    _library.borrowBook(id);
  }

  void _handleReturnBook() {
    print('\n=== Return a Book ===');
    final id = _readInput('Enter book ID: ');

    if (id.trim().isEmpty) {
      print('Book ID cannot be empty.');
      return;
    }

    _library.returnBook(id);
  }

  void _handleSearchBooks() {
    print('\n=== Search Books by Title ===');
    final query = _readInput('Enter title or part of title: ');
    _library.searchBooksByTitle(query);
  }

  String _readInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }

  void _pause() {
    stdout.write('\nPress Enter to continue...');
    stdin.readLineSync();
  }
}

void main() {
  final app = LibraryApp();
  app.start();
}
