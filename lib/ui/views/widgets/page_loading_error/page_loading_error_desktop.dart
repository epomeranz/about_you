part of page_loading_error_widget;

class _PageLoadingErrorDesktop extends StatelessWidget {
  final String message;
  _PageLoadingErrorDesktop(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
