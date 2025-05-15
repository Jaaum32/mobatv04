import 'package:flutter/material.dart';
import 'package:mobatv04/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const ForgotPasswordScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme, // Alterna o tema
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recuperar Senha',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Digite seu e-mail para receber um link de recuperação de senha.',
              style: Theme.of(context).textTheme.bodyMedium,
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
            CustomButton(
              text: 'Enviar Instruções',
              icon: Icons.send,
              onPressed: () {
                // Lógica para enviar instruções de recuperação
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Instruções enviadas para o e-mail!')),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}