part of contact_searched_item_view;

class _ContactSearchedItemMobile extends StatelessWidget {
  final ContactSearchedItemViewModel viewModel;

  _ContactSearchedItemMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () async {
            FloatingSearchBar.of(context)!.close();
            // Future.delayed(
            //   const Duration(milliseconds: 500),
            //   () => viewModel.clear(),
            // );
            await viewModel.navigateToDetailPage();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 3500),
                    child: const Icon(
                      Icons.person,
                      key: Key('person'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.user.name,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
