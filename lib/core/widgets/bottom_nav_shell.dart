import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../auth/auth_controller.dart';
import '../routing/routes.dart';

class BottomNavShell extends StatefulWidget {
  final Widget child;

  const BottomNavShell({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // If "Sair" (index 4) is tapped, show logout confirmation
    if (index == 4) {
      _showLogoutConfirmation();
      return;
    }

    setState(() => _selectedIndex = index);

    final routes = [
      Routes.shell,
      Routes.routines,
      Routes.history,
      Routes.about,
    ];

    context.go(routes[index]);
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Sair da conta'),
          content: const Text('Tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                final authController = context.read<AuthController>();
                await authController.logout();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            activeIcon: Icon(Icons.list),
            label: 'Rotinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outlined),
            activeIcon: Icon(Icons.info),
            label: 'Sobre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            activeIcon: Icon(Icons.logout),
            label: 'Sair',
          ),
        ],
      ),
    );
  }
}
