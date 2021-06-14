import 'package:about_you/core/models/base/groupable_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grouped_list/grouped_list.dart';

class CustomGroupListView<T extends GroupableModels> extends StatelessWidget {
  final List<T> suggestions;
  final Function(T) itemCreated;
  final Widget Function(T item, Key? key) itemBuilder;

  const CustomGroupListView(
      {Key? key,
      required this.suggestions,
      required this.itemCreated,
      required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<T, String>(
        shrinkWrap: true,
        // key: PageStorageKey('Main_LW'),
        elements: suggestions,
        groupBy: (user) => user.listviewGroup,
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1.listviewItemComparator(item1, item2),
        order: GroupedListOrder.DESC,
        sort: false,
        useStickyGroupSeparators: true,
        separator: const Divider(),
        stickyHeaderBackgroundColor:
            Theme.of(context).backgroundColor.withAlpha(100),
        groupSeparatorBuilder: (String value) => Container(
              color: Theme.of(context).backgroundColor.withAlpha(100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        itemBuilder: (_, element) {
          ///Wait until the item finish building before calling
          ///function bellow that my create new items if the user is
          ///about to reach the end on the list
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
            await itemCreated(element);
          });
          return itemBuilder(element, ValueKey(element.hashCode));
        });
  }
}
