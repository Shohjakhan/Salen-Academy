import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/domain/sing_in_cubit/sign_in_cubit.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  void validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<SignInCubit>(context).onSignIn(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
                  const Icon(Icons.lock, size: 48, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    S.current.welcome_back,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S.current.sign_in_text,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: emailController,
                          labelText: S.current.field_email,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return S.current.error_msg_email;
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
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return S.current.error_msg_password;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v!),
                                  activeColor: Colors.white,
                                  checkColor: Color(0xFF6E33D1),
                                ),
                                Text(S.current.rem_me,
                                    style:
                                        const TextStyle(color: Colors.white70)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(S.current.forgot_password,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SignInCubit, SignInState>(
                          buildWhen: (prev, curr) {
                            if (curr.signInModel != null) {
                              context.go('/home');
                            }
                            return true;
                          },
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: state.isLoading ? null : validateAndLogin,
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4e57f6),
                                      Color(0xFFe66465)
                                    ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0, 4)),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: state.isLoading
                                    ? const CircularProgressIndicator.adaptive(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white))
                                    : Text(S.current.btn_sign_in,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
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
                              icon: const Icon(Icons.g_mobiledata,
                                  size: 32, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.facebook,
                                  size: 32, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.apple,
                                  size: 32, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.go('/signup'),
                          child: Text(
                            S.current.dont_acc,
                            style: const TextStyle(color: Colors.white70),
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
