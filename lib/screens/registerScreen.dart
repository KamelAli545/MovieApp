import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/cubit/auth_cubit.dart';
import 'package:movieapp/screens/loginScreen.dart';
import 'package:movieapp/widgets/inputWidgets.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242A32),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Lottie.asset('assets/animations/Popcorn.json',
                          height: 100,
                          width: 100
                      ),
                    ),
                    SizedBox(height: 10,),
                    const Text('Create an\naccount',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold,
                          color: Colors.white,

                        )),
                    const SizedBox(height: 15),
                    InputWidgets(
                      label: "Name",
                      prefixIcon: Icons.person,
                      controller: _name,
                      keyboardType: TextInputType.name,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Enter your name';
                        if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Name must contain a capital letter';
                        return null;
                      },
                      color: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    InputWidgets(
                      prefixIcon: Icons.email,
                      label: "Email",
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v)=>(
                          v==null||!v.contains('@')?
                          "Enter a vaild email":null
                      ),
                      color: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    InputWidgets(
                      prefixIcon: Icons.lock,
                      label: "Password",
                      controller: _password,
                      obscureText: true,
                      validator: (v)=>(
                          v==null||v.length<6?
                          "Enter a More Than 6 Characters ":null
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 15,),
                    InputWidgets(
                      prefixIcon: Icons.lock,
                      label: 'Confirm Password',
                      controller: _confirm,
                      obscureText: true,
                      validator: (v) =>
                      (v == null || v != _password.text) ? "Passwords don't match" : null,
                      color: Colors.white,

                    ),

                    const SizedBox(height: 24),
                    Text.rich(
                      const TextSpan(
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        children: [
                          TextSpan(text: 'By clicking the ',
                           style: TextStyle(
                             color: Colors.white
                           )
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' button, you agree to the public offer',
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                                _name.text,
                                _email.text,
                                _password.text);
                          }
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Sign Up',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LoginScreen())),
                      child: Center(
                        child: const Text("Do have an account? Login",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
