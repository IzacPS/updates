# 🫧 Updates

**Updates** é um pacote Flutter que implementa um componente visual no estilo das *bubbles* do Instagram, ideal para mostrar atualizações rápidas como stories, status ou posts em destaque.

![Demonstração do Updates](images/output.gif)

## ✨ Recursos

- Bubbles com avatar, nome e indicador de status.
- Comportamento visual com `background` (imagem) e `foreground` (nome ou overlay).
- Suporte à paginação com `infinite_scroll_pagination`.
- Visualização de múltiplos updates ao clicar em uma bubble.

## 📦 Instalação

Como o pacote ainda não está publicado no `pub.dev`, adicione diretamente do GitHub:

```yaml
dependencies:
  updates:
    git:
      url: https://github.com/IzacPS/updates.git
```

Em seguida, execute: 
```bash
    flutter pub get
```

## 🚀 Exemplo de Uso

```dart
import 'package:flutter/material.dart';
import 'package:updates/updates.dart';

class Data {
  const Data({required this.url, required this.name, required this.content});

  final String url;
  final String name;
  final List<String> content;
}

final data = [
  Data(
    url: "assets/profile/undraw_Female_avatar_efig.png",
    name: "maria",
    content: [
      "assets/posts/benjamin-davies-__U6tHlaapI-unsplash.jpg",
      "assets/posts/brent-cox-lRM-J3q2Z3k-unsplash.jpg",
    ],
  ),
  // Outros usuários...
];

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Updates Demo',
      theme: ThemeData(useMaterial3: true),
      home: const TestUpdates(),
    );
  }
}

class TestUpdates extends StatefulWidget {
  const TestUpdates({super.key});

  @override
  State<TestUpdates> createState() => _TestUpdatesState();
}

class _TestUpdatesState extends State<TestUpdates> {
  late final UpdatesController<Data> _controller;

  @override
  void initState() {
    super.initState();
    _controller = UpdatesController(firstPageKey: 0);
    _controller.addPageRequestListener((key) {
      _controller.appendLastPage(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Updates<Data, (String, String)>(
            controller: _controller,
            statusColorBuilder: (context, item) => Colors.orange,
            avatarBuilder: (context, item) => Image.asset(item?.url ?? ""),
            descriptionBuilder: (context, item) => Text(item?.name ?? ""),
            backgroundBuilder: (context, item) => Container(
              color: Colors.grey[200],
              child: Image.asset(item?.$2 ?? ""),
            ),
            foregroundBuilder: (context, item) => Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item?.$1 ?? "",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            generateContentData: (item) =>
              item?.content.map((e) => (item.name, e)).toList() ?? [],
          ),
        ),
      ),
    );
  }
}
```

## 📌 Em Desenvolvimento
- Timer para autoplay dos updates (estilo stories).

- Melhorias na estratégia de carregamento de dados, além do infinite_scroll_pagination.


## 📄 Licença
Este projeto está licenciado sob os termos da Licença MIT.