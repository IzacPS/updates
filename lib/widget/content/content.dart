import 'package:flutter/material.dart';
import '../../controllers/content_controller.dart';

part 'background_content.dart';
part 'foreground_content.dart';
part 'progress_indicator.dart';

class Content<C> extends StatelessWidget {
  Content({
    super.key,
    required List<C>? items,
    required ContentController contentController,
    required Widget Function(BuildContext context, C? item) backgroundBuilder,
    required Widget Function(BuildContext context, C? item) foregroundBuilder,
  })  : assert(contentController.numItems == (items?.length ?? 0),
            "ContentController numItems has to be the same as backgroundItems list."),
        _items = items,
        _contentController = contentController,
        _backgroundBuilder = backgroundBuilder,
        _foregroundBuilder = foregroundBuilder;

  final List<C>? _items;
  final ContentController _contentController;
  final Widget Function(BuildContext context, C? data) _backgroundBuilder;
  final Widget Function(BuildContext context, C? item) _foregroundBuilder;

  // @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackgroundContent<C>(
            items: _items,
            contentController: _contentController,
            backgroundBuilder: _backgroundBuilder,
          ),
        ),
        Positioned.fill(
          child: Column(
            children: [
              // Gradiente superior
              Container(
                height: 120, // Altura do gradiente superior
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.6), // Escuro
                      Colors.transparent, // Transparente
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Spacer(),
              // Gradiente inferior
              Container(
                height: 120, // Altura do gradiente inferior
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent, // Transparente
                      Colors.black.withValues(alpha: 0.6), // Escuro
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
            child: ForegroundContent<C>(
          items: _items,
          contentController: _contentController,
          foregroundBuilder: _foregroundBuilder,
        )),
      ],
    );
  }
}
