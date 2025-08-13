import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl =
      TextEditingController(text: AuthController.allowedUsername);
  final _passwordCtrl =
      TextEditingController(text: AuthController.allowedPassword);

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    const greenColor = Color(0xFF2ECC71);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(Icons.lock_outline,
                              size: 60, color: greenColor),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _usernameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon:
                                  const Icon(Icons.person, color: greenColor),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: greenColor, width: 2),
                              ),
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Enter username'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordCtrl,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon:
                                  const Icon(Icons.lock, color: greenColor),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: greenColor, width: 2),
                              ),
                            ),
                            obscureText: true,
                            validator: (v) => v == null || v.isEmpty
                                ? 'Enter password'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          if (auth.error.isNotEmpty)
                            Text(
                              auth.error.value,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: auth.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      auth.login(_usernameCtrl.text,
                                          _passwordCtrl.text);
                                    }
                                  },
                            child: auth.isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : const Text('Sign In',
                                    style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Hint:\nUsername: mor_2314\nPassword: 83r5^_',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
