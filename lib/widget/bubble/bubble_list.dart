import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:updates/controllers/updates_controller.dart';
import 'package:updates/widget/agent/agent_list.dart';

part 'bubble_avatar.dart';
part 'bubble_description.dart';
part 'bubble.dart';

class BubbleList<A, C> extends StatelessWidget {
  const BubbleList({
    super.key,
    // List<T>? items,
    required double size,
    required double height,
    EdgeInsetsGeometry? padding,
    required UpdatesController<A> controller,
    required Color Function(BuildContext context, A? item) statusColorBuilder,
    required Widget Function(BuildContext context, A? item) avatarBuilder,
    required Widget Function(BuildContext context, A? item) descriptionBuilder,
    required Widget Function(BuildContext, C?) backgroundBuilder,
    required Widget Function(BuildContext, C?) foregroundBuilder,
    required List<C> Function(A?) generateContentData,
  })  :
        // _items = items,
        _size = size,
        _height = height,
        _padding = padding,
        _controller = controller,
        _statusColorBuilder = statusColorBuilder,
        _avatarBuilder = avatarBuilder,
        _descriptionBuilder = descriptionBuilder,
        _backgroundBuilder = backgroundBuilder,
        _foregroundBuilder = foregroundBuilder,
        _generateContentData = generateContentData;

  // final List<T>? _items;
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
        height: 148,
        child: PagedListView<int, A>(
          pagingController: _controller,
          scrollDirection: Axis.horizontal,
          padding: _padding,
          builderDelegate: PagedChildBuilderDelegate(
            firstPageProgressIndicatorBuilder: (context) {
              return Skeletonizer.zone(
                enabled: true,
                child: Row(
                  children: List<Widget>.generate(
                    8,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Bone.circle(
                            size: _size,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: PreferredSize(
                            preferredSize: Size.fromHeight(_height),
                            child: Bone.text(words: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: Text("Sem atualizações"),
            ),
            //newPageProgressIndicatorBuilder: (context) {
            //  return Skeletonizer.zone(
            //    enabled: true,
            //    child: Row(
            //      children: List<Widget>.generate(
            //        8,
            //        (index) => Column(
            //          children: [
            //            Padding(
            //              padding: const EdgeInsets.all(4.0),
            //              child: Bone.circle(
            //                size: _size,
            //              ),
            //            ),
            //            Padding(
            //              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            //              child: PreferredSize(
            //                preferredSize: Size.fromHeight(_height),
            //                child: Bone.text(words: 1),
            //              ),
            //            ),
            //          ],
            //        ),
            //      ),
            //    ),
            //  );
            //},
            firstPageErrorIndicatorBuilder: (context) {
              return Row(
                children: List<Widget>.generate(
                  8,
                  (index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: _size,
                          height: _size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200], // Cor grey[300]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: PreferredSize(
                          preferredSize: Size.fromHeight(_height),
                          child: Container(
                            height: 14, // Ajuste de altura conforme necessário
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Cor grey[300]
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            //newPageErrorIndicatorBuilder: (context) {
            //  return SizedBox.shrink();
            //},
            itemBuilder: (context, item, index) {
              return Bubble<A>(
                index: index,
                item: item,
                size: _size,
                height: _height,
                statusColorBuilder: _statusColorBuilder,
                avatarBuilder: _avatarBuilder,
                descriptionBuilder: _descriptionBuilder,
                onTap: (index) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AgentList<A, C>(
                          initialIndex: index,
                          agentItems: _controller.itemList!,
                          backgroundBuilder: _backgroundBuilder,
                          foregroundBuilder: _foregroundBuilder,
                          generateContentData: _generateContentData,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
