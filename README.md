# Futly Prime - Flutter App

Uma aplicação mobile completa para futebolistas, desenvolvida em Flutter com arquitetura limpa, gerenciamento de estado com Provider e dados locais usando Hive e SharedPreferences.

## 📱 Características

- **Áreas de Apoio** (entrada opcional):
  - 💪 Corpo
  - 🩹 Recuperação
  - 🧠 Cabeça
  - ⚽ Dia de Jogo
  - 🌙 Sono
  - 🍽️ Alimentação
  - 📖 Prevenção de Lesões
  - 🧾 Meu Histórico (opcional)

- **Linguagem Segura**: Sem imperativos (faça, você deve, precisa). Sempre não prescritiva
  - "pode ajudar"
  - "alguns atletas fazem"
  - "em geral"
  - "tende a"

- **Privacidade First**:
  - Sem coleta automática (GPS, wearables, câmera, microfone)
  - Sem diagnósticos, sem prescrições
  - Histórico 100% local no dispositivo
  - Nunca compartilhado

- **Tema Profissional**:
  - Preto/Branco minimalista
  - Suporte Light/Dark mode
  - Material 3
  - Micro-interações

- **Dados Locais**: Sem backend real, dados mock determinísticos
  - 9 regiões de recuperação com orientações
  - 9 lesões comuns documentadas
  - 10+ cards educacionais
  - 6+ rotinas estruturadas
  - 6 tópicos de saúde mental
  - 7 posições (Premium)

## 🏗️ Arquitetura

```
lib/
├── main.dart                    # Ponto de entrada
├── app.dart                     # App shell com Provider
├── core/
│   ├── routing/                 # go_router config
│   ├── theme/                   # Material 3 themes
│   ├── widgets/                 # Widgets reutilizáveis
│   └── utils/                   # Helpers (CopyBank, etc)
├── data/
│   ├── models/                  # Classes com Hive
│   ├── storage/                 # PrefsStore, HiveStore
│   ├── repositories/            # ContentRepository, HistoryRepository
│   └── mock/                    # Mock data loader (futura)
└── features/
    ├── onboarding/
    ├── home/
    ├── areas/
    │   ├── recuperacao/
    │   ├── cabeca/
    │   ├── dia_de_jogo/
    │   ├── sono/
    │   └── alimentacao/
    ├── biblioteca/
    ├── rotinas/
    ├── historico/
    ├── premium/
    ├── sobre/
    └── settings/
```

### Tech Stack

- **Framework**: Flutter 3.0+, Dart 3.0+
- **State Management**: Provider 6.1.0
- **Navigation**: go_router 13.0.0
- **Local Storage**:
  - `shared_preferences`: Configurações (tema, onboarding, favorites)
  - `hive_flutter`: Histórico de entradas (tipo-seguro)
- **Outras**:
  - `intl`: Internacionalização (preparado)
  - `flutter_animate`: Micro-animações
  - `uuid`: IDs únicos

## ⚡ Começando

### Pré-requisitos

- Flutter 3.0.0+
- Dart 3.0.0+
- Xcode (iOS) / Android Studio (Android)

### Instalação

1. Clone o repositório:
```bash
git clone <seu-repo>
cd futly_prime
```

2. Instale dependências:
```bash
flutter pub get
```

3. Execute (desenvolvimento):
```bash
flutter run
```

### Build para Produção

**Android**:
```bash
flutter build apk --release
```

**iOS**:
```bash
flutter build ios --release
```

## 📂 Estrutura de Dados (JSON Assets)

### Assets Inclusos
- `assets/content/areas.json` - 8 áreas principais
- `assets/content/recovery_regions.json` - 9 regiões com orientações
- `assets/content/injuries.json` - 9 lesões documentadas
- `assets/content/education.json` - 10+ cards educacionais
- `assets/content/routines.json` - 6+ rotinas estruturadas
- `assets/content/mental_topics.json` - 6 tópicos de saúde mental
- `assets/content/positions.json` - 7 posições de futebol (Premium)

Todos os dados são mockados, determinísticos e carregados localmente via `ContentRepository`.

## 🎯 Funcionalidades Chave

### 1. Onboarding
- Logo + tagline: "Apoio opcional para o seu dia a dia"
- Card com disclaimer legal
- Toggle: "Quero usar modo privado local" (salva histórico localmente)
- Armazena flag `seenOnboarding` em SharedPreferences

### 2. Recuperação
- 9 regiões (joelho, posterior, tornozelo, lombar, panturrilha, virilha, quadril, costas, pé)
- Template por região:
  - O que costuma sobrecarregar
  - O que alguns atletas fazem para aliviar
  - Alongamentos simples (checklist)
  - Quando descansar
  - O que evitar forçar
  - **Sinais de alerta** (sempre visível)
- Botão "Salvar nos favoritos" (funciona)
- Botão "Registrar no histórico (opcional)" (habilitado se modo privado ativo)
- **Safe exit line**: "Se piorar, persistir, ou tiver sinal de alerta, vale buscar avaliação profissional"

### 3. Biblioteca
- **Tabs**:
  - "Lesões comuns" (9 lesões com search)
  - "Educação do atleta" (10+ mini-cards)
- **Lesões**: O que é → Por que acontece → Sinais de alerta → Cuidados → Prevenção → Retorno progressivo
- **Educação**: Títulos como "Por que gelo pode ajudar?" (safeLanguage)

### 4. Cabeça (Saúde Mental)
- 6 tópicos:
  - "Estou me sentindo pressionado"
  - "Estou sendo muito cobrado"
  - "Estou muito exaltado"
  - "Errei no último jogo"
  - "Tenho medo de errar"
  - "Quero focar"
- **Per tópico**:
  - Intro (texto humanizado, sem coaching falso)
  - 4–6 lembretes práticos (linguagem não prescritiva)
  - **Ferramenta rápida** (30–60 segundos):
    - Breathing guide (timer UI)
    - Reset mental (3 passos)

### 5. Dia de Jogo
- 3 cards: "Antes do jogo", "Intervalo", "Depois do jogo"
- **Per fase**:
  - Mental, Hidratação, Alimentação, Recuperação
  - Cada com bullets: "Alguns jogadores costumam..."

### 6. Sono
- Blocos: "Por que ajuda", "Rotina pré-sono (ideias simples)", "O que evitar antes de jogo"
- Check-in opcional: "Como foi?" → "Dormi mal" / "ok" / "bem"
- Sem push notifications

### 7. Alimentação
- **Tabs**: "Antes do jogo", "Depois do jogo", "Dia sem jogo"
- Exemplos, o que evitar, o que pode ajudar
- Sem calorias, sem macros, sem dietas

### 8. Rotinas
- 7 rotinas:
  - "Pós-jogo pesado"
  - "Semana cheia"
  - "Semana leve"
  - "Volta de lesão (conceitual)"
  - "Dia de treino intenso"
  - "Dia de treino leve"
  - "Dia de viagem"
- **Per rotina**: 5–9 passos, cada um é card com content
- Botão "Concluir" e "Salvar como favorita"

### 9. Histórico (100% Opcional)
- **Se desativado**:
  - Explica modo privado
  - Botão "Ativar modo privado local"
- **Se ativado**:
  - **Tabs**:
    - "Registros" (Dor, Sono, Observação)
    - "Regiões sensíveis" (seleção do usuário)
    - "Lesões passadas" (manual)
  - **Gentle insight**: Se região registrada 3+ vezes em 7 dias → soft message:
    - "Talvez valha dar um pouco mais de atenção a essa região — se fizer sentido."
  - Nada enviado; tudo local

### 10. Premium (Mocked)
- **Free vs Premium**:
  - Free: 6 itens em Kit, body map estático (2 hotspots)
  - Premium: 12 itens em Kit, body map completo, posições completas
- **Mapa do Corpo**:
  - Silhueta front/back simples
  - Hotspots interativos (abre detalhe de região)
  - Free: preview estático + CTA para Premium
  - Premium: todo funcional + salvar regiões sensíveis
- **Posições** (7):
  - Goleiro, Zagueiro, Lateral, Volante, Meia, Ponta, Centroavante
  - Cada: regiões focadas, cards, rotinas
  - Free: preview; Premium: completo
- **Monetização Mock**:
  - Tela "Futly Prime Premium"
  - Copy: "O grátis pode ajudar hoje. O premium tende a proteger o futuro — se fizer sentido pra você."
  - "R$ 9,90–19,90/mês" (display only)
  - Toggle Debug em Settings para simular Premium

### 11. Sobre
- Disclaimer legal
- Privacidade (sem auto-collection)
- "Como usar" (explicar natureza opcional)
- FAQ (5–8 Q&As, linguagem segura)

### 12. Settings (Acessível via About ou ícone)
- **Theme**: System / Light / Dark
- **Premium Toggle** (debug/demo)
- **History Mode Toggle**
- **Clear History** (com confirmação)

## 📊 Modelos de Dados

### Area
```dart
Area {
  id: String,
  title: String,
  iconKey: String,
  intro: String,
  route: String,
}
```

### RecoveryRegion
```dart
RecoveryRegion {
  id: String,
  name: String,
  sections: List<RecoverySection>,
  redFlags: List<String>,
}
```

### Injury
```dart
Injury {
  id, name, whatIs, whyHappens, redFlags[], 
  commonCare, prevention, progressiveReturn
}
```

### Routine
```dart
Routine {
  id, title, description,
  steps: List<RoutineStep>
}
```

### MentalTopic
```dart
MentalTopic {
  id, title, intro, reminders: List<String>,
  tool: MentalTool? { type, durationSeconds, scriptSteps }
}
```

### HistoryEntry
```dart
HistoryEntry {
  id, type (dor/sono/observacao), createdAt,
  regionId?, sleepQuality?, intensity?, notes?
}
```

## 🔐 Segurança e Privacidade

1. **Sem coleta automática**:
   - ✅ GPS: Desabilitado
   - ✅ Wearables: Não integrado
   - ✅ Câmera: Não usado
   - ✅ Microfone: Não usado

2. **Armazenamento**:
   - SharedPreferences: Configurações, favoritos, status
   - Hive: Histórico local, tipo-seguro
   - **Nada enviado para servidor**

3. **Disclaimers**:
   - Onboarding: Legal/Ética obrigatória
   - Contextos de dor: Safe exit line sempre visível
   - Sobre: Privacy + Legal

## ✅ Compliance Checklist

- ✅ Sem imperativos (faça, você deve, precisa, tem que)
- ✅ Linguagem não prescritiva (pode, alguns fazem, em geral, tende a)
- ✅ Safe exit line em contextos de dor/lesão
- ✅ Disclaimer legal e privacidade persistentemente acessíveis
- ✅ Modo privado (histórico) 100% opcional
- ✅ Nenhum envio automático de dados
- ✅ Sem diagnósticos, sem prescrições
- ✅ Portuguese UI em todo lugar
- ✅ Mockado, determinístico, sem backend real

## 📝 Licença

MIT

## 🤝 Contribuições

Contato: [seu-email@exemplo.com]

---

**Futly Prime**: Apoio opcional para atletas de futebol. Não substitui treinador, fisioterapeuta ou nutricionista.
