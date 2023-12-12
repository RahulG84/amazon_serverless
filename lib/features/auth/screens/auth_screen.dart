import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

enum Auth {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth_screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signupUser() {
    authService.signupUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      address: _addressController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool secureText = true;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  'Welcome..',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  tileColor: _auth == Auth.signUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text('Create Account'),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(
                        () {
                          _auth = value!;
                        },
                      );
                    },
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Name',
                              prefixIcon:
                              const Icon(Icons.person, color: Colors.black),
                              controller: _nameController,
                              secureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                              controller: _emailController,
                              secureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: 'Password',
                              prefixIcon:
                              const Icon(Icons.key, color: Colors.black),
                              controller: _passwordController,
                              secureText: true,
                              suffixIcon: IconButton(
                                  icon:  const Icon(
                                      Icons.visibility
                                    //secureText ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      secureText = !secureText;
                                    });
                                  }
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              buttonTile: 'Sign Up',
                              onPressed: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signupUser();
                                }
                              },
                            ),
                          ],
                        )),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text('Sign In'),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(
                        () {
                          _auth = value!;
                        },
                      );
                    },
                  ),
                ),
                if (_auth == Auth.signIn)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Email',
                            secureText: false,
                            prefixIcon:
                                const Icon(Icons.email, color: Colors.black),
                            controller: _emailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            hintText: 'Password',
                            secureText: secureText,
                            suffixIcon: IconButton(
                              icon:  const Icon(
                                Icons.visibility
                                //secureText ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  secureText = !secureText;
                                });
                              }
                            ),
                            prefixIcon:
                                const Icon(Icons.key, color: Colors.black),
                            controller: _passwordController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            buttonTile: 'Sign In',
                            onPressed: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
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
    );
  }
}
