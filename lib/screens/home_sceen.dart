import 'package:flutter/material.dart';
import 'package:mobatv04/widgets/custom_card.dart';
import 'package:mobatv04/widgets/custom_button.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  final VoidCallback toggleTheme; // Função para alternar o tema

  const HomeScreen({super.key, required this.user, required this.toggleTheme});

  void _logout(BuildContext context) async {
    // Limpa o e-mail salvo nas preferências
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email_salvo');
    // Redireciona para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(toggleTheme: toggleTheme), // Passa o toggleTheme
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocuScan'),
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
            // Saudação ao usuário com ícone
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 40, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bem-vindo, ${user.email}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis, // Trunca o texto se for muito longo
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Cards de funcionalidades
            CustomCard(
              title: 'Digitalizar Documentos',
              subtitle: 'Use a câmera para capturar documentos.',
              icon: Icons.camera_alt,
              onTap: () {
                // Sem funcionalidade implementada
              },
            ),
            const SizedBox(height: 16),
            CustomCard(
              title: 'Organizar Arquivos',
              subtitle: 'Classifique e organize seus documentos.',
              icon: Icons.folder,
              onTap: () {
                // Sem funcionalidade implementada
              },
            ),
            const SizedBox(height: 16),
            CustomCard(
              title: 'Configurações',
              subtitle: 'Ajuste preferências do aplicativo.',
              icon: Icons.settings,
              onTap: () {
                // Sem funcionalidade implementada
              },
            ),
            const SizedBox(height: 32),
            // Botões de ação
            CustomButton(
              text: 'Explorar Funcionalidades',
              icon: Icons.explore,
              onPressed: () {
                // Sem funcionalidade implementada
              },
            ),
            const SizedBox(height: 16),
            // Botão de logout usando CustomButton
            CustomButton(
              text: 'Sair',
              icon: Icons.logout,
              color: Colors.red,
              onPressed: () => _logout(context), // Chama a função de logout
            ),
          ],
        ),
      ),
    );
  }
}