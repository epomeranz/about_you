part of busy_loading_page_indicator_widget;

class _BusyLoadingPageIndicatorMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
      ),
    );
  }
}
