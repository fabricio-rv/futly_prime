/// Safe language constants and helper functions
class CopyBank {
  static const String disclaimerText =
      'Este app não substitui treinador, fisioterapeuta ou nutricionista. É apenas um apoio opcional para o atleta se cuidar melhor no dia a dia.';

  static const String safetyExitText =
      'Se piorar, persistir, ou tiver sinal de alerta, vale buscar avaliação profissional.';

  static const String privacyText =
      'Sem coleta automática: sem GPS, sem wearables, sem câmera, sem microfone. Sem diagnósticos, sem prescrições. Sem dados sensíveis. Histórico é 100% opcional, armazenado localmente no dispositivo, nunca compartilhado.';

  static const String premiumPitchText =
      'O grátis pode ajudar hoje. O premium tende a proteger o futuro — se fizer sentido pra você.';

  static const String onboardingTagline =
      'Apoio opcional para o seu dia a dia.';

  static const String onboardingSubtitle = 'Sem promessas, sem cobrança.';

  static const String homeSubtitle =
      'Entre quando quiser. Nada aqui é obrigatório.';

  static const String historyModeToggleLabel =
      'Quero usar modo privado local (salvar histórico no aparelho)';

  static const String historyOptionalLabel =
      'Registrar no histórico (opcional)';

  // Gentle insight message for repeated pain entries
  static String generateRegionInsightMessage(String regionName) {
    return 'Talvez valha dar um pouco mais de atenção a essa região — se fizer sentido.';
  }

  // Check if text contains forbidden imperatives
  static bool containsForbiddenImperatives(String text) {
    final forbidden = [
      'faça ',
      'você deve ',
      'precisa ',
      'tem que ',
      'deve fazer',
      'obrigatório',
    ];
    final lower = text.toLowerCase();
    return forbidden.any((word) => lower.contains(word));
  }

  // Suggested safe language alternatives
  static const Map<String, String> safeLanguageAlternatives = {
    'faça': 'pode fazer',
    'você deve': 'alguns fazem',
    'precisa': 'pode ajudar',
    'tem que': 'em geral',
    'deve fazer': 'tende a',
  };
}
