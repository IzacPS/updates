// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter 3D transition',
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//         ),
//         home: Page1());
//   }
// }
//
// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.of(context).pushReplacement(
//             Pseudo3dRouteBuilder(this, Page2()),
//           ),
//           child: Text('change the page'),
//         ),
//       ),
//     );
//   }
// }
//
// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.of(context).pushReplacement(
//             Pseudo3dRouteBuilder(this, Page1()),
//           ),
//           child: Text('change the page'),
//         ),
//       ),
//     );
//   }
// }
//
// class Pseudo3dRouteBuilder extends PageRouteBuilder {
//   final Widget enterPage;
//   final Widget exitPage;
//   Pseudo3dRouteBuilder(this.exitPage, this.enterPage)
//       : super(
//           pageBuilder: (context, animation, secondaryAnimation) => enterPage,
//           transitionsBuilder: _transitionsBuilder(exitPage, enterPage),
//         );
//
//   static _transitionsBuilder(exitPage, enterPage) =>
//       (context, animation, secondaryAnimation, child) {
//         return Stack(
//           children: <Widget>[
//             SlideTransition(
//               position: Tween<Offset>(
//                 begin: Offset.zero,
//                 end: Offset(-1.0, 0.0),
//               ).animate(animation),
//               child: Container(
//                 color: Colors.white,
//                 child: Transform(
//                   transform: Matrix4.identity()
//                     ..setEntry(3, 2, 0.003)
//                     ..rotateY(pi / 2 * animation.value),
//                   alignment: FractionalOffset.centerRight,
//                   child: exitPage,
//                 ),
//               ),
//             ),
//             SlideTransition(
//               position: Tween<Offset>(
//                 begin: Offset(1.0, 0.0),
//                 end: Offset.zero,
//               ).animate(animation),
//               child: Container(
//                 color: Colors.white,
//                 child: Transform(
//                   transform: Matrix4.identity()
//                     ..setEntry(3, 2, 0.003)
//                     ..rotateY(pi / 2 * (animation.value - 1)),
//                   alignment: FractionalOffset.centerLeft,
//                   child: enterPage,
//                 ),
//               ),
//             )
//           ],
//         );
//       };
// }

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
        child: Updates<Data, String>(
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
                color: Colors.grey[200], child: Image.asset(item ?? ""));
          },
          foregroundBuilder: (context, item) {
            return Align(
                alignment: Alignment.bottomLeft, child: Text(item.toString()));
          },
          generateContentData: (item) {
            return item?.content ?? [];
          },
        ),
      ),
    );
  }
}

// // class _TestUpdatesState extends State<TestUpdates> {
// //   late final ContentController _controller;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = ContentController(numItems: 3);
// //     _controller.addOnMaxIndexCallback(() {
// //       debugPrint("-------------- reached max");
// //     });
// //     _controller.addOnMinIndexCallback(() {
// //       debugPrint("-------------- reached min");
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(backgroundColor: Colors.black),
// //       body: SafeArea(
// //         child: Content<String>(
// //           contentController: _controller,
// //           items: ["data 1", "data 2", "data 3"],
// //           backgroundBuilder: (context, content) {
// //             return Center(
// //               child: Text(content!),
// //             );
// //           },
// //           foregroundBuilder: (context, content, index) {
// //             return Align(
// //                 alignment: Alignment.topCenter,
// //                 child: Text("content: $content"));
// //           },
// //         ),
// //       ),
// //       bottomNavigationBar: SizedBox(
// //         height: 54,
// //         child: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               ElevatedButton.icon(
// //                   onPressed: () {
// //                     _controller.previous();
// //                   },
// //                   label: Icon(Icons.keyboard_arrow_left)),
// //               ElevatedButton.icon(
// //                   onPressed: () {
// //                     _controller.next();
// //                   },
// //                   label: Icon(Icons.keyboard_arrow_right)),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
