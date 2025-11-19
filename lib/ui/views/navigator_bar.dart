import 'package:flutter/material.dart';
import 'package:web_kut/ui/views/home_view.dart';
import 'package:web_kut/ui/views/perfil_view.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _index = 0;

  late final List<Widget> _opcoes = <Widget>[HomeView(), PerfilView()];

  void _trocarOpcao(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _opcoes.elementAt(_index),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(3),

        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors
                .transparent, // esses 2 serve para tirar aquele efeito de clicar da navegacao bar
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: _index,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            onTap: _trocarOpcao,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(size: 25),
            unselectedIconTheme: IconThemeData(size: 20),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
