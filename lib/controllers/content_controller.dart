import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef MaxIndexCallback = void Function();
typedef MinIndexCallback = void Function();

class ContentController {
  ContentController({
    int initialIndex = 0,
    required int numItems,
  })  : _isAnimated = false,
        _indicatorNotifier = ValueNotifier(initialIndex),
        _numItems = numItems,
        _animationController = null,
        _backgroundController = PageController(initialPage: initialIndex);

  ContentController.animated({
    int initialIndex = 0,
    required int numItems,
    required TickerProvider vsync,
  })  : _isAnimated = true,
        _indicatorNotifier = ValueNotifier(initialIndex),
        _numItems = numItems,
        _animationController = AnimationController(vsync: vsync),
        _backgroundController = PageController(initialPage: initialIndex);

  final bool _isAnimated;
  final int _numItems;
  final AnimationController? _animationController;
  final PageController _backgroundController;
  final ValueNotifier<int> _indicatorNotifier;
  ObserverList<MaxIndexCallback>? _maxIndexListeners = ObserverList();
  ObserverList<MinIndexCallback>? _minIndexListeners = ObserverList();

  bool get isAnimated => _isAnimated;
  int get numItems => _numItems;
  int get currentIndex => _indicatorNotifier.value;
  PageController get backgroundController => _backgroundController;
  ValueNotifier<int> get indicatorNotifier => _indicatorNotifier;
  AnimationController? get animationController => _animationController;

  void start({bool restart = false}) {
    if (restart) {
      _animationController?.reset();
    }
    _animationController?.forward();
  }

  void next() {
    if (currentIndex + 1 == numItems) {
      List<MaxIndexCallback> listeners = List.from(_maxIndexListeners ?? []);
      for (final listener in listeners) {
        listener();
      }
      return;
    }
    try {
      _backgroundController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      _indicatorNotifier.value = currentIndex + 1;
    } catch (_) {}
  }

  void previous() {
    if (currentIndex - 1 < 0) {
      List<MinIndexCallback> listeners = List.from(_minIndexListeners ?? []);
      for (final listener in listeners) {
        listener();
      }
      return;
    }
    try {
      _backgroundController.previousPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      _indicatorNotifier.value = currentIndex - 1;
    } catch (_) {}
  }

  void addOnMaxIndexCallback(MaxIndexCallback callback) {
    _maxIndexListeners?.add(callback);
  }

  void removeOnMaxIndexCallback(MaxIndexCallback callback) {
    _maxIndexListeners?.remove(callback);
  }

  void addOnMinIndexCallback(MinIndexCallback callback) {
    _minIndexListeners?.add(callback);
  }

  void removeOnMinIndexCallback(MinIndexCallback callback) {
    _minIndexListeners?.remove(callback);
  }

  void dispose() {
    _maxIndexListeners = null;
    _minIndexListeners = null;
    _animationController?.dispose();
    _backgroundController.dispose();
    _indicatorNotifier.dispose();
  }
}
