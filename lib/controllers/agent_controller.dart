import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef MaxIndexCallback = void Function();
typedef MinIndexCallback = void Function();

class AgentController extends PageController {
  AgentController({
    required int numItems,
    super.initialPage = 0,
    super.keepPage = true,
    super.viewportFraction = 1.0,
    super.onAttach,
    super.onDetach,
  })  : _numItems = numItems,
        _currentIndex = initialPage;

  final int _numItems;
  int _currentIndex;

  int get numItems => _numItems;
  int get currentIndex => _currentIndex;

  ObserverList<MaxIndexCallback>? _maxIndexListeners = ObserverList();
  ObserverList<MinIndexCallback>? _minIndexListeners = ObserverList();

  void next() {
    if (currentIndex + 1 == numItems) {
      List<MaxIndexCallback> listeners = List.from(_maxIndexListeners ?? []);
      for (final listener in listeners) {
        listener();
      }
      return;
    }
    try {
      nextPage(duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      _currentIndex = currentIndex + 1;
    } catch (e) {
      debugPrint(e.toString());
    }
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
      previousPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      _currentIndex = currentIndex - 1;
    } catch (e) {
      debugPrint(e.toString());
    }
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

  @override
  void dispose() {
    _maxIndexListeners = null;
    _minIndexListeners = null;
    super.dispose();
  }
}
