part of detail_view;

class _DetailMobile extends StatelessWidget {
  final DetailViewModel viewModel;

  _DetailMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.data?.name ?? "Loading..."),
      ),
      body: Center(
        child: Text(
          viewModel.data?.name ?? "Loading...",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
