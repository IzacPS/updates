import 'package:flutter/widgets.dart';

import '../../controllers/agent_controller.dart';
import '../../controllers/content_controller.dart';
import '../content/content.dart';

class Agent<A, C> extends StatefulWidget {
  const Agent({
    super.key,
    required int agentIndex,
    required List<A>? items,
    // required ContentController contentController,
    required AgentController agentController,
    required Widget Function(BuildContext, C?) backgroundBuilder,
    required Widget Function(BuildContext, C?) foregroundBuilder,
    required List<C> Function(A?) generateContentData,
  })  : _agentIndex = agentIndex,
        _items = items,
        // _contentController = contentController,
        _agentController = agentController,
        _backgroundBuilder = backgroundBuilder,
        _foregroundBuilder = foregroundBuilder,
        _generateContentData = generateContentData;

  final int _agentIndex;
  final List<A>? _items;
  // final ContentController _contentController;
  final AgentController _agentController;
  final Widget Function(BuildContext, C?) _backgroundBuilder;
  final Widget Function(BuildContext, C?) _foregroundBuilder;
  final List<C> Function(A?) _generateContentData;

  @override
  State<Agent<A, C>> createState() => _AgentState<A, C>();
}

class _AgentState<A, C> extends State<Agent<A, C>> {
  late ContentController _contentController;
  late List<C> _data;

  @override
  void initState() {
    super.initState();
    _data = widget._generateContentData(widget._items?[widget._agentIndex]);
    //TODO: verify the size of _data.
    //Alow zero sized list?
    _contentController = ContentController(numItems: _data.length);
    _contentController.addOnMaxIndexCallback(() {
      widget._agentController.next();
    });
    _contentController.addOnMinIndexCallback(() {
      widget._agentController.previous();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDownGesture,
      child: Content<C>(
        items: _data,
        contentController: _contentController,
        backgroundBuilder: widget._backgroundBuilder,
        foregroundBuilder: widget._foregroundBuilder,
      ),
    );
  }

  void _onTapDownGesture(TapDownDetails details) {
    double oneFourth = MediaQuery.of(context).size.width / 4;
    if (details.globalPosition.dx < oneFourth) {
      _contentController.previous();
    } else if (details.globalPosition.dx >= oneFourth * 3) {
      _contentController.next();
    }
  }
}
