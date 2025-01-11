part of 'content.dart';

class IndicatorList extends StatelessWidget {
  const IndicatorList({super.key, required ContentController contentController})
      : _contentController = contentController;

  final ContentController _contentController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < _contentController.numItems; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ListenableBuilder(
                listenable: _contentController.indicatorNotifier,
                builder: (context, _) {
                  return (i == _contentController.currentIndex)
                      ? _StaticProgressIndicator(
                          color: Colors.white,
                        )
                      : const _StaticProgressIndicator();
                },
              ),
            ),
          ),
      ],
    );
  }
}

class AnimatedIndicatorList extends StatelessWidget {
  AnimatedIndicatorList({
    super.key,
    required ContentController contentController,
  })  : _contentController = contentController,
        assert(
            contentController.isAnimated &&
                contentController.animationController != null,
            "ContentController has to be configured to be animated");

  final ContentController _contentController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < _contentController.numItems; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ListenableBuilder(
                listenable: _contentController.indicatorNotifier,
                builder: (context, _) {
                  return (i == _contentController.currentIndex)
                      ? _ProgressIndicator(
                          animationController:
                              _contentController.animationController!,
                        )
                      : const _StaticProgressIndicator();
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _ProgressIndicator extends AnimatedWidget {
  const _ProgressIndicator({required AnimationController animationController})
      : super(listenable: animationController);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 3,
      backgroundColor: Colors.grey,
      valueColor: const AlwaysStoppedAnimation(
        Colors.white,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      value: _progress.value,
    );
  }
}

class _StaticProgressIndicator extends StatelessWidget {
  const _StaticProgressIndicator({Color color = Colors.grey}) : _color = color;

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
}
