import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/disclaimer_footer.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          'Alimentação',
          showBack: true,
          onBack: () => context.go('/shell'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Antes do jogo'),
              Tab(text: 'Depois do jogo'),
              Tab(text: 'Dia sem jogo'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _NutritionTab(
              title: 'Antes do jogo',
              highlights: [
                'Alguns atletas preferem refeições leves e com boa digestão.',
                'Muita gente relata que comer cedo evita desconforto durante o jogo.',
              ],
              avoids: [
                'Alguns evitam excesso de gordura ou fritura muito perto do jogo.',
                'Bebidas muito açucaradas podem pesar para algumas pessoas.',
              ],
              recovery: [
                'Água em pequenos goles tende a ajudar mais do que grandes volumes de uma vez.',
                'Lanches simples podem ajudar a manter energia sem sobrecarregar.',
              ],
            ),
            _NutritionTab(
              title: 'Depois do jogo',
              highlights: [
                'Alguns atletas costumam buscar algo com carboidrato simples e proteína leve.',
                'Repor líquidos com calma costuma ajudar na recuperação.',
              ],
              avoids: [
                'Alguns evitam refeições enormes imediatamente após o jogo.',
                'Excesso de álcool tende a piorar o descanso.',
              ],
              recovery: [
                'Uma refeição equilibrada mais tarde pode ser melhor que pressa.',
                'Se fizer sentido, algo quente e simples ajuda a desacelerar.',
              ],
            ),
            _NutritionTab(
              title: 'Dia sem jogo',
              highlights: [
                'Alguns atletas preferem manter rotina alimentar estável.',
                'Muita gente relata mais energia quando evita picos de fome.',
              ],
              avoids: [
                'Excesso de ultraprocessados pode deixar o corpo mais pesado.',
                'Pular refeições tende a aumentar vontade de exagerar depois.',
              ],
              recovery: [
                'Pratos simples, com variedade, costumam ajudar no dia a dia.',
                'Hidratação regular ao longo do dia tende a apoiar performance.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NutritionTab extends StatelessWidget {
  final String title;
  final List<String> highlights;
  final List<String> avoids;
  final List<String> recovery;

  const _NutritionTab({
    required this.title,
    required this.highlights,
    required this.avoids,
    required this.recovery,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: title,
            subtitle: 'Ideias simples, sem plano rígido',
          ),
          _listCard(context, 'O que costuma ajudar', highlights),
          _listCard(context, 'O que alguns evitam', avoids),
          _listCard(context, 'Apoio à recuperação', recovery),
          const SizedBox(height: 16),
          const DisclaimerFooter(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _listCard(BuildContext context, String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('• $item'),
                )),
          ],
        ),
      ),
    );
  }
}
