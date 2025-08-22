import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../widgets/gawean_logo.dart';
import '../widgets/gradient_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/account_success');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up failed: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Color.fromARGB(255, 128, 128, 128),
            onPressed: () {
              Navigator.pushNamed(context, '/splash');
            }, // Back arrow functionality
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 20.0 : 24.0,
                vertical: 16.0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const GaweanLogo(
                        iconSize: 64,
                        fontSize: 28,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Create Account',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Join us to get started',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      _buildEmailField(theme),
                      const SizedBox(height: 16),
                      _buildPasswordField(theme),
                      const SizedBox(height: 16),
                      _buildConfirmPasswordField(theme),
                      const SizedBox(height: 16),
                      _buildRememberMeCheckbox(theme),
                      const SizedBox(height: 8),
                      _buildTermsCheckbox(theme),
                      const SizedBox(height: 24),
                      _buildSignUpButton(theme),
                      const SizedBox(height: 32),
                      _buildDividerWithText(theme),
                      const SizedBox(height: 24),
                      _buildSocialAuthButtons(isSmallScreen),
                      const SizedBox(height: 24),
                      _buildSignInPrompt(theme),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(ThemeData theme) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Color.fromARGB(255, 128, 128, 128)),
        hintText: 'Karma@gmail.com',
        hintStyle: TextStyle(color: Color.fromARGB(255, 128, 128, 128)),
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Color.fromARGB(255, 176, 176, 176),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(color: Colors.black),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(ThemeData theme) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: '••••••••',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: const Color.fromARGB(255, 109, 108, 108),
          ),
          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(color: Colors.black),
      obscureText: !_passwordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      onChanged: (value) {
        if (_confirmPasswordController.text.isNotEmpty) {
          _formKey.currentState?.validate();
        }
      },
    );
  }

  Widget _buildConfirmPasswordField(ThemeData theme) {
    return TextFormField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: '••••••••',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: const Color.fromARGB(255, 109, 108, 108),
          ),
          onPressed: () => setState(
              () => _confirmPasswordVisible = !_confirmPasswordVisible),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(color: Colors.black),
      obscureText: !_confirmPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

Widget _buildRememberMeCheckbox(ThemeData theme) {
  return Row(
    children: [
      Checkbox(
        value: _rememberMe,
        onChanged: (value) => setState(() => _rememberMe = value ?? false),
        checkColor: Colors.white, // White tick when checked
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF4C7DFF); // Blue when checked
            }
            return Colors.grey; // Grey when unchecked
          },
        ),
      ),
        Text(
          'Remember me',
          style: TextStyle(
            color: Color.fromARGB(255, 176, 176, 176),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: theme.copyWith(
            unselectedWidgetColor: Color.fromARGB(255, 176, 176, 176),
          ),
          child: Checkbox(
            value: _termsAccepted,
            onChanged: (value) =>
                setState(() => _termsAccepted = value ?? false),
            checkColor: theme.colorScheme.primary,
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (states) => states.contains(MaterialState.selected)
                  ? Colors.white
                  : Color.fromARGB(255, 176, 176, 176),
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Color.fromARGB(255, 176, 176, 176),
                fontSize: 14,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 76, 125, 255),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to terms screen
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 76, 125, 255),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to privacy policy screen
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signUp,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 76, 125, 255),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: _isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.black,
              ),
            )
          : Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
    );
  }

  Widget _buildDividerWithText(ThemeData theme) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color.fromARGB(255, 103, 102, 102),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or sign up with',
            style: TextStyle(
              color: Color.fromARGB(255, 103, 102, 102),
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color.fromARGB(255, 103, 102, 102),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialAuthButtons(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Color.fromARGB(255, 228, 228, 228)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {},
            icon: Image.asset('assets/facebook_logo.png',
                height: 24, color: Color.fromARGB(255, 24, 119, 242)),
            label: const Text('Facebook'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Color.fromARGB(255, 228, 228, 228)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {},
            icon: Image.asset('assets/google_logo.webp', height: 24),
            label: const Text('Google'),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInPrompt(ThemeData theme) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        children: [
          const TextSpan(text: 'Already have an account? '),
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: Color.fromARGB(255, 76, 125, 255),
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pushReplacementNamed(context, '/signin'),
          ),
        ],
      ),
    );
  }
}