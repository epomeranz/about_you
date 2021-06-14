import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class SearchExpandableBody<T extends Object> extends StatelessWidget {
  final List<T> suggestions;
  final Widget Function(T item, Key? key) itemBuilder;

  const SearchExpandableBody(
      {Key? key, required this.suggestions, required this.itemBuilder})
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
    return itemBuilder(item, ValueKey(item.hashCode));
  }
}
