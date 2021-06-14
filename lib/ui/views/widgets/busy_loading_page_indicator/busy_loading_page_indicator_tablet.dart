part of busy_loading_page_indicator_widget;

class _BusyLoadingPageIndicatorTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
          Text('Loading...')
        ],
      ),
    );
  }
}
