library busy_loading_page_indicator_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'busy_loading_page_indicator_mobile.dart';
part 'busy_loading_page_indicator_tablet.dart';
part 'busy_loading_page_indicator_desktop.dart';

class BusyLoadingPageIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _BusyLoadingPageIndicatorMobile(),
      desktop:
          _BusyLoadingPageIndicatorMobile(), //_BusyLoadingPageIndicatorDesktop(),
      tablet:
          _BusyLoadingPageIndicatorMobile(), //_BusyLoadingPageIndicatorTablet(),
    );
  }
}
