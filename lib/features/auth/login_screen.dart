import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/auth/auth_controller.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _loginUser(BuildContext context) async {
    final auth = context.read<AuthController>();
    await auth.loginUser();
    if (!mounted) return;
    context.go('/shell');
  }

  Future<void> _loginGuest(BuildContext context) async {
    final auth = context.read<AuthController>();
    await auth.loginGuest();
    if (!mounted) return;
    context.go('/shell');
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.horizontalPadding(context);
    final vertical = Responsive.sectionSpacing(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context, 'Entrar', showBack: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontal,
            vertical,
            horizontal,
            vertical + bottomInset,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                'Futly Prime',
                style: Responsive.scaleTextStyle(
                  context,
                  Theme.of(context).textTheme.displayMedium,
                  smallScale: 0.92,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Apoio opcional para o seu dia a dia.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AppCard(
                child: Column(
                  children: [
                    TextField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _loginUser(context),
                        child: const Text('Entrar'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.go('/esqueci-senha'),
                      child: const Text('Esqueci minha senha'),
                    ),
                    TextButton(
                      onPressed: () => context.go('/cadastro'),
                      child: const Text('Criar conta'),
                    ),
                    const Divider(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _loginGuest(context),
                        child: const Text('Entrar como visitante'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _socialButton(
                context,
                icon: FontAwesomeIcons.google,
                label: 'Continuar com Google',
                onTap: () => _loginUser(context),
              ),
              const SizedBox(height: 8),
              _socialButton(
                context,
                icon: FontAwesomeIcons.apple,
                label: 'Continuar com Apple',
                onTap: () => _loginUser(context),
              ),
              const SizedBox(height: 8),
              _socialButton(
                context,
                icon: FontAwesomeIcons.facebook,
                label: 'Continuar com Facebook',
                onTap: () => _loginUser(context),
              ),
              const SizedBox(height: 16),
              const DisclaimerFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: FaIcon(icon, size: 18),
        label: Text(label),
        onPressed: onTap,
      ),
    );
  }
}
