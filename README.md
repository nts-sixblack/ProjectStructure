# MapTracking

A SwiftUI-based location tracking application that follows Clean Architecture principles.

## Features

- Real-time location tracking
- Location history
- Clean Architecture implementation
- SwiftUI interface
- Combine for reactive programming
- SwiftGen for asset and localization management
- SwiftLint for code style enforcement

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+
- SwiftGen 6.6.0+
- SwiftLint 0.50.0+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/MapTracking.git
```

2. Install dependencies:
```bash
cd MapTracking
pod install
```

3. Install SwiftGen and SwiftLint:
```bash
brew install swiftgen
brew install swiftlint
```

4. Open the workspace:
```bash
open MapTracking.xcworkspace
```

## Project Structure

The project follows Clean Architecture principles with the following structure:

```
MapTracking/
├── Sources/
│   ├── Domain/
│   │   ├── Entities/      # Business entities
│   │   ├── UseCases/      # Business logic
│   │   └── Repositories/  # Repository interfaces
│   ├── Data/
│   │   ├── Repositories/  # Repository implementations
│   │   └── DataSources/   # Data sources
│   ├── Presentation/
│   │   ├── ViewModels/    # View models
│   │   └── Views/         # SwiftUI views
│   └── Infrastructure/    # Common utilities
```

## Code Generation and Linting

### SwiftGen

The project uses SwiftGen for generating type-safe access to assets, colors, and localizations.

#### Configuration
- SwiftGen configuration is defined in `swiftgen.yml`
- Generated files are stored in `Sources/Generated/`

#### Usage
1. To generate code:
```bash
swiftgen
```

2. The generated code provides type-safe access to:
   - Images: `Asset.Images.myImage`
   - Colors: `Asset.Colors.myColor`
   - Localizations: `L10n.myLocalizedString`

3. To update generated code:
```bash
swiftgen config run
```

### SwiftLint

The project uses SwiftLint to enforce Swift style and conventions.

#### Configuration
- SwiftLint rules are defined in `.swiftlint.yml`
- Custom rules can be added to the configuration file

#### Usage
1. To run SwiftLint:
```bash
swiftlint
```

2. To autocorrect violations:
```bash
swiftlint autocorrect
```

3. To run SwiftLint in Xcode:
   - Add a "Run Script" build phase
   - Add the following script:
   ```bash
   if which swiftlint >/dev/null; then
     swiftlint
   else
     echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
   fi
   ```

## Usage

1. Request Location Permission:
   - The app will request location permissions when first launched
   - Make sure to grant location permissions in Settings if denied

2. Start Tracking:
   - The map will automatically start tracking your location
   - Your current location will be displayed on the map
   - Location history is maintained and can be accessed

3. Stop Tracking:
   - Location tracking automatically stops when the map view is dismissed
   - You can also manually stop tracking by calling `stopTracking()`

## Architecture

The app follows Clean Architecture principles:

- Domain Layer: Contains business logic and entities
- Data Layer: Implements repository interfaces
- Presentation Layer: Handles UI and user interactions
- Infrastructure Layer: Provides common utilities

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details 