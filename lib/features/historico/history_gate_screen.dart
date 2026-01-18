import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/copy_bank.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/utils/auth_guard.dart';
import '../../data/models/history_entry.dart';
import '../../data/models/recovery_region.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/repositories/history_repository.dart';
import '../../data/storage/prefs_store.dart';
import 'widgets/history_entry_form.dart';
import 'widgets/history_insight_card.dart';

class HistoryGateScreen extends StatefulWidget {
  const HistoryGateScreen({Key? key}) : super(key: key);

  @override
  State<HistoryGateScreen> createState() => _HistoryGateScreenState();
}

class _HistoryGateScreenState extends State<HistoryGateScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<RecoveryRegion>> _regionsFuture;

  @override
  void initState() {
    super.initState();
    _regionsFuture = ContentRepository().getRecoveryRegions();
  }

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final isEnabled = prefsStore.isHistoryModeEnabled();

    if (!isEnabled) {
      return Scaffold(
        appBar: buildAppBar(context, 'Histórico', showBack: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Histórico local',
                subtitle:
                    'Registros ficam apenas no aparelho, sem envio automático',
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modo privado local desativado',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Se fizer sentido, o histórico pode ajudar a perceber padrões sem pressão. Nada é obrigatório.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          await prefsStore.setHistoryModeEnabled(true);
                        },
                        child: const Text('Ativar histórico local'),
                      ),
                    ],
                  ),
                ),
              ),
              const DisclaimerFooter(),
            ],
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          'Histórico',
          showBack: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Registros'),
              Tab(text: 'Regiões sensíveis'),
              Tab(text: 'Lesões passadas'),
            ],
          ),
        ),
        body: FutureBuilder<List<RecoveryRegion>>(
          future: _regionsFuture,
          builder: (context, snapshot) {
            final regions = snapshot.data ?? [];
            return TabBarView(
              children: [
                HistoryRecordsScreen(regions: regions, showScaffold: false),
                HistorySensitiveRegionsScreen(
                    regions: regions, showScaffold: false),
                const HistoryPastInjuriesScreen(showScaffold: false),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HistoryRecordsScreen extends StatefulWidget {
  final List<RecoveryRegion> regions;
  final bool showScaffold;
  const HistoryRecordsScreen({
    Key? key,
    this.regions = const [],
    this.showScaffold = true,
  }) : super(key: key);

  @override
  State<HistoryRecordsScreen> createState() => _HistoryRecordsScreenState();
}

class _HistoryRecordsScreenState extends State<HistoryRecordsScreen> {
  final HistoryRepository _repo = const HistoryRepository();

  @override
  Widget build(BuildContext context) {
    final entries = _repo.getAllEntries();
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final content = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Novo registro',
            subtitle: 'Simples e rápido, sem pressão',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppCard(
              child: HistoryEntryForm(
                regions: widget.regions,
                onSubmit: ({
                  required String type,
                  String? regionId,
                  String? sleepQuality,
                  int? intensity,
                  String? notes,
                }) async {
                  if (!ensureAccountAccess(context)) return;
                  await _repo.addEntry(
                    type: type,
                    regionId: regionId,
                    sleepQuality: sleepQuality,
                    intensity: intensity,
                    notes: notes,
                  );
                  setState(() {});
                },
              ),
            ),
          ),
          const SectionHeader(
            title: 'Últimos registros',
            subtitle: 'O que ficou salvo no aparelho',
          ),
          if (entries.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Nenhum registro ainda.'),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    child: _EntryTile(entry: entry, regions: widget.regions),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          const DisclaimerFooter(),
          const SizedBox(height: 24),
        ],
      ),
    );
    if (!widget.showScaffold) return content;
    return Scaffold(
      appBar: buildAppBar(context, 'Registros', showBack: true),
      body: content,
    );
  }
}

class HistorySensitiveRegionsScreen extends StatelessWidget {
  final List<RecoveryRegion> regions;
  final bool showScaffold;
  const HistorySensitiveRegionsScreen({
    Key? key,
    this.regions = const [],
    this.showScaffold = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = const HistoryRepository();
    final repeated = repo.checkRepeatedRegions();
    final entries = repo.getRecentEntries(7);

    final repeatedRegions =
        regions.where((r) => repeated[r.id] == true).toList();

    final content = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Regiões sensíveis',
            subtitle: 'Observações da última semana',
          ),
          if (repeatedRegions.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Nenhuma região com repetição recente.'),
            ),
          if (repeatedRegions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: repeatedRegions.map((region) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            region.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          HistoryInsightCard(
                            message: CopyBank.generateRegionInsightMessage(
                                region.name),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          const SectionHeader(
            title: 'Registros recentes',
            subtitle: 'Últimos 7 dias',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    child: _EntryTile(entry: entry, regions: regions),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          const DisclaimerFooter(),
          const SizedBox(height: 24),
        ],
      ),
    );
    if (!showScaffold) return content;
    return Scaffold(
      appBar: buildAppBar(context, 'Regiões sensíveis', showBack: true),
      body: content,
    );
  }
}

class HistoryPastInjuriesScreen extends StatefulWidget {
  final bool showScaffold;
  const HistoryPastInjuriesScreen({Key? key, this.showScaffold = true})
      : super(key: key);

  @override
  State<HistoryPastInjuriesScreen> createState() =>
      _HistoryPastInjuriesScreenState();
}

class _HistoryPastInjuriesScreenState extends State<HistoryPastInjuriesScreen> {
  final HistoryRepository _repo = const HistoryRepository();
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries =
        _repo.getAllEntries().where((e) => e.type == 'injury').toList();
    final content = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Lesões passadas',
            subtitle: 'Anotações simples para consulta futura',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _noteCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Observação rápida',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_noteCtrl.text.trim().isEmpty) return;
                        if (!ensureAccountAccess(context)) return;
                        await _repo.addEntry(
                          type: 'injury',
                          notes: _noteCtrl.text.trim(),
                        );
                        _noteCtrl.clear();
                        setState(() {});
                      },
                      child: const Text('Salvar observação'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (entries.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Nenhuma anotação ainda.'),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    child: Text(entry.notes ?? 'Sem detalhes'),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          const DisclaimerFooter(),
          const SizedBox(height: 24),
        ],
      ),
    );
    if (!widget.showScaffold) return content;
    return Scaffold(
      appBar: buildAppBar(context, 'Lesões passadas', showBack: true),
      body: content,
    );
  }
}

class _EntryTile extends StatelessWidget {
  final HistoryEntry entry;
  final List<RecoveryRegion> regions;

  const _EntryTile({required this.entry, required this.regions});

  @override
  Widget build(BuildContext context) {
    final regionName = regions
        .firstWhere(
          (r) => r.id == entry.regionId,
          orElse: () => RecoveryRegion(
            id: 'unknown',
            name: 'Região não informada',
            sections: const [],
            redFlags: const [],
          ),
        )
        .name;

    String title;
    if (entry.type == 'sleep') {
      title = 'Sono: ${entry.sleepQuality ?? 'ok'}';
    } else if (entry.type == 'injury') {
      title = 'Lesão passada';
    } else {
      title = 'Dor/Desconforto';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        if (entry.regionId != null)
          Text('Região: $regionName',
              style: Theme.of(context).textTheme.bodySmall),
        if (entry.intensity != null)
          Text('Intensidade: ${entry.intensity}',
              style: Theme.of(context).textTheme.bodySmall),
        if (entry.notes != null && entry.notes!.isNotEmpty)
          Text(entry.notes!, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
