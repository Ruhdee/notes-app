import 'package:flutter/material.dart';
import '../../view_models/auth_view_model.dart';

class LoginView extends StatefulWidget {
  final AuthViewModel authVM;
  const LoginView({required this.authVM, super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailCtrl = TextEditingController();
  final pwCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.authVM.addListener(_onChange);
  }

  void _onChange() => setState(() {});
  @override
  void dispose() {
    widget.authVM.removeListener(_onChange);
    emailCtrl.dispose();
    pwCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  cursorColor: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pwCtrl,
                  obscureText: !widget.authVM.isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: theme.colorScheme.primary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        !widget.authVM.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: widget.authVM.togglePasswordVisibility,
                    ),
                  ),
                  cursorColor: theme.colorScheme.primary,
                ),
                const SizedBox(height: 8),
                if (widget.authVM.error != null)
                  Text(
                    widget.authVM.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 16),
                widget.authVM.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              widget.authVM.signIn(emailCtrl.text, pwCtrl.text),
                          child: const Text('Sign In'),
                        ),
                      ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
