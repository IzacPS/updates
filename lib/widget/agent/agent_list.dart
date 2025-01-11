import 'package:flutter/material.dart';
import 'package:updates/controllers/agent_controller.dart';

import 'agent.dart';

class AgentList<A, C> extends StatefulWidget {
  const AgentList({
    super.key,
    int initialIndex = 0,
    required List<A> agentItems,
    required Widget Function(BuildContext, C?) backgroundBuilder,
    required Widget Function(BuildContext, C?) foregroundBuilder,
    required List<C> Function(A?) generateContentData,
  })  : _initialIndex = initialIndex,
        _agentItems = agentItems,
        _backgroundBuilder = backgroundBuilder,
        _foregroundBuilder = foregroundBuilder,
        _generateContentData = generateContentData;

  final int _initialIndex;
  final List<A> _agentItems;
  final Widget Function(BuildContext, C?) _backgroundBuilder;
  final Widget Function(BuildContext, C?) _foregroundBuilder;
  final List<C> Function(A?) _generateContentData;

  @override
  State<AgentList<A, C>> createState() => _AgentListState<A, C>();
}

class _AgentListState<A, C> extends State<AgentList<A, C>> {
  late AgentController _agentController;
  @override
  void initState() {
    super.initState();
    _agentController = AgentController(
        initialPage: widget._initialIndex, numItems: widget._agentItems.length);
    _agentController.addOnMaxIndexCallback(() {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _agentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _agentController,
          itemCount: widget._agentItems.length,
          itemBuilder: (context, index) {
            return Agent<A, C>(
              agentIndex: index,
              items: widget._agentItems,
              agentController: _agentController,
              backgroundBuilder: widget._backgroundBuilder,
              foregroundBuilder: widget._foregroundBuilder,
              generateContentData: widget._generateContentData,
            );
          },
        ),
      ),
    );
  }
}
