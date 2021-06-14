part of contact_searched_item_view;

class _ContactSearchedItemTablet extends StatelessWidget {
  final ContactSearchedItemViewModel viewModel;

  _ContactSearchedItemTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(viewModel.user.name)),
    );
  }
}
