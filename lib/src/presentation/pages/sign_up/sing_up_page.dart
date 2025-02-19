import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/domain/sign_up_cubit/sign_up_cubit.dart';
import 'package:salen_academy/src/presentation/pages/home_page/home_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool _isPasswordVisible = false; // To toggle password visibility
  bool _isConfirmPasswordVisible =
      false; // To toggle confirm password visibility

  // Function to validate all fields
  void validateAndSignUp() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          errorMessage = 'Passwords do not match!';
        });
      } else {
        setState(() {
          errorMessage = null;
        });
        BlocProvider.of<SignUpCubit>(context).onSignUp(
          userName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
        // Proceed with sign-up logic
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffa130),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
          // Background 3D shapes for aesthetic appeal
          Positioned(
            bottom: 40,
            left: 40,
            child: _build3DShape(Colors.white.withOpacity(0.3)),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: _build3DShape(Colors.white.withOpacity(0.2)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Salen Academy',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                S.current.welcome_text_2,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current.sign_up_text,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 30),
                              // Full Name Field
                              _buildTextField(
                                controller: fullNameController,
                                labelText: S.current.field_username,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.current.field_username_text;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Email Field
                              _buildTextField(
                                controller: emailController,
                                labelText: S.current.field_email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.current.field_email_text;
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Password Field with toggle visibility
                              _buildTextField(
                                controller: passwordController,
                                labelText: 'Password',
                                obscureText: !_isPasswordVisible,
                                suffixIcon: _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onSuffixIconPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              // Confirm Password Field with toggle visibility
                              _buildTextField(
                                controller: confirmPasswordController,
                                labelText: 'Confirm Password',
                                obscureText: !_isConfirmPasswordVisible,
                                suffixIcon: _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onSuffixIconPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              // Error Message
                              if (errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    errorMessage!,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 14.0),
                                  ),
                                ),
                              const SizedBox(height: 20),
                              // Sign Up Button
                              BlocBuilder<SignUpCubit, SignUpState>(
                                buildWhen: (previous, current) {
                                  if (current.userModel != null) {
                                    context.goNamed(HomePage.routeName);
                                  }

                                  return true;
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: state.isLoading
                                        ? null
                                        : validateAndSignUp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFffa130),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 100,
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      shadowColor: Colors.grey.withOpacity(0.3),
                                      elevation: 10,
                                    ),
                                    child: state.isLoading
                                        ? CircularProgressIndicator.adaptive()
                                        : const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextField Widget with modern UI and optional password visibility toggle
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    bool obscureText = false,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 14.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: Colors.black54),
                onPressed: onSuffixIconPressed,
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.orange),
        ),
      ),
      validator: validator,
    );
  }

  // 3D shape effect for background
  Widget _build3DShape(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 50,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
