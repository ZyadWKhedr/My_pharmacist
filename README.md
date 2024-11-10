# Healio App

Healio is a health-related app designed to provide users with access to a variety of features such as medicine information, reminders, and AI chat. The app aims to help users easily track their medications, find health-related information, and manage their health in an efficient and user-friendly manner.

## Features

- **Home Page**: Displays the main features of the app such as Medicine Search, AI Chat, Reminders, and Favourites.
- **Medicine Search**: Users can search for various medicines and view details like usage instructions, dosage, and side effects.
- **AI Chat**: Offers users an AI-powered chat feature to answer health-related questions and provide suggestions.
- **Reminders**: Allows users to set reminders for taking medications or other health-related tasks.
- **Favourites**: Users can mark their favorite medicines for easy access.
- **Profile Management**: Users can view and update their personal information, including username and email.
- **Settings**: Manage app preferences, notifications, and other configurations.
- **Logout**: Sign out of the app securely.

## Tech Stack

- **Flutter**: The app is built with Flutter for cross-platform development.
- **Provider**: Used for state management to manage user data and other app-related state.
- **Firebase Authentication**: To handle user authentication and ensure secure sign-ins.
- **Cupertino Icons**: For a native iOS look and feel in the UI.
- **Google Navigation Bar**: For an intuitive bottom navigation bar that helps users navigate the app.
- **Local RESTful API**: A custom RESTful API created by the developer, running locally, handles medicine data and other app-related services.

## Requirements

To run this app locally, you need to have the following:

- **Flutter SDK**: Install Flutter from the official website: [Flutter SDK](https://flutter.dev/docs/get-started/install)
- **Dart**: Dart comes bundled with Flutter, so installing Flutter will also install Dart.
- **Android Studio or Visual Studio Code**: For a development environment.
- **Firebase Project**: Set up a Firebase project for authentication (if using Firebase).
- **Local RESTful API**: A locally hosted API that powers the app. Ensure that the API is running and accessible when using the app.

## Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/your-repository/HealioApp.git
    cd HealioApp
    ```

2. Install the dependencies:
    ```bash
    flutter pub get
    ```

3. Set up Firebase Authentication:
   - Follow the steps to integrate Firebase with your Flutter app from the [Firebase documentation](https://firebase.flutter.dev/docs/overview).

4. Set up the local RESTful API:
   - Ensure that your custom RESTful API is up and running locally. The API endpoints are defined within the app to interact with data like medicines and user information.

5. Run the app:
    ```bash
    flutter run
    ```

## Usage

- Upon launching the app, users can sign in using their credentials or create a new account.
- The Home Page provides quick access to all the main features of the app, such as searching for medicines, setting reminders, and interacting with AI.
- Users can manage their profile, update settings, and log out via the app's drawer menu.

## Contributing

We welcome contributions to the Healio app! If you have any ideas, bug fixes, or feature improvements, please feel free to fork the repository and create a pull request. Before making any significant changes, please open an issue to discuss what you plan to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
