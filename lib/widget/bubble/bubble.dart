part of 'bubble_list.dart';

class Bubble<A> extends StatelessWidget {
  const Bubble({
    super.key,
    required int index,
    required A? item,
    required void Function(int index) onTap,
    required double size,
    required double height,
    BoxBorder? Function(BuildContext context, A? item)? statusColorBuilder,
    required Widget Function(BuildContext context, A? item) avatarBuilder,
    required Widget Function(BuildContext context, A? item) descriptionBuilder,
  })  : _index = index,
        _item = item,
        _onTap = onTap,
        _size = size,
        _height = height,
        _statusColorBuilder = statusColorBuilder,
        _avatarBuilder = avatarBuilder,
        _descriptionBuilder = descriptionBuilder;

  final int _index;
  final A? _item;
  final void Function(int index) _onTap;
  final double _size;
  final double _height;

  final BoxBorder? Function(BuildContext context, A? item)? _statusColorBuilder;
  final Widget Function(BuildContext context, A? item) _avatarBuilder;
  final Widget Function(BuildContext context, A? item) _descriptionBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap(_index);
      },
      child: SizedBox(
        height: _size + 56,
        width: _size + 8,
        child: Column(
          children: [
            BubbleAvatar<A>(
                // index: _index,
                item: _item,
                size: _size,
                statusColorBuilder: _statusColorBuilder,
                avatarBuilder: _avatarBuilder),
            BubbleDescription<A>(
                item: _item,
                // index: _index,
                height: _height,
                descriptionBuilder: _descriptionBuilder),
          ],
        ),
      ),
    );
  }
}
