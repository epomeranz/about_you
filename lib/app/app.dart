import 'package:about_you/core/services/db/user_snippets_db_Service_mockup.dart';
import 'package:about_you/core/services/db/user_snippets_db_service_interface.dart';
import 'package:about_you/core/services/user_service_Mockup.dart';
import 'package:about_you/core/services/user_service_interface.dart';
import 'package:about_you/ui/views/detail/detail_view.dart';
import 'package:about_you/ui/views/home/home_view.dart';
import 'package:about_you/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: DetailView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: MockupUserService, asType: IUserService),
    LazySingleton(
        classType: MockupUserSnippetDBService, asType: IUserSnippetDBService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
