# 📘 NU Result - CGPA Calculator & Marksheet Generator

A modern, elegant, and comprehensive Flutter app designed specifically for **National University (Bangladesh)** students to calculate CGPA and generate professional academic marksheets with QR codes.

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-blue?logo=dart)](https://dart.dev)
[![GitHub Repo](https://img.shields.io/badge/GitHub-zamansheikh/nu_result-blue?logo=github)](https://github.com/zamansheikh/nu_result)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Downloads](https://img.shields.io/badge/Downloads-1K+-brightgreen)](https://play.google.com/store/apps/details?id=com.decodersfamily.nu_result)

---

## ✨ Features

### 🧮 CGPA Calculator
- **Modern Interface** – Clean, intuitive design with smooth animations
- **Semester Management** – Add, edit, and organize multiple semesters locally
- **Real-time Calculation** – Instant SGPA and CGPA calculations as you type
- **Grade Visualization** – Color-coded grades with grade point display
- **Local Storage Only** – All calculations stored on your device, no cloud sync
- **Flexible Credits** – Support for 1-6 credit courses
- **Grade Scale** – Full A+ to F grading system with accurate grade points

### 📄 Marksheet Generator
- **Professional PDFs** – Generate university-standard academic transcripts locally
- **QR Code Integration** – Embedded PlayStore download & Telegram community QR codes
- **Static Generation** – Create PDFs directly on your device without any server
- **Semester Selection** – Choose specific semesters to include in transcript
- **Student Information Forms** – Fill in student details for transcript generation
- **Detailed Results** – Subject-wise grades, credits, and grade points calculation
- **Statistics Summary** – Cumulative CGPA, total credits, and semester count
- **Instant Download** – Direct PDF generation and automatic opening
- **Official Format** – "Generated Academic Transcript" format with professional styling
- **Smart Data Management** – "Load Previous" feature for quick form filling

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

4. **Build APK for release**
   ```bash
   flutter build apk --release --split-per-abi
   ```

---

## 📥 Download & Installation

### 🤖 Google Play Store
[![Get it on Google Play](https://img.shields.io/badge/Get%20it%20on-Google%20Play-brightgreen?style=for-the-badge&logo=google-play)](https://play.google.com/store/apps/details?id=com.decodersfamily.nu_result)

### 📱 Direct APK Download
- **Latest Release**: [GitHub Releases](https://github.com/zamansheikh/nu_result/releases)
- **Development Build**: Available in the repository

---

## 🤝 Community & Support

### 📢 Join Our Community
- **Telegram Group**: Scan QR code in generated PDFs for instant access
- **GitHub Discussions**: [Project Discussions](https://github.com/zamansheikh/nu_result/discussions)
- **Issue Reporting**: [GitHub Issues](https://github.com/zamansheikh/nu_result/issues)

### 📧 Contact Developer
- **Email**: zaman6545@gmail.com
- **GitHub**: [@zamansheikh](https://github.com/zamansheikh)
- **Portfolio**: [zamansheikh.com](https://zamansheikh.com)
- **Company**: [ProgrammerNexus](https://www.programmernexus.com)

---

## 🛡️ Privacy & Security

### 🔒 Data Protection
- **100% Static App**: No data collection or transmission to any servers
- **Purely Local Operations**: All calculations and PDF generation happen on your device
- **No Data Storage**: App doesn't save or store any personal information
- **No Tracking**: Zero analytics, no behavior monitoring, no user profiling
- **No Internet Required**: Complete offline functionality, no network permissions
- **No Ads**: Clean, advertisement-free experience with no ad tracking

### 📋 Privacy Policy
- **Full Policy**: [Privacy Policy](docs/privacy-policy.html)
- **Last Updated**: September 5, 2025
- **GDPR Compliant**: European data protection standards

---

## 🛠️ Technical Specifications

### Dependencies
- **flutter**: Cross-platform SDK framework
- **shared_preferences**: Secure local data storage  
- **pdf**: Professional PDF generation
- **path_provider**: File system access
- **open_file**: Integrated PDF viewer
- **fl_chart**: Interactive analytics charts
- **material3**: Modern Material Design 3

### Architecture
- **Clean Architecture**: Separation of concerns with feature-based modules
- **Data Persistence**: JSON serialization with SharedPreferences
- **PDF Generation**: Custom layouts with QR code integration
- **State Management**: StatefulWidget with efficient rebuilding
- **Performance**: Optimized rendering and memory management

---

## 🎯 Key Improvements (Version 2.0)

### ✅ Enhanced Features
- **Modern UI/UX** → Complete redesign with Material Design 3
- **QR Code Integration** → Embedded community and download links in PDFs
- **Data Persistence** → Smart "Load Previous" functionality for student info
- **Professional PDFs** → University-standard academic transcript format
- **Analytics Dashboard** → Visual performance tracking with interactive charts
- **Offline-First** → Complete functionality without internet connectivity

### ❌ Removed Legacy Features
- Result web scraping functionality
- Firebase cloud integration
- AdMob advertisements and tracking
- Complex multi-theme system
- Unnecessary external dependencies

---

## 🔮 Future Roadmap

- [ ] **Cloud Backup**: Optional data synchronization across devices
- [ ] **Export Options**: Excel/CSV export for academic records
- [ ] **Grade Prediction**: AI-powered semester performance forecasting
- [ ] **Scholarship Calculator**: Eligibility assessment for academic scholarships
- [ ] **Batch Operations**: Multiple marksheet generation with templates
- [ ] **Print Optimization**: Enhanced layouts for direct printing
- [ ] **Multi-Language**: Full Bengali language support
- [ ] **Dark Mode**: System-adaptive theme switching

---

## 🛠️ Development & Contribution

### Build from Source
```bash
# Clone repository
git clone https://github.com/zamansheikh/nu_result.git
cd nu_result

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run

# Build release APK
flutter build apk --release --split-per-abi
```

### Contributing Guidelines
1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'Add amazing feature'`
4. **Push** to branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request with detailed description

### Development Environment
- **Flutter SDK**: 3.24+
- **Dart SDK**: 3.9+
- **Android Studio**: Latest stable version
- **Target SDK**: Android 14 (API 34)
- **Minimum SDK**: Android 5.0 (API 21)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### License Summary
- ✅ **Commercial Use**: Allowed
- ✅ **Modification**: Allowed  
- ✅ **Distribution**: Allowed
- ✅ **Private Use**: Allowed
- ❌ **Liability**: Not provided
- ❌ **Warranty**: Not provided

---

## 🙏 Acknowledgments

- **Flutter Team** – For the incredible cross-platform framework
- **Material Design Team** – For the beautiful design system guidelines
- **National University Students** – For valuable feedback and feature requests
- **Open Source Community** – For inspiring transparent development
- **Beta Testers** – For helping perfect the user experience

---

## 👨‍💻 Author

**Zaman Sheikh** - *Founder, ProgrammerNexus*
- 🌐 **GitHub**: [@zamansheikh](https://github.com/zamansheikh)
- 📧 **Email**: zaman6545@gmail.com
- 💼 **Portfolio**: [zamansheikh.com](https://zamansheikh.com)
- 🏢 **Company**: [ProgrammerNexus](https://www.programmernexus.com)

---

## ⭐ Support This Project

If this app helped you in your academic journey, consider:
- ⭐ **Star this repository** on GitHub
- 🐛 **Report bugs** or suggest features via Issues
- 💬 **Join our Telegram community** (QR code in generated PDFs)
- 📢 **Share with fellow students** who might benefit from this app

---

**🎓 Built with ❤️ for National University Students**

*Experience the modern, professional way to calculate CGPA and generate academic marksheets with embedded QR codes for enhanced connectivity!*
