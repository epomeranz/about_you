library detail_view;

import 'package:about_you/ui/views/widgets/busy_loading_page_indicator/busy_loading_page_indicator_widget.dart';
import 'package:about_you/ui/views/widgets/page_loading_error/page_loading_error_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'detail_view_model.dart';

part 'detail_mobile.dart';
part 'detail_tablet.dart';
part 'detail_desktop.dart';

class DetailView extends StatelessWidget {
  final String id;

  const DetailView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DetailViewModel viewModel = DetailViewModel();
    return ViewModelBuilder<DetailViewModel>.reactive(
        disposeViewModel: true,
        createNewModelOnInsert: true,
        viewModelBuilder: () => DetailViewModel(id),
        initialiseSpecialViewModelsOnce: true,
        builder: (context, viewModel, child) {
          return viewModel.isBusy
              ? BusyLoadingPageIndicatorWidget()
              : viewModel.hasError
                  ? PageLoadingErrorWidget(viewModel.error.toString())
                  : ScreenTypeLayout(
                      mobile: _DetailMobile(viewModel),
                      desktop: _DetailDesktop(viewModel),
                      tablet: _DetailTablet(viewModel),
                    );
        });
  }
}
