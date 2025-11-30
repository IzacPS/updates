part of 'bubble_list.dart';

class BubbleAvatar<A> extends StatelessWidget {
  const BubbleAvatar({
    super.key,
    BoxBorder? Function(BuildContext context, A? item)? statusColorBuilder,
    required Widget Function(BuildContext context, A? item) avatarBuilder,
    required A? item,
    // required int index,
    required double size,
  })  : _statusColorBuilder = statusColorBuilder,
        _avatarBuilder = avatarBuilder,
        _item = item,
        // _index = index,
        _size = size;

  final BoxBorder? Function(BuildContext context, A? item)? _statusColorBuilder;
  final Widget Function(BuildContext context, A? item) _avatarBuilder;
  final A? _item;
  // final int _index;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: _statusColorBuilder?.call(context, _item),
        //Border.all(color: _statusColorBuilder(context, _item), width: 3),
      ),
      child: ClipOval(child: _avatarBuilder(context, _item)),
    );
  }
}
