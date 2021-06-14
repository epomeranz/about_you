library contact_searched_item_view;

import 'package:about_you/core/models/users/user_snippet.dart';
import 'package:about_you/ui/views/widgets/busy_loading_page_indicator/busy_loading_page_indicator_widget.dart';
import 'package:about_you/ui/views/widgets/page_loading_error/page_loading_error_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'contact_searched_item_view_model.dart';

part 'contact_searched_item_mobile.dart';
part 'contact_searched_item_tablet.dart';
part 'contact_searched_item_desktop.dart';

class ContactSearchedItemWidget extends StatelessWidget {
  final UserSnippet item;

  const ContactSearchedItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactSearchedItemViewModel>.reactive(
        disposeViewModel: true,
        createNewModelOnInsert: true,
        viewModelBuilder: () => ContactSearchedItemViewModel(item),
        builder: (context, viewModel, child) {
          return viewModel.isBusy
              ? BusyLoadingPageIndicatorWidget()
              : viewModel.hasError
                  ? PageLoadingErrorWidget(viewModel.error.toString())
                  : ScreenTypeLayout(
                      mobile: _ContactSearchedItemMobile(viewModel),
                      desktop: _ContactSearchedItemMobile(
                          viewModel), //_ContactSearchedItemDesktop(viewModel),
                      tablet: _ContactSearchedItemMobile(
                          viewModel), //_ContactSearchedItemTablet(viewModel),
                    );
        });
  }
}
