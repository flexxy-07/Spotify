import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/presentation/auth/pages/sign_up.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/service_locator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isLoading = false;


  @override
  void initState(){
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController(); 
  }

  @override 
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _clearFields(){
    _email.clear();
    _password.clear();
  }

  Future<void> _handleSignIn() async {
    if(!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      var result = await sl<SigninUseCase>().call(
        params: SignInUserReq(email: _email.text.toString(), password: _password.text.toString())
      );

      if(!mounted) return;

      result.fold((left){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(left.toString()),));
        setState(() {
          _isLoading = false;
        });
      }, (right){
        _clearFields();
        setState(() {
          _isLoading = false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage
        ()), (route) => false);
      });
    }catch(e){
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An unexpected error occurred: ${e.toString()}'),));
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
              _passwordField(context),
              
              _recoverPasswordText(context),

              const SizedBox(height: 34),
               BasicAppButton(
                onPressed: _isLoading ? null : () => _handleSignIn(),
                label: _isLoading ? 'Signing In...' : 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Username or Email...',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password...',
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
            'Not a member ?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
          }, child: const Text('Register Now')),
        ],
      ),
    );
  }

  Widget _recoverPasswordText(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        child: const Text('Recover Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
