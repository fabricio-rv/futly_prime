import 'dart:async';
import 'package:flutter/material.dart';

class BreathingTool extends StatefulWidget {
  final int durationSeconds;
  final List<String> steps;

  const BreathingTool({
    Key? key,
    required this.durationSeconds,
    required this.steps,
  }) : super(key: key);

  @override
  State<BreathingTool> createState() => _BreathingToolState();
}

class _BreathingToolState extends State<BreathingTool> {
  Timer? _timer;
  int _remaining = 0;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.durationSeconds;
  }

  void _start() {
    if (_running) return;
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining <= 1) {
        timer.cancel();
        setState(() {
          _remaining = 0;
          _running = false;
        });
        return;
      }
      setState(() => _remaining--);
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _remaining = widget.durationSeconds;
      _running = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tempo: ${_remaining}s',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            ElevatedButton(
              onPressed: _running ? null : _start,
              child: const Text('Iniciar'),
            ),
            OutlinedButton(
              onPressed: _reset,
              child: const Text('Reiniciar'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...widget.steps.map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text('• $step'),
          ),
        ),
      ],
    );
  }
}
