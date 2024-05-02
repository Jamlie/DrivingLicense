import 'package:flutter/material.dart';
import 'package:license/view_model/create_account.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUp> {
  late FocusNode _fullNameNode;
  late FocusNode _phoneNumberNode;
  late FocusNode _emailNode;
  late FocusNode _passwordNode;
  late FocusNode _confirmPasswordNode;
  late FocusNode _idNode;

  final CreateAccountViewModel _createAccountViewModel =
      CreateAccountViewModel();

  String? _message;
  String? _fullNameError;
  String? _phoneNumberError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _idError;

  String _signUpButton = "Sign up";
  bool _loading = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fullNameNode = FocusNode();
    _phoneNumberNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
    _idNode = FocusNode();
  }

  @override
  void dispose() {
    _fullNameNode.dispose();
    _phoneNumberNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    _idNode.dispose();

    super.dispose();
  }

  Widget? _textField({
    required FocusNode focusNode,
    required TextEditingController? controller,
    required String labelText,
    required String hintText,
    required String? errorText,
    required bool obscureText,
    required TextInputType keyboardType,
    required void Function(String) onChanged,
    required void Function(String)? onSubmitted,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: errorText == null ? const Color.fromRGBO(73, 69, 79, 1) : null,
          fontWeight: FontWeight.w500,
        ),
        focusColor: const Color(0xFF2E60F7),
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2E60F7), width: 2),
        ),
        errorText: errorText,
      ),
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  bool _checkValues() {
    return _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null ||
        _idError != null ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _idController.text.isEmpty ||
        _fullNameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty;
  }

  void _submitSignUp() {
    setState(() {
      _loading = true;
      _signUpButton = "Loading...";
    });

    bool hasError = false;

    _createAccountViewModel
        .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
            id: _idController.text)
        .then((value) {
      setState(() {
        _loading = false;
        _signUpButton = "Sign up";
        hasError = false;
      });
    }).catchError((e) {
      setState(() {
        _loading = false;
        _signUpButton = "Sign up";
        _message = e.toString().split(":")[1].trim();
        hasError = true;
      });
    });

    if (!hasError) {
      _createAccountViewModel.addUserToDatabase(
          email: _emailController.text,
          fullName: _fullNameController.text,
          phoneNumber: _phoneNumberController.text,
          id: _idController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _textField(
                  focusNode: _fullNameNode,
                  controller: _fullNameController,
                  labelText: "Full Name",
                  hintText: "Enter your name",
                  errorText: _fullNameError,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _fullNameError =
                          value.isEmpty ? "Full name is required" : null;
                    });
                  },
                  onSubmitted: (_) => _phoneNumberNode.requestFocus(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _textField(
                  focusNode: _phoneNumberNode,
                  controller: _phoneNumberController,
                  labelText: "Phone Number",
                  hintText: "Enter your phone number",
                  errorText: _phoneNumberError,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _phoneNumberError =
                          value.isEmpty ? "Phone number is required" : null;
                    });

                    if (_phoneNumberError == null) {
                      RegExp regExp = RegExp(
                          r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');
                      if (!regExp.hasMatch(value)) {
                        setState(() {
                          _phoneNumberError = "Invalid phone number";
                        });
                      } else {
                        setState(() {
                          _phoneNumberError = null;
                        });
                      }
                    }
                  },
                  onSubmitted: (_) => _emailNode.requestFocus(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _textField(
                  focusNode: _emailNode,
                  controller: _emailController,
                  labelText: "Email",
                  hintText: "Enter your email",
                  errorText: _emailError,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _emailError = value.isEmpty ? "Email is required" : null;
                    });

                    if (_emailError == null) {
                      RegExp regExp =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!regExp.hasMatch(value)) {
                        setState(() {
                          _emailError = "Invalid email";
                        });
                      } else {
                        setState(() {
                          _emailError = null;
                        });
                      }
                    }
                  },
                  onSubmitted: (_) => _passwordNode.requestFocus(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _textField(
                  focusNode: _passwordNode,
                  controller: _passwordController,
                  labelText: "Password",
                  hintText: "Enter your password",
                  errorText: _passwordError,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _passwordError =
                          value.isEmpty ? "Password is required" : null;
                    });

                    if (_passwordError == null) {
                      if (value.length < 8) {
                        setState(() {
                          _passwordError =
                              "Password must be at least 8 characters";
                        });
                      } else {
                        setState(() {
                          _passwordError = null;
                        });
                      }
                    }
                  },
                  onSubmitted: (_) => _confirmPasswordNode.requestFocus(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _textField(
                  focusNode: _confirmPasswordNode,
                  controller: _confirmPasswordController,
                  labelText: "Confirm Password",
                  hintText: "Confirm your password",
                  errorText: _confirmPasswordError,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _confirmPasswordError =
                          value.isEmpty ? "Confirm password is required" : null;
                    });

                    if (_confirmPasswordError == null) {
                      if (value != _passwordController.text) {
                        setState(() {
                          _confirmPasswordError = "Passwords do not match";
                        });
                      } else {
                        setState(() {
                          _confirmPasswordError = null;
                        });
                      }
                    }
                  },
                  onSubmitted: (_) => _idNode.requestFocus(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _textField(
                  focusNode: _idNode,
                  controller: _idController,
                  labelText: "ID",
                  hintText: "Enter your ID",
                  errorText: _idError,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _idError = value.isEmpty ? "ID is required" : null;
                    });

                    if (_idError == null) {
                      if (value.length != 9) {
                        setState(() {
                          _idError = "ID must be 9 digits";
                        });
                      } else {
                        setState(() {
                          _idError = null;
                        });
                      }
                    }
                  },
                  onSubmitted: null,
                ),
              ),
              ElevatedButton(
                onPressed: _checkValues() || _loading ? null : _submitSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E60F7),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _signUpButton,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.transparent,
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                _message ?? "",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
