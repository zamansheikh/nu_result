# 📘 NU Result - CGPA Calculator & Marksheet Generator

A modern, clean and intuitive Flutter app designed specifically for **National University (Bangladesh)** students to calculate CGPA and generate professional marksheets.

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-blue?logo=dart)](https://dart.dev)
[![GitHub Repo](https://img.shields.io/badge/GitHub-zamansheikh/nu_result-blue?logo=github)](https://github.com/zamansheikh/nu_result)

---

## ✨ Features

### 🧮 CGPA Calculator
- **Modern Interface** – Clean, intuitive design with smooth animations
- **Semester Management** – Add, edit, and organize multiple semesters
- **Real-time Calculation** – Instant SGPA and CGPA calculations as you type
- **Grade Visualization** – Color-coded grades with grade point display
- **Data Persistence** – All your data is saved locally and securely
- **Flexible Credits** – Support for 1-6 credit courses
- **Grade Scale** – Full A+ to F grading system with accurate grade points

### 📄 Marksheet Generator
- **Professional PDFs** – Generate university-standard marksheets
- **Semester Selection** – Choose specific semesters to include
- **Student Information** – Complete student details and academic info
- **Detailed Results** – Subject-wise grades, credits, and grade points
- **Statistics Summary** – Cumulative CGPA, total credits, and semesters
- **Instant Download** – Direct PDF generation and opening
- **Official Format** – Follows National University marksheet standards

### 📊 Analytics & Insights
- **SGPA Trends** – Visual charts showing semester-wise performance
- **Credits Distribution** – Bar charts for credit analysis
- **Performance Overview** – Highest/lowest SGPA tracking
- **Progress Monitoring** – Track academic improvement over time

---

## 🎨 Design Highlights

### Modern UI/UX
- **Material Design 3** – Latest design system implementation
- **Gradient Themes** – Beautiful color gradients throughout the app
- **Smooth Animations** – Fluid transitions and micro-interactions
- **Card-based Layout** – Clean, organized information display
- **Responsive Design** – Optimized for all screen sizes

### Color Scheme
- **Primary**: Purple gradient (#6C5CE7 → #A29BFE)
- **Secondary**: Orange gradient (#E17055 → #FD79A8)
- **Accent Colors**: Contextual colors for grades and statistics

### Typography
- **Font Family**: OpenSans - clean, readable, professional
- **Font Weights**: Regular, Medium, Bold for proper hierarchy
- **Multilingual Support**: Bengali (TiroBangla) for local content

---

## 🏗️ Architecture

Built with **Clean Architecture** principles:

```
lib/
├── core/                     # Core functionality
├── shared/                   # Shared models and widgets
│   ├── models/              # Data models (Semester, Subject)
│   └── widgets/             # Reusable UI components
├── features/
│   ├── home/                # Welcome screen
│   ├── cgpa_calculator/     # CGPA calculation feature
│   │   └── presentation/
│   │       └── pages/
│   │           ├── cgpa_home_page.dart
│   │           ├── cgpa_calculator_page.dart
│   │           └── cgpa_analytics_page.dart
│   └── marksheet_generator/ # PDF generation feature
│       └── presentation/
│           └── pages/
│               └── marksheet_generator_page.dart
└── main.dart                # App entry point
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.24+
- Dart 3.9+
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/zamansheikh/nu_result.git
   cd nu_result
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release
```

---

## 📱 How to Use

### CGPA Calculator

1. **Launch the App** → Tap "CGPA Calculator" from home screen
2. **Add Semester** → Tap the floating action button to create a new semester
3. **Add Subjects** → Enter subject names, credits, and grades
4. **Real-time Updates** → Watch your SGPA calculate automatically
5. **View Analytics** → Tap the analytics icon to see performance charts

### Marksheet Generator

1. **Navigate to Generator** → Tap "Marksheet Generator" from home screen
2. **Fill Student Info** → Enter name, registration, session, and college
3. **Select Semesters** → Choose which semesters to include
4. **Generate PDF** → Tap "Generate Marksheet" button
5. **Download & Share** → PDF opens automatically for viewing/sharing

---

## 🛠️ Technical Details

### Dependencies
- **flutter**: SDK framework
- **shared_preferences**: Local data storage
- **pdf**: PDF generation
- **path_provider**: File system access
- **open_file**: PDF viewer integration
- **fl_chart**: Beautiful charts and analytics
- **material3**: Modern design system

### Data Storage
- **Local Storage**: SharedPreferences for semester data
- **Data Format**: JSON serialization for complex objects
- **Persistence**: All data saved automatically

### PDF Generation
- **Library**: flutter_pdf package
- **Format**: A4 size, professional layout
- **Content**: Student info, semester tables, statistics
- **Branding**: University logo and app attribution

---

## 🎯 Key Improvements

### From Previous Version
- **Simplified Focus** → Only essential features (CGPA + Marksheet)
- **Modern Design** → Complete UI/UX redesign with Material 3
- **Better Performance** → Optimized code and smooth animations
- **Enhanced UX** → Intuitive navigation and user flows
- **Professional Output** → High-quality PDF marksheets
- **Clean Architecture** → Maintainable and scalable codebase

### Removed Features
- Result scraping functionality (web-based)
- Firebase integration
- AdMob advertisements
- Complex routing system
- Multiple app themes

---

## 🔮 Future Enhancements

- [ ] Cloud sync for data backup
- [ ] Export data to Excel/CSV
- [ ] Grade prediction algorithms
- [ ] Scholarship eligibility calculator
- [ ] Batch PDF generation
- [ ] Print-friendly marksheet layouts

---

## 👨‍💻 Developer

**Zaman Sheikh**
- GitHub: [@zamansheikh](https://github.com/zamansheikh)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **National University, Bangladesh** for the academic standards
- **Flutter Team** for the amazing framework
- **Material Design** for the design system
- **NU Students** for feedback and feature requests

---

**Built with ❤️ for National University Students**

*Experience the modern way to calculate CGPA and generate professional marksheets!*

- 🔍 **Profile Lookup** – View student profile using registration/roll number.
- 📊 **Result Checker** – Get results for any exam (Professional, Honours, Degree, etc.).
- 📄 **PDF Export** – Download and share your marksheet as a well-formatted PDF.
- 🔐 **Secure & Fast** – Reliable connection to NU’s result system with optimized loading.
- 🌓 **Dark Mode Support** – Smooth UI with light and dark mode.

---

## 🧱 Built With

- **Flutter** – Cross-platform app development.
- **Dart** – Fast and expressive language.
- **GetX** – State management and routing.
- **PDF Library** – For marksheet export.
- **Clean Architecture** – Scalable and testable codebase.

---

## 📱 Screenshots

> _Add screenshots here after development – UI previews of profile, result view, and PDF download._

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK**: Comes with Flutter.
- **IDE**: Android Studio or VS Code.

### Run Locally

```bash
git clone https://github.com/zamansheikh/nu_result.git
cd nu_result
flutter pub get
flutter run
```

---

## 📦 Folder Structure (Clean Architecture)

```
lib/
├── core/
├── features/
│   ├── profile/
│   ├── result/
│   ├── pdf_export/
├── shared/
```

---

## 🛠️ Contribution

Contributions are welcome! Feel free to fork the repo and submit a pull request.

### Steps to Contribute

1. Fork the repository.
2. Create a new branch for your feature:
   ```bash
   git checkout -b feature/YourFeature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add: Your feature"
   ```
4. Push to your branch:
   ```bash
   git push origin feature/YourFeature
   ```
5. Open a pull request.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🔗 Related Projects

- [National University Bangladesh Result Site](http://www.nu.ac.bd/results/)

---

## 👨‍💻 Author

Developed by [Zaman Sheikh](https://github.com/zamansheikh).

---

> _If you like this project, consider giving it a ⭐ on GitHub!_