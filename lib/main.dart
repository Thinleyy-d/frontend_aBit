import 'package:flutter/material.dart';

// Screen Imports
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/account_success_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/job_category_screen.dart';
import 'screens/employer_dashboard_screen.dart';
import 'screens/organization_profile_form_screen.dart';
import 'screens/logo_upload_screen.dart';
import 'screens/application_screen.dart';
import 'screens/profile_creation_screen.dart'; // Add this import
import 'screens/home_dashboard_screen.dart'; // Add this import

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gawean Job Portal',
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
        primaryColor: const Color(0xFF4C7DFF),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4C7DFF),
          secondary: Color(0xFF8EACFE),
          tertiary: Color(0xFFC7D3FC),
          error: Color(0xFFEA5A5A),
          onPrimary: Colors.white,
          onSurface: Colors.black87,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF4C7DFF), width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFEA5A5A), width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFFEA5A5A), width: 1.0),
          ),
          labelStyle: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
          hintStyle: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
          errorStyle: const TextStyle(color: Color(0xFFEA5A5A), fontSize: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4C7DFF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            minimumSize: const Size(double.infinity, 56),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF4C7DFF),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF4C7DFF);
            }
            return const Color(0xFFB0B0B0);
          }),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF4C7DFF);
            }
            return const Color(0xFFB0B0B0);
          }),
          side: const BorderSide(color: Color(0xFFB0B0B0), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/otp_verification': (context) => const OtpVerificationScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/account_success': (context) => const AccountSuccessScreen(),
        '/home': (context) => const HomeScreen(),
        '/job_category': (context) => const JobCategoryScreen(),
        '/employer_dashboard': (context) => const EmployerDashboardScreen(),
        '/organization_profile_form': (context) => const OrganizationProfileFormScreen(),
        '/applications': (context) => const ApplicationsScreen(),
        '/logo_upload': (context) => LogoUploadScreen(
          onLogoSelected: (String imagePath) {
            // Handle logo selection
          },
        ),
        '/profile-creation': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as List<String>;
          return ProfileCreationScreen(selectedJobCategories: args);
        },
        '/home-dashboard': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return HomeDashboardScreen(
            name: args['name'],
            jobCategories: args['jobCategories'],
          );
        },
      },
    );
  }
}