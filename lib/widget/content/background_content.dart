part of 'content.dart';

class BackgroundContent<C> extends StatelessWidget {
  const BackgroundContent({
    super.key,
    required List<C>? items,
    required ContentController contentController,
    required Widget Function(BuildContext context, C? data) backgroundBuilder,
  })  : _contentController = contentController,
        _backgroundBuilder = backgroundBuilder,
        _items = items;

  final List<C>? _items;
  final ContentController _contentController;
  final Widget Function(BuildContext context, C? data) _backgroundBuilder;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _contentController.backgroundController,
      itemCount: _items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      // onPageChanged: (index) {},
      itemBuilder: (context, index) {
        return _backgroundBuilder(context, _items?[index]);
      },
    );
  }
}
