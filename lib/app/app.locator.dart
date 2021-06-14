// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/services/db/user_snippets_db_Service_mockup.dart';
import '../core/services/db/user_snippets_db_service_interface.dart';
import '../core/services/user_service_Mockup.dart';
import '../core/services/user_service_interface.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton<IUserService>(() => MockupUserService());
  locator.registerLazySingleton<IUserSnippetDBService>(
      () => MockupUserSnippetDBService());
}
