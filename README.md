# External DB Test

A robust Flutter application demonstrating Clean Architecture principles, integrated with a Node.js backend and PostgreSQL database. This project showcases best practices for building scalable and maintainable mobile apps with external database connectivity.

## 🚀 Features

-   **Clean Architecture**: Separation of concerns with Domain, Data, and Presentation layers.
-   **State Management**: Powered by `flutter_bloc` for predictable state management.
-   **REST API Integration**: Seamless communication with a Node.js backend using `http`.
-   **CRUD Operations**: Full Create, Read, Update, and Delete functionality for items.
-   **External Database**: Data persistence using PostgreSQL.
-   **UI/UX**: Modern and responsive user interface.

## 📸 Screenshots

|   |   |
|---|---|
| ![Screenshot 1](assets/screenshots/Screenshot_20260109_184736.png) | ![Screenshot 2](assets/screenshots/Screenshot_20260109_184754.png) |
| ![Screenshot 3](assets/screenshots/Screenshot_20260109_184825.png) | ![Screenshot 4](assets/screenshots/Screenshot_20260109_185001.png) |

## 🛠️ Getting Started

Follow these steps to get a local copy up and running.

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install)
-   [Node.js](https://nodejs.org/) (for the backend)
-   [PostgreSQL](https://www.postgresql.org/) (for the database)

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/external_db_test.git
    cd external_db_test
    ```

2.  **Install Flutter dependencies**
    ```bash
    flutter pub get
    ```

3.  **Setup the Backend**
    -   Navigate to the backend directory (if included in this repo) or ensure your Node.js server is running.
    -   Update `lib/core/api_constants.dart` with your local IP address or server URL.

4.  **Run the App**
    ```bash
    flutter run
    ```

## 📂 Project Structure

```
lib/
├── core/           # Core functionality (Constants, Failures, UseCases)
├── data/           # Data layer (Data Sources, Models, Repositories)
├── domain/         # Domain layer (Entities, Repositories Interfaces, UseCases)
├── presentation/   # Presentation layer (Blocs, Pages, Widgets)
└── main.dart       # Application entry point
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
