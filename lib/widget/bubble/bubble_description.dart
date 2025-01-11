part of 'bubble_list.dart';

class BubbleDescription<A> extends StatelessWidget {
  const BubbleDescription({
    super.key,
    required A? item,
    // required int index,
    required double height,
    required Widget Function(BuildContext context, A? item) descriptionBuilder,
  })  : _item = item,
        // _index = index,
        _height = height,
        _descriptionBuilder = descriptionBuilder;

  final A? _item;
  // final int _index;
  final double _height;
  final Widget Function(BuildContext context, A? item) _descriptionBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: PreferredSize(
        preferredSize: Size.fromHeight(_height),
        child: _descriptionBuilder(context, _item),
      ),
    );
  }
}
