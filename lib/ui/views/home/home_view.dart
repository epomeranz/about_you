library home_view;

import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/ui/views/home/widgets/home_view_footer.dart';
import 'package:about_you/ui/views/home/widgets/home_view_header.dart';
import 'package:about_you/ui/views/widgets/custom_group_list_view.dart';
import 'package:about_you/ui/views/widgets/contact_searched_item/contact_searched_item_widget.dart';
import 'package:about_you/ui/views/widgets/page_loading_error/page_loading_error_widget.dart';
import 'package:about_you/ui/views/widgets/search_expandable_body.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        disposeViewModel: false, //keep the instance when the user changes tabs
        //let the ViewModelBuilder to only initialize the VM once
        initialiseSpecialViewModelsOnce: true,
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (viewModel) async {
          // Do something once your viewModel is initialized
          await viewModel.initilize();
        },
        builder: (context, viewModel, child) {
          return viewModel.hasError
              ? PageLoadingErrorWidget(viewModel.error.toString())
              : ScreenTypeLayout(
                  mobile: _HomeMobile(viewModel),
                  desktop: _HomeDesktop(viewModel),
                  tablet: _HomeTablet(viewModel),
                );
        });
  }
}
