import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/auth/auth_controller.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/utils/responsive.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _signup(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alguns campos ficaram em branco.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro realizado com sucesso.')),
    );
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    context.go('/login');
  }

  Future<void> _signupSocial(BuildContext context) async {
    final auth = context.read<AuthController>();
    await auth.loginUser();
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
      appBar: buildAppBar(
        context,
        'Cadastro',
        showBack: true,
        onBack: () => context.go('/login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontal,
            vertical,
            horizontal,
            vertical + bottomInset,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppCard(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome não informado.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email não informado.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Senha não informada.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar senha',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Confirmação não informada.';
                          }
                          if (value != _passCtrl.text) {
                            return 'As senhas não parecem iguais.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _signup(context),
                          child: const Text('Criar conta'),
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
                  onTap: () => _signupSocial(context),
                ),
                const SizedBox(height: 8),
                _socialButton(
                  context,
                  icon: FontAwesomeIcons.apple,
                  label: 'Continuar com Apple',
                  onTap: () => _signupSocial(context),
                ),
                const SizedBox(height: 8),
                _socialButton(
                  context,
                  icon: FontAwesomeIcons.facebook,
                  label: 'Continuar com Facebook',
                  onTap: () => _signupSocial(context),
                ),
                const SizedBox(height: 16),
                const DisclaimerFooter(),
              ],
            ),
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
