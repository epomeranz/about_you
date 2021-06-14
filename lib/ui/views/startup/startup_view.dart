import 'package:about_you/ui/views/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model) async =>
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) async {
        await model.runStartupLogic();
      }),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Loading...'),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
