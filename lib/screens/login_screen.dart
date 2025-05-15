import 'package:flutter/material.dart';
import 'package:mobatv04/screens/register_screen.dart';
import 'package:mobatv04/screens/forgot_password_screen.dart';
import '../database/user_dao.dart';
import '../models/user_model.dart';
import 'home_sceen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobatv04/widgets/custom_button.dart';
import 'package:mobatv04/widgets/custom_card.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const LoginScreen({super.key, required this.toggleTheme});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _lembrarUsuario = false;

  @override
  void initState() {
    super.initState();
    _carregarEmailSalvo();
  }

  void _carregarEmailSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    final emailSalvo = prefs.getString('email_salvo');
    if (emailSalvo != null) {
      final user = await UserDao.getUserByEmail(emailSalvo);
      if (user != null) {
        // Login automático
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(user: user, toggleTheme: widget.toggleTheme),
          ),
        );
      }
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final senha = _senhaController.text;
      final user = await UserDao.getUserByEmail(email);
      if (user == null || user.password != senha) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciais inválidas')),
        );
        return;
      }
      if (_lembrarUsuario) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email_salvo', user.email);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: user, toggleTheme: widget.toggleTheme),
        ),
      );
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(toggleTheme: widget.toggleTheme),
      ),
    );
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordScreen(toggleTheme: widget.toggleTheme),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme, // Alterna o tema
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // CustomCard no topo
            CustomCard(
              title: 'Bem-vindo ao DocuScan!',
              subtitle: 'Faça login para acessar sua conta.',
              icon: Icons.person,
              onTap: () {
                // Sem funcionalidade implementada
              },
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu e-mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _lembrarUsuario,
                            onChanged: (value) {
                              setState(() {
                                _lembrarUsuario = value!;
                              });
                            },
                          ),
                          const Text('Lembrar-me'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Botão "Esqueceu a senha?" usando CustomButton
            CustomButton(
              text: 'Esqueceu a senha?',
              icon: Icons.lock_reset,
              onPressed: _goToForgotPassword,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            // Botão "Cadastre-se" usando CustomButton
            CustomButton(
              text: 'Cadastre-se',
              icon: Icons.person_add,
              onPressed: _goToRegister,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}