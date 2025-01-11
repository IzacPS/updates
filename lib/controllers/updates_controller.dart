import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UpdatesController<T> extends PagingController<int, T> {
  UpdatesController({
    required super.firstPageKey,
    super.invisibleItemsThreshold,
  });
}
