import 'package:expense_manager/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/auth/bloc/auth_event.dart';
import 'package:expense_manager/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Expense Manager",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: SignUpForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _loading = false;

  void _handleSignup() {
    BlocProvider.of<AuthBloc>(context).add(
      SignUpUser(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated && _loading) {
          context.go("/");
        }

      },
      builder: (context, state) {
        if (state is AuthLoading) {
          _loading = true;
        }
        if (state is AuthError) {
          _loading = false;
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    hintText: 'John Doe',
                    labelText: 'Name',
                  ),
                  controller: _emailController,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: !_passwordVisible,
                  controller: _passwordController,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 0,
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child:
                        _loading
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 24),
                                Text("Signing"),
                              ],
                            )
                            : Text("Signup"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Padding(padding: EdgeInsets.all(10), child: Text("or")),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: FaIcon(FontAwesomeIcons.google),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: FaIcon(FontAwesomeIcons.xTwitter),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: FaIcon(FontAwesomeIcons.facebookF),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
