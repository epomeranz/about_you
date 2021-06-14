part of contact_searched_item_view;

class _ContactSearchedItemDesktop extends StatelessWidget {
  final ContactSearchedItemViewModel viewModel;

  _ContactSearchedItemDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Text(viewModel.user.name);
  }
}
