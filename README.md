# Flutter Tech Assessment

A Flutter application submission for the **Palm Mobile Challenge**.  
This project demonstrates a scalable, maintainable architecture for a book browsing app using the [Gutendex API](http://gutendex.com/).  
The app supports searching, infinite scroll, book details, and a favorites (liked books) feature, and is designed for long-term maintainability.

---

## Table of Contents

- [Challenge Overview](#challenge-overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Running the App](#running-the-app)
- [Testing](#testing)
- [Architecture Overview](#architecture-overview)
- [Key Files and Directories](#key-files-and-directories)
- [API](#api)
- [State Management](#state-management)
- [Routing](#routing)
- [Contributing](#contributing)
- [License](#license)

---

## Challenge Overview

This project is a submission for the **Palm Mobile Challenge**.

**Assessment requirements:**
- Fetch and display books from the [Gutendex API](http://gutendex.com/)
- Home screen with book list (with initial query)
- Search functionality
- Infinite scroll pagination
- Book detail screen (opened from home)
- Like/unlike books, with a separate "Liked" page
- Creative and user-friendly UI
- Runs on both Android and iOS (and web)
- Uses the latest stable Flutter release
- Follows Flutter/Dart best practices, with unit tests and error handling

---

## Features

- Browse a list of books fetched from the [Gutendex API](http://gutendex.com).
- Search for books by title.
- Infinite scroll pagination on the book list.
- View detailed information about each book.
- Like/unlike books and view your liked books on a dedicated page.
- Persistent local storage for favorites (works offline for liked books).
- Responsive UI for web and mobile.
- Robust error handling and loading states.

---

## Project Structure

```
lib/
  core/
    router.dart                # App routing configuration
    service/
      api/
        api_client.dart        # API client using Dio
        api_endpoint.dart      # API endpoints
      storage/
        local_storage.dart     # Local storage abstraction
        local_storage_key.dart # Storage keys
    utils/
      data_state.dart          # Enum for loading/error/success states
      exception.dart           # Custom exceptions
      result.dart              # Result wrapper for async operations
  modules/
    books/
      data/
        data_source/
          book_local_data_source.dart   # Local data source
          book_remote_data_source.dart  # Remote data source
        repostory/
          book_repository.dart          # Repository implementation
        response/
          books_response.dart           # Book response models
      domain/
        entity/
          book_entity.dart              # Book entity
          book_detail_entity.dart       # Book detail entity
        interface/
          book_interface.dart           # Book domain interface
      presentation/
        pages/
          books_home_page.dart          # Home page
          book_detail_page.dart         # Book detail page
          book_likes_page.dart          # Favorites page
        providers/
          books_home_provider.dart      # Home page provider
          book_detail_provider.dart     # Detail page provider
          book_likes_provider.dart      # Favorites provider
main.dart                              # App entry point
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable, 3.32.5)
- Dart SDK (included with Flutter)
- Android Studio/Xcode/VS Code (recommended)

### Installation

1. **Install dependencies:**
   ```sh
   flutter pub get
   ```

---

## Running the App

### On Mobile (Android/iOS)

```sh
flutter run
```

---

## Testing

Run all unit and widget tests:

```sh
flutter test
```

Test files are located in the `test/` directory, with fakes and mocks in `test/fakes/` and module-specific tests in `test/module/`.

---

## Architecture Overview

This project uses a layered, scalable architecture:

- **Data Layer:** Handles API and local storage interactions.
- **Domain Layer:** Defines entities and interfaces.
- **Presentation Layer:** Contains UI pages and state providers.

State management is handled using `ChangeNotifier` and `Provider` for simplicity and maintainability.  
Error handling and loading states are managed at the provider level.

---

## Key Files and Directories

- `lib/main.dart`: App entry point and dependency injection.
- `lib/core/router.dart`: Routing configuration using `go_router`.
- `lib/modules/books/data/repostory/book_repository.dart`: Implements the main repository logic.
- `lib/modules/books/presentation/pages/`: UI pages for home, detail, and favorites.
- `lib/modules/books/presentation/providers/`: State management providers.

---

## API

- **Base URL:** `http://gutendex.com`
- **Endpoints:**
  - `/books`: Fetches a list of books.
  - `/books/:id`: Fetches details for a specific book.

API client is implemented in `core/service/api/api_client.dart`.

---

## State Management

- Uses `Provider` and `ChangeNotifier` for state management.
- Providers:
  - `BooksHomeProvider`: Handles book list, search, and pagination.
  - `BookDetailProvider`: Handles book detail and favorite status.
  - `BookLikesProvider`: Handles favorite books list.

---

## Routing

- Uses [`go_router`](https://pub.dev/packages/go_router) for navigation.
- Main routes:
  - `/books`: Home page
  - `/books/:bookId`: Book detail page
  - `/likes`: Favorites page

See `core/router.dart` for details.

---

## Submission Notes

- The project is tested on the latest stable Flutter release and runs on Android
- All requirements from the Palm Mobile Challenge are implemented.
- The codebase follows Flutter/Dart best practices, with layered architecture, error handling, and unit tests.