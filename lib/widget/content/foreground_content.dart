part of 'content.dart';

class ForegroundContent<C> extends StatelessWidget {
  const ForegroundContent({
    super.key,
    required List<C>? items,
    required ContentController contentController,
    required Widget Function(BuildContext context, C? item) foregroundBuilder,
  })  : _items = items,
        _contentController = contentController,
        _foregroundBuilder = foregroundBuilder;

  final List<C>? _items;
  final ContentController _contentController;
  final Widget Function(BuildContext context, C? item) _foregroundBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (_contentController.isAnimated)
              ? AnimatedIndicatorList(
                  contentController: _contentController,
                )
              : IndicatorList(contentController: _contentController),
        ),
        ListenableBuilder(
          listenable: _contentController.indicatorNotifier,
          builder: (context, value) => Expanded(
              child: _foregroundBuilder(
                  context, _items?[_contentController.currentIndex])),
        ),
      ],
    );
  }
}
