import 'package:flutter/material.dart';
import '../../../data/models/recovery_region.dart';

class HistoryEntryForm extends StatefulWidget {
  final List<RecoveryRegion> regions;
  final Future<void> Function({
    required String type,
    String? regionId,
    String? sleepQuality,
    int? intensity,
    String? notes,
  }) onSubmit;

  const HistoryEntryForm({
    Key? key,
    required this.regions,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<HistoryEntryForm> createState() => _HistoryEntryFormState();
}

class _HistoryEntryFormState extends State<HistoryEntryForm> {
  String _type = 'pain';
  String? _regionId;
  int _intensity = 3;
  String _sleepQuality = 'ok';
  final TextEditingController _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: _type,
          decoration: const InputDecoration(labelText: 'Tipo de registro'),
          items: const [
            DropdownMenuItem(value: 'pain', child: Text('Dor/Desconforto')),
            DropdownMenuItem(value: 'sleep', child: Text('Sono')),
            DropdownMenuItem(value: 'note', child: Text('Observação')),
          ],
          onChanged: (value) => setState(() => _type = value ?? 'pain'),
        ),
        const SizedBox(height: 12),
        if (_type == 'pain')
          DropdownButtonFormField<String>(
            value: _regionId,
            decoration: const InputDecoration(labelText: 'Região'),
            items: widget.regions
                .map((r) => DropdownMenuItem(value: r.id, child: Text(r.name)))
                .toList(),
            onChanged: (value) => setState(() => _regionId = value),
          ),
        if (_type == 'pain')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text('Intensidade (1–5): $_intensity'),
              Slider(
                value: _intensity.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (value) =>
                    setState(() => _intensity = value.toInt()),
              ),
            ],
          ),
        if (_type == 'sleep')
          DropdownButtonFormField<String>(
            value: _sleepQuality,
            decoration: const InputDecoration(labelText: 'Qualidade do sono'),
            items: const [
              DropdownMenuItem(value: 'mal', child: Text('Dormi mal')),
              DropdownMenuItem(value: 'ok', child: Text('Dormi ok')),
              DropdownMenuItem(value: 'bem', child: Text('Dormi bem')),
            ],
            onChanged: (value) => setState(() => _sleepQuality = value ?? 'ok'),
          ),
        const SizedBox(height: 12),
        TextField(
          controller: _notesCtrl,
          decoration: const InputDecoration(
            labelText: 'Observação (opcional)',
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await widget.onSubmit(
                type: _type,
                regionId: _type == 'pain' ? _regionId : null,
                sleepQuality: _type == 'sleep' ? _sleepQuality : null,
                intensity: _type == 'pain' ? _intensity : null,
                notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
              );
              if (!mounted) return;
              _notesCtrl.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registro salvo localmente.')),
              );
            },
            child: const Text('Salvar registro'),
          ),
        ),
      ],
    );
  }
}
