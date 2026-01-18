import 'package:flutter/material.dart';
import '../../core/utils/copy_bank.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context, 'Sobre', showBack: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Futly Prime',
                subtitle: 'Apoio opcional para atletas de futebol',
              ),
              _infoCard(context, CopyBank.disclaimerText),
              const SectionHeader(
                title: 'Como usar',
                subtitle: 'Dicas simples para navegar pelo app',
              ),
              _infoCard(
                context,
                'Entre nas áreas, leia os cards e salve o que fizer sentido no Meu Kit. Nada é obrigatório.',
              ),
              const SectionHeader(
                title: 'Privacidade e dados',
                subtitle: 'Princípios de cuidado com suas informações',
              ),
              _infoCard(context, CopyBank.privacyText),
              const SectionHeader(
                title: 'Perguntas frequentes',
                subtitle: 'Respostas rápidas',
              ),
              _faq(context, 'Isso substitui um profissional?',
                  'Não. É apenas um apoio opcional. Avaliação profissional pode ajudar em situações específicas.'),
              _faq(context, 'O app coleta meus dados automaticamente?',
                  'Não há coleta automática. Registros são opcionais e ficam no aparelho.'),
              _faq(context, 'Posso usar mesmo sem histórico?',
                  'Sim. O histórico é opcional e não é necessário para usar o app.'),
              _faq(context, 'O que é o Meu Kit?',
                  'Um espaço para salvar conteúdos favoritos e acessá-los rápido.'),
              _faq(context, 'Existe alguma promessa de resultado?',
                  'Não. O conteúdo é educativo e pode ajudar, mas não garante resultados.'),
              const SizedBox(height: 16),
              const DisclaimerFooter(includePrivacy: true),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );

  Widget _infoCard(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppCard(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ),
    );
  }

  Widget _faq(BuildContext context, String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(answer, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
