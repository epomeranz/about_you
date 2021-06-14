abstract class GroupableModels<T extends Object> {
  String get listviewGroup;
  int listviewItemComparator(T item1, T item2);
}
