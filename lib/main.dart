import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screen Imports
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart' as sign_up;
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
import 'screens/profile_creation_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/create_vacancy_screen.dart';
import 'screens/requirements_selection_screen.dart';
import 'screens/job_vacancy_posted_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check if profile exists
  final prefs = await SharedPreferences.getInstance();
  final hasProfile = prefs.getBool('hasProfile') ?? false;
  
  runApp(GaweanJobPortal(hasProfile: hasProfile));
}

class GaweanJobPortal extends StatelessWidget {
  final bool hasProfile;
  
  const GaweanJobPortal({super.key, required this.hasProfile});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gawean Job Portal',
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      initialRoute: hasProfile ? '/home-dashboard' : '/splash',
      onGenerateRoute: _generateRoute,
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
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
        centerTitle: true,
      ),
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      radioTheme: _buildRadioTheme(),
      checkboxTheme: _buildCheckboxTheme(),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C7DFF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        minimumSize: const Size(double.infinity, 56),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF4C7DFF),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  RadioThemeData _buildRadioTheme() {
    return RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF4C7DFF);
        }
        return const Color(0xFFB0B0B0);
      }),
    );
  }

  CheckboxThemeData _buildCheckboxTheme() {
    return CheckboxThemeData(
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
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/landing':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => sign_up.SignUpScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/otp_verification':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            phoneNumber: args['phoneNumber']!,
            verificationId: args['verificationId']!,
          ),
        );
      case '/reset_password':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(
            email: args['email']!,
            token: args['token']!,
          ),
        );
      case '/account_success':
        return MaterialPageRoute(builder: (_) => const AccountSuccessScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/CreateVacancy':
        return MaterialPageRoute(builder: (_) => const CreateVacanciesScreen());
      case '/job_category':
        return MaterialPageRoute(builder: (_) => const JobCategoryScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/employer_dashboard':
        return MaterialPageRoute(
            builder: (_) => const EmployerDashboardScreen());
      case '/organization_profile_form':
        return MaterialPageRoute(
            builder: (_) => const OrganizationProfileFormScreen());
      case '/applications':
        return MaterialPageRoute(builder: (_) => const ApplicationsScreen());
      case '/logo_upload':
        final onLogoSelected = settings.arguments as Function(String);
        return MaterialPageRoute(
          builder: (_) => LogoUploadScreen(onLogoSelected: onLogoSelected),
        );
      case '/profile-creation':
        final args = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (_) => ProfileCreationScreen(selectedJobCategories: args),
        );
      case '/home-dashboard':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => HomeDashboardScreen(
            name: args['name'] ?? 'User',
            jobCategories: args['jobCategories'] ?? [],
          ),
        );
      
      // New dynamic routes for vacancy creation flow
      case '/requirements_selection':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => RequirementsSelectionScreen(
            jobData: args['jobData'] ?? {},
            requirements: args['requirements'] ?? [],
          ),
        );
      case '/job_posted':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => JobVacancyPostedScreen(
            jobData: args['jobData'] ?? {},
            requirements: args['requirements'] ?? [],
          ),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }
}