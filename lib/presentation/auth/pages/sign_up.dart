// import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/config/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/presentation/auth/pages/sign_in.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/service_locator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _fullName;
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _clearFields() {
    _fullName.clear();
    _email.clear();
    _password.clear();
  }

  Future<void> _handleSignUp() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      var result = await sl<SignupUseCase>().call(
        params: CreateUserReq(
          fullName: _fullName.text.toString(),
          email: _email.text.toString(),
          password: _password.text.toString(),
        ),
      );

      if (!mounted) return;

      result.fold(
        (left) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(left.toString())));
          setState(() {
            _isLoading = false;
          });
        },
        (right) {
          _clearFields();
          setState(() {
            _isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomePage
              (),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
      appBar: BasicAppBar(showLogo: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 57),
              _fullNameField(context),
              const SizedBox(height: 16),
              _emailField(context),
              const SizedBox(height: 16),
              _passwordField(context),
              const SizedBox(height: 34),
              BasicAppButton(
                onPressed: _isLoading ? null : _handleSignUp,
                label: _isLoading ? 'Creating Account...' : 'Create Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Full Name...',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Enter Email...',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Enter Password...',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account ?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
