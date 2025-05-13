import 'package:flutter/material.dart';
import '../database/user_dao.dart';
import '../models/user_model.dart';
import 'home_sceen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  void _registrar() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final senha = _senhaController.text;

      // Verifica se o e-mail já existe
      final existingUser = await UserDao.getUserByEmail(email);
      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail já cadastrado')),
        );
        return;
      }

      // Cria novo usuário
      final novoUsuario = UserModel(email: email, password: senha);
      await UserDao.insertUser(novoUsuario);

      // Busca o usuário recém-criado
      final usuarioCriado = await UserDao.getUserByEmail(email);

      // Navega para a HomeScreen
      if (usuarioCriado != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: usuarioCriado)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu e-mail';
                  }
                  if (!value.contains('@')) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
                validator: (value) {
                  if (value != _senhaController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrar,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
