import 'package:flutter/material.dart';
import 'package:mobatv04/widgets/custom_button.dart';
import '../database/user_dao.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const RegisterScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    void _registrar() async {
      final email = _emailController.text;
      final senha = _passwordController.text;

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

      // Navega para a tela de login
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastre-se'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme, // Alterna o tema
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Criar Conta',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Registrar',
              icon: Icons.check,
              onPressed: _registrar,
            ),
            const SizedBox(height: 16),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
