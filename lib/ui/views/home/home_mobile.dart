part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel viewModel;

  _HomeMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.contacts_outlined),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withAlpha(250),
      resizeToAvoidBottomInset: false,
      body: FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: viewModel.searchBarController,
        clearQueryOnClose: false,
        closeOnBackdropTap: true,
        hint: 'Search...',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        actions: actions,
        progress: viewModel.isBusy,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: viewModel.onQueryChanged,
        onSubmitted: viewModel.onQueryChanged,
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        builder: (context, _) => SearchExpandableBody(
          suggestions: viewModel.suggestions.take(4).toList(),
        ),
        body: RefreshIndicator(
          onRefresh: viewModel.refreshData,
          child: CustomGroupListView<UserSnippet>(
            suggestions: viewModel.suggestions,
            itemBuilder: (UserSnippet item, Key? key) =>
                ContactSearchedItemWidget(item: item, key: key),
            itemCreated: viewModel.handleItemCreated,
          ),
        ),
      ),
    );
  }
}
