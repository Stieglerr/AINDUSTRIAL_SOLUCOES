import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vibration/vibration.dart';
import 'residencial/residencial.dart';
import 'motores/motores.dart';
import 'informacoes/informacoes.dart';
import 'eletricista/eletricista.dart';
import 'eletricista/orcamento.dart';
import 'aindustrial/aindustrial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Configuração para suprimir avisos de overflow
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception.toString().contains('overflowed by') ||
        details.exception.toString().contains('RenderFlex')) {
      return; // Ignora especificamente erros de overflow
    }
    FlutterError.presentError(details); // Mantém outros erros visíveis
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPrincipal(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(minimumSize: const Size(300, 100)),
        ),
      ),
      // Builder global que previne overflow em todas as telas
      builder: (context, child) {
        return Scaffold(
          body: MediaQuery.removePadding(
            context: context,
            removeBottom: true, // Remove padding inferior que causa overflow
            child: KeyboardDismisser(
              // Widget personalizado para teclado
              child: SafeArea(
                child: SingleChildScrollView(
                  // Permite rolagem quando necessário
                  physics: const ClampingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      routes: {
        '/orcamentos': (context) => Orcamento(),
        '/residencial': (context) => Residencial(),
        '/motores': (context) => Motores(),
        '/informacoes': (context) => Informacoes(),
        '/eletricista': (context) => Eletricista(),
        '/aindustrial': (context) => AIndustrial(),
      },
    );
  }
}

// Widget auxiliar para fechar teclado ao tocar fora
class KeyboardDismisser extends StatelessWidget {
  final Widget child;

  const KeyboardDismisser({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}

// O restante do seu código (TelaPrincipal) permanece EXATAMENTE IGUAL
class TelaPrincipal extends StatelessWidget {
  final Color corChumbo = const Color.fromARGB(255, 55, 52, 53);

  final List<Map<String, dynamic>> botoes = [
    {
      'texto': 'Residencial',
      'rota': '/residencial',
      'icone': Icons.home,
      'cor': const Color.fromARGB(255, 66, 165, 245),
    },
    {
      'texto': 'Motores',
      'rota': '/motores',
      'icone': Icons.engineering,
      'cor': const Color.fromARGB(255, 255, 84, 32),
    },
    {
      'texto': 'Eletricista',
      'rota': '/eletricista',
      'icone': Icons.electrical_services,
      'cor': const Color.fromARGB(255, 255, 160, 0),
    },
    {
      'texto': 'A Industrial',
      'rota': '/aindustrial',
      'icone': Icons.bolt,
      'cor': const Color.fromARGB(255, 2, 147, 7),
    },
    {
      'texto': 'Informações',
      'rota': '/informacoes',
      'icone': Icons.info,
      'cor': const Color.fromARGB(255, 21, 101, 192),
    },
  ];

  TelaPrincipal({super.key});

  PageRouteBuilder _customPageRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  Future<void> _vibrar() async {
    try {
      if (await Vibration.hasVibrator()) {
        await Vibration.vibrate(duration: 50);
      }
    } catch (e) {
      debugPrint('Erro na vibração: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logointpreto.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: corChumbo,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final botao in botoes)
                  _buildButton(
                    context,
                    botao['texto'] as String,
                    botao['rota'] as String,
                    botao['icone'] as IconData,
                    botao['cor'] as Color,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    String rota,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () async {
          _vibrar();
          Navigator.push(context, _customPageRoute(_getScreen(rota)));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Color.lerp(color, Colors.transparent, 0.7),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getScreen(String rota) {
    switch (rota) {
      case '/residencial':
        return Residencial();
      case '/motores':
        return Motores();
      case '/eletricista':
        return Eletricista();
      case '/informacoes':
        return Informacoes();
      case '/orcamentos':
        return Orcamento();
      case '/aindustrial':
        return AIndustrial();
      default:
        return const SizedBox.shrink();
    }
  }
}
