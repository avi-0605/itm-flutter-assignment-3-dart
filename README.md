# Library Management System - Dart Console App

## How to Run

1. Install the Dart SDK from <https://dart.dev/get-dart>
2. Open a terminal in this folder.
3. Run:

```bash
dart library_system.dart
```

You can also paste the code into DartPad at <https://dartpad.dev/>.

## Features

- View all books
- View available books
- View borrowed books
- Add a new book with title, author, and year
- Borrow a book using its unique ID
- Return a borrowed book using its ID
- Search books by title with partial matching
- View library statistics
- Handle invalid choices, empty fields, invalid years, unavailable books, and missing IDs

## OOP Concepts Used

- Classes and objects: `Book`, `Library`, and `LibraryApp`
- Encapsulation: private fields with getters and setters in `Book`
- Abstraction: abstract `LibraryItem` class
- Inheritance: `Book` extends `LibraryItem`
- Method overriding: `Book` overrides `borrowItem()`, `returnItem()`, and `displayInfo()`
- Runtime polymorphism: `Library` displays books through `LibraryItem` references
- Constructor: `Book` uses a parameterized constructor with an optional named parameter
- Interface/mixin: `Searchable` mixin provides title-search behavior
- Collections: `List<Book>` stores and manages the library books
- Loops and conditionals: menu loop, validation, filtering, and search

## Menu Options

```text
1. View All Books
2. View Available Books
3. View Borrowed Books
4. Add a New Book
5. Borrow a Book
6. Return a Book
7. Search Books by Title
8. View Library Statistics
9. Exit
```

## Sample Output

```text
============================================================
WELCOME TO THE LIBRARY MANAGEMENT SYSTEM
============================================================

------------------------------------------------------------
MAIN MENU
------------------------------------------------------------
1. View All Books
2. View Available Books
3. View Borrowed Books
4. Add a New Book
5. Borrow a Book
6. Return a Book
7. Search Books by Title
8. View Library Statistics
9. Exit
------------------------------------------------------------
Enter your choice (1-9): 1

=== All Books ===
ID: B001 | Title: The Great Gatsby | Author: F. Scott Fitzgerald | Year: 1925 | Status: Available
ID: B002 | Title: 1984 | Author: George Orwell | Year: 1949 | Status: Available
ID: B003 | Title: To Kill a Mockingbird | Author: Harper Lee | Year: 1960 | Status: Available
ID: B004 | Title: The Alchemist | Author: Paulo Coelho | Year: 1988 | Status: Available
ID: B005 | Title: Clean Code | Author: Robert C. Martin | Year: 2008 | Status: Available
```
