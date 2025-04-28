# GOSBFY - Modern E-Commerce Platform

![GOSBFY](https://api.placeholder.com/600/200)

A sleek and responsive e-commerce application built with Flutter. View the live demo at [https://gosbfy-demo.netlify.app/](https://gosbfy-demo.netlify.app/)

## Features

- Responsive UI for mobile, tablet, and desktop
- Product catalog with filtering and sorting options
- Shopping cart functionality
- Favorites/wishlist system
- Clean, modern interface using Material Design

## Screenshots

<div style="display: flex; gap: 20px; margin-bottom: 20px;">
  <img src="https://api.placeholder.com/180/320" alt="Mobile View" />
  <img src="https://api.placeholder.com/360/240" alt="Tablet View" />
  <img src="https://api.placeholder.com/540/320" alt="Desktop View" />
</div>

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (2.10.0 or newer)
- [Git](https://git-scm.com/downloads)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Clone the Repository

```bash
git clone https://github.com/yourusername/gosbfy.git
cd gosbfy
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

#### For Development

```bash
flutter run -d chrome  # For web
flutter run            # For default device
```

#### For Specific Platform

```bash
flutter run -d android
flutter run -d ios
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

## Project Structure

```
lib/
├── block/                 # State management using BLoC pattern
│   ├── cart/              # Cart related state management
│   ├── favorite/          # Favorite/wishlist state management
│   └── product/           # Product loading and filtering
├── models/                # Data models
├── screens/               # UI screens
│   └── home_screen.dart   # Main e-commerce interface
├── widgets/               # Reusable UI components
│   ├── product_card.dart  # Product display card
│   ├── cart_sidebar.dart  # Shopping cart sidebar
│   └── favorite_sidebar.dart  # Favorites sidebar
└── main.dart              # Application entry point
```

## Building for Production

### Web

```bash
flutter build web --release
```

The built application will be at `build/web`.

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Deployment

### Web Deployment to Netlify

1. Build your Flutter web app:
   ```bash
   flutter build web --release
   ```

2. Deploy to Netlify:
   - Option 1: Drag and drop the `build/web` folder to Netlify's dashboard
   - Option 2: Use Netlify CLI:
     ```bash
     netlify deploy --prod --dir=build/web
     ```

## Testing

Run the test suite:

```bash
flutter test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/) - Beautiful native apps in record time
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - State management
- [Material Design](https://material.io/design) - Design system

---

Developed with ♥ by [Your Name/Team]