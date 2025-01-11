import 'dart:math';

import 'package:flutter/widgets.dart';

import '../controllers/updates_controller.dart';
import 'bubble/bubble_list.dart';

class Updates<A, C> extends StatelessWidget {
  Updates({
    super.key,
    double size = 92,
    double height = 54,
    EdgeInsetsGeometry? padding,
    required UpdatesController<A> controller,
    required Color Function(BuildContext context, A? item) statusColorBuilder,
    required Widget Function(BuildContext context, A? item) avatarBuilder,
    required Widget Function(BuildContext context, A? item) descriptionBuilder,
    required Widget Function(BuildContext, C?) backgroundBuilder,
    required Widget Function(BuildContext, C?) foregroundBuilder,
    required List<C> Function(A?) generateContentData,
  })  : _size = max(size, 24),
        _height = max(height, 54),
        _padding = padding,
        _controller = controller,
        _statusColorBuilder = statusColorBuilder,
        _avatarBuilder = avatarBuilder,
        _descriptionBuilder = descriptionBuilder,
        _backgroundBuilder = backgroundBuilder,
        _foregroundBuilder = foregroundBuilder,
        _generateContentData = generateContentData;

  final double _size;
  final double _height;
  final EdgeInsetsGeometry? _padding;
  final UpdatesController<A> _controller;
  final Color Function(BuildContext context, A? item) _statusColorBuilder;
  final Widget Function(BuildContext context, A? item) _avatarBuilder;
  final Widget Function(BuildContext context, A? item) _descriptionBuilder;
  final Widget Function(BuildContext, C?) _backgroundBuilder;
  final Widget Function(BuildContext, C?) _foregroundBuilder;
  final List<C> Function(A?) _generateContentData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: SizedBox(
        height: _size + 56,
        child: BubbleList<A, C>(
          size: _size,
          height: _height,
          padding: _padding,
          controller: _controller,
          statusColorBuilder: _statusColorBuilder,
          avatarBuilder: _avatarBuilder,
          descriptionBuilder: _descriptionBuilder,
          backgroundBuilder: _backgroundBuilder,
          foregroundBuilder: _foregroundBuilder,
          generateContentData: _generateContentData,
        ),
      ),
    );
  }
}
