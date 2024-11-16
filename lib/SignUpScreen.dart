import 'package:flutter/material.dart';
import 'package:fluttertest/HomePage.dart';
import 'package:fluttertest/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _usernameController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _isPasswordValid &&
          _isConfirmPasswordValid &&
          _emailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty;
    });
  }

  bool get _isPasswordValid {
    final password = _passwordController.text;
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[\W_]+'));
  }

  bool get _isConfirmPasswordValid {
    return _passwordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5B5B5B),
                Color(0xFFE5E4E4),
                Color(0xFF5B5B5B),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/img/logotwob.png',
                  width: 360,
                  height: 200,
                ),
                SizedBox(height: 10),
                Text(
                  'إنشاء حساب',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField(
                  hintText: 'ادخل البريد الالكتروني',
                  controller: _emailController,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  hintText: 'اسم المستخدم',
                  controller: _usernameController,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  hintText: 'كلمة المرور',
                  obscureText: !_isPasswordVisible,
                  controller: _passwordController,
                  prefixIcon: IconButton(
                    icon: Image.asset(
                      'assets/img/EyePaswword.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPasswordRequirement(
                          'يجب أن تكون من 8 خانات على الأقل',
                          _passwordController.text.length >= 8),
                      _buildPasswordRequirement(
                          'يجب أن تشمل على حرف صغير وحرف كبير',
                          _passwordController.text.contains(RegExp(r'[A-Z]')) &&
                              _passwordController.text
                                  .contains(RegExp(r'[a-z]'))),
                      _buildPasswordRequirement(
                          'يجب أن تتضمن رمزاً خاصاً واحداً على الأقل',
                          _passwordController.text.contains(RegExp(r'[\W_]+'))),
                      _buildPasswordRequirement(
                          'يجب أن تحتوي على رقم واحداً على الأقل',
                          _passwordController.text.contains(RegExp(r'[0-9]'))),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _buildTextField(
                  hintText: 'كرر كلمة المرور',
                  obscureText: !_isConfirmPasswordVisible,
                  controller: _confirmPasswordController,
                  prefixIcon: IconButton(
                    icon: Image.asset(
                      'assets/img/EyePaswword.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                    username: _usernameController.text)),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor:
                        _isFormValid ? Color(0xFF70A9C2) : Colors.grey,
                  ),
                  child: Text(
                    'إنشاء الحساب',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'هل لديك حساب بالفعل؟ ',
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: 'تسجيل الدخول',
                            style: TextStyle(color: Color(0xFF70A9C2)),
                          ),
                        ],
                      ),
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

  Widget _buildTextField({
    String? hintText,
    bool obscureText = false,
    Widget? prefixIcon,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildPasswordRequirement(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.blue : Colors.white,
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
              color: isValid ? Colors.blue : Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
