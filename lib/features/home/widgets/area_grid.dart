import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/area.dart';

class AreaGrid extends StatelessWidget {
  final List<Area> areas;

  const AreaGrid({
    Key? key,
    required this.areas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.gridCrossAxisCount(context),
          childAspectRatio: Responsive.gridChildAspectRatio(context),
          crossAxisSpacing: Responsive.cardSpacing(context),
          mainAxisSpacing: Responsive.cardSpacing(context),
        ),
        itemCount: areas.length,
        itemBuilder: (context, index) {
          final area = areas[index];
          return AppCard(
            onTap: () {
              if (area.id == 'area_recuperacao') {
                context.go('/recovery');
              } else if (area.id == 'area_cabeca') {
                context.go('/mind');
              } else if (area.id == 'area_dia_jogo') {
                context.go('/matchday');
              } else if (area.id == 'area_sono') {
                context.go('/sleep');
              } else if (area.id == 'area_alimentacao') {
                context.go('/nutrition');
              } else if (area.id == 'area_prevencao') {
                context.go('/library');
              } else if (area.id == 'area_meu_kit') {
                context.go('/premium');
              } else {
                context.go('/shell/area/${area.id}');
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  area.title.split(' ')[0], // Show emoji
                  style: TextStyle(
                    fontSize: Responsive.isSmallPhone(context) ? 28 : 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  area.title.split(' ').skip(1).join(' '),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: Responsive.isSmallPhone(context) ? 13 : 14,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
