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
      backgroundColor: Theme.of(context).backgroundColor, //.withAlpha(200),
      resizeToAvoidBottomInset: true,
      body: FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: viewModel.searchBarController,
        clearQueryOnClose: false,
        closeOnBackdropTap: true,
        hint: S.of(context).search_hint,
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
        builder: (context, _) => SearchExpandableBody<UserSnippet>(
          suggestions: viewModel.suggestions.take(4).toList(),
          itemBuilder: (UserSnippet item, Key? key) =>
              ContactSearchedItemWidget(item: item, key: key),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 90, 0, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: HomeViewHeader(),
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 15,
            child: RefreshIndicator(
              onRefresh: viewModel.refreshData,
              child: CustomGroupListView<UserSnippet>(
                suggestions: viewModel.suggestions,
                itemBuilder: (UserSnippet item, Key? key) =>
                    ContactSearchedItemWidget(item: item, key: key),
                itemCreated: viewModel.handleItemCreated,
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 1,
            child: HomeViewFooter(),
          ),
        ],
      ),
    );
  }
}
