library page_loading_error_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'page_loading_error_mobile.dart';
part 'page_loading_error_tablet.dart';
part 'page_loading_error_desktop.dart';

class PageLoadingErrorWidget extends StatelessWidget {
  final String message;
  PageLoadingErrorWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _PageLoadingErrorMobile(message),
      desktop: _PageLoadingErrorDesktop(message),
      tablet: _PageLoadingErrorTablet(message),
    );
  }
}
