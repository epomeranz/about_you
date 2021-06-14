import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/ui/views/widgets/contact_searched_item/contact_searched_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class SearchExpandableBody<T extends Object> extends StatelessWidget {
  final List<T> suggestions;
  const SearchExpandableBody({Key? key, required this.suggestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8),
        child: ImplicitlyAnimatedList<T>(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: suggestions,
          areItemsTheSame: (a, b) => a == b,
          itemBuilder: (_, animation, item, i) {
            return SizeFadeTransition(
              animation: animation,
              child: _buildItem(item),
            );
          },
          updateItemBuilder: (_, animation, item) {
            return FadeTransition(
              opacity: animation,
              child: _buildItem(item),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(T item) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        key: ValueKey(item.hashCode),
        children: [
          (item is UserSnippet)
              ? ContactSearchedItemWidget(user: item)

              ///TODO: Implement a base class for all models and user a
              ///generic widget that display info from the base class
              : Text("unimplmeneted item type"),
          if (suggestions.isNotEmpty && item != suggestions.last)
            const Divider(height: 0),
        ]);
  }
}
