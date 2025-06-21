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
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void validateAndSignUp() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          errorMessage = S.current.error_password;
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E1E99), Color(0xFF6E33D1)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_add, size: 48, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    S.current.join_text,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S.current.create_account,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: fullNameController,
                          labelText: S.current.field_username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.current.error_msg_username;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: emailController,
                          labelText: S.current.field_email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.current.error_msg_email;
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return S.current.error_msg_email_2;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: passwordController,
                          labelText: S.current.field_password,
                          obscureText: !_isPasswordVisible,
                          suffixIcon: _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixIconPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.current.error_msg_password;
                            }
                            if (value.length < 6) {
                              return S.current.error_msg_password_2;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: confirmPasswordController,
                          labelText: S.current.field_cpassword,
                          obscureText: !_isConfirmPasswordVisible,
                          suffixIcon: _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixIconPressed: () => setState(() =>
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.current.error_msg_cpassword;
                            }
                            return null;
                          },
                        ),
                        if (errorMessage != null) ...[
                          const SizedBox(height: 12),
                          Text(errorMessage!,
                              style: TextStyle(color: Colors.redAccent)),
                        ],
                        const SizedBox(height: 24),
                        BlocBuilder<SignUpCubit, SignUpState>(
                          buildWhen: (previous, current) {
                            if (current.userProfile != null) {
                              context.goNamed(HomePage.routeName);
                            }
                            return true;
                          },
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: state.isLoading ? null : validateAndSignUp,
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF4e57f6),
                                      Color(0xFFe66465)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: state.isLoading
                                    ? CircularProgressIndicator.adaptive(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white))
                                    : Text(
                                        S.current.btn_create_acc,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.g_mobiledata,
                                  size: 32, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.facebook,
                                  size: 32, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.apple,
                                  size: 32, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.go('/signin'),
                          child: Text(
                            S.current.alr_acc,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
      validator: validator,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: Colors.grey),
                onPressed: onSuffixIconPressed)
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      ),
    );
  }
}
