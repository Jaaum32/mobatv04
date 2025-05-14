import 'package:flutter/material.dart';
import 'onboarding_page_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      image: 'assets/images/step1.png',
      title: 'Digitalize com Facilidade',
      description: 'Capture documentos com a câmera e organize tudo em um só lugar.',
    ),
    OnboardingPageModel(
      image: 'assets/images/step2.png',
      title: 'Organize em Categorias',
      description: 'Classifique seus arquivos por tipo e tenha tudo à mão.',
    ),
    OnboardingPageModel(
      image: 'assets/images/step3.png',
      title: 'Segurança em Primeiro Lugar',
      description: 'Proteja seus dados com criptografia e acesso por biometria.',
    ),
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(page.image, height: 250),
                const SizedBox(height: 32),
                Text(page.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                Text(
                  page.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(
                _pages.length,
                    (index) => _buildIndicator(index == _currentIndex),
              ),
            ),
            ElevatedButton(
              onPressed: _nextPage,
              child: Text(_currentIndex == _pages.length - 1 ? 'Começar' : 'Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}
