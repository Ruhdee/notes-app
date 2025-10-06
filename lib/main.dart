import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'repositories/auth_repository.dart';
import 'repositories/notes_repository.dart';
import 'view_models/auth_view_model.dart';
import 'view_models/notes_view_model.dart';
import 'views/auth/login_view.dart';
import 'views/auth/signup_view.dart';
import 'views/notes/home_view.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authVM = AuthViewModel(AuthRepository());
  final notesVM = NotesViewModel(NotesRepository());

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: AuthWrapper(authVM: authVM, notesVM: notesVM),
      routes: {'/signup': (_) => SignupView(authVM: authVM)},
      theme: customTheme,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  final AuthViewModel authVM;
  final NotesViewModel notesVM;
  const AuthWrapper({required this.authVM, required this.notesVM, super.key});
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    widget.authVM.addListener(_onAuthChange);
  }

  void _onAuthChange() => setState(() {});
  @override
  void dispose() {
    widget.authVM.removeListener(_onAuthChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authVM.isAuthenticated) {
      return HomeView(authVM: widget.authVM, notesVM: widget.notesVM);
    }
    return LoginView(authVM: widget.authVM);
  }
}
