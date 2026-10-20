import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/cubit/auth_cubit.dart';
import 'package:movieapp/screens/registerScreen.dart';
import 'package:movieapp/widgets/inputWidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242A32),
      body: BlocConsumer<AuthCubit,AuthState>(
        listener: (context,state){
          if(state is AuthError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context,state){
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Lottie.asset('assets/animations/Popcorn.json',
                            height: 200,
                            width: 200
                        ),
                      ),
                      Text("Welcome\nBack!",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 15,),
                     InputWidgets(
                       prefixIcon: Icons.email,
                       label: "Email",
                         controller: _email,
                       validator: (v)=>(
                           v==null||!v.contains('@')?
                           "Enter a valid email":null
                       ),
color: Colors.white,
                     ),
                      SizedBox(height: 15,),
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
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .login(_email.text, _password.text);
                            }
                          },
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text("OR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen())),
                        child: Center(
                          child: const Text("Create An Account? Sign Up",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                        ),
                      ),





                    ],
                  )),
            ),
          );
        },
      ),




    );
  }
}
