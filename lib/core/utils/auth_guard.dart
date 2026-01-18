import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_controller.dart';

bool ensureAccountAccess(BuildContext context) {
  final auth = context.read<AuthController>();
  if (!auth.isUser) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Esse recurso tende a ficar disponível ao entrar com uma conta — se fizer sentido pra você.'),
      ),
    );
    return false;
  }
  return true;
}
