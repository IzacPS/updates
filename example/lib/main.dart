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
      ]),
  Data(
      url: "assets/profile/undraw_Male_avatar_g98d.png",
      name: "peter",
      content: [
        "assets/posts/caleb-jones-3igHRe7QTdg-unsplash.jpg",
        "assets/posts/guille-pozzi-SHcHVFhz7-M-unsplash.jpg",
        "assets/posts/jake-blucker-tMzCrBkM99Y-unsplash.jpg",
        "assets/posts/james-donaldson-toPRrcyAIUY-unsplash.jpg",
      ]),
  Data(
      url: "assets/profile/undraw_Pic_profile_re_7g2h.png",
      name: "paul",
      content: [
        "assets/posts/joel-filipe-QwoNAhbmLLo-unsplash.jpg",
        "assets/posts/pexels-maxandrey-1366630.jpg",
        "assets/posts/pexels-todd-trapani-488382-1535162.jpg",
      ]),
  Data(
      url: "assets/profile/undraw_Profile_pic_re_iwgo.png",
      name: "juliet",
      content: [
        "assets/posts/roland-larsson-8AceP6OOF3o-unsplash.jpg",
        "assets/posts/undraw_love_it_heart_dxlp.png",
        "assets/posts/undraw_undraw_application_ao1a_(1)_6anm.png",
      ]),
];

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
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
            statusColorBuilder: (context, item) {
              return Colors.orange;
            },
            avatarBuilder: (context, item) {
              return Image.asset(item?.url ?? "");
            },
            descriptionBuilder: (context, item) {
              return Text(item?.name ?? "");
            },
            backgroundBuilder: (context, item) {
              return Container(
                  color: Colors.grey[200], child: Image.asset(item?.$2 ?? ""));
            },
            foregroundBuilder: (context, item) {
              return Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item?.$1 ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ));
            },
            generateContentData: (item) {
              return item?.content.map((e) => (item.name, e)).toList() ?? [];
            },
          ),
        ),
      ),
    );
  }
}
