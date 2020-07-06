import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../bloc/setup_bloc.dart';
import 'create_home.dart';
import 'setup_user.dart';

class SetupSteps extends StatefulWidget {
  SetupSteps({Key key}) : super(key: key);

  @override
  _SetupStepsState createState() => _SetupStepsState();
}

class _SetupStepsState extends State<SetupSteps> {
  String _username = "";
  String _homeName = "";
  final FocusNode _userFocus = FocusNode();
  final FocusNode _homeFocus = FocusNode();
  var _currentStep = 0;
  TextStyle textStyle = const TextStyle(fontSize: 16.0);

  void next() {
    if (_currentStep + 1 != 4) goTo(_currentStep + 1);
  }

  void cancel() {
    if (_currentStep > 0) {
      goTo(_currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(() => _currentStep = step);
  }

  Widget buildControls(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    String continueTitle;
    if (_currentStep == 0) {
      continueTitle = MaterialLocalizations.of(context).okButtonLabel;
    }
    if (_currentStep == 3) {
      continueTitle = S.of(context).SETUP_SEND;
    } else {
      continueTitle = MaterialLocalizations.of(context).continueButtonLabel;
    }
    var cancelVisible = true;
    if (_currentStep == 0) {
      cancelVisible = false;
    }
    Function finishAction;
    if (_currentStep == 3) {
      if (_username != "" && _homeName != "") {
        finishAction = () => sl<SetupBloc>().add(CreateHomeAndFinish(_username, _homeName));
      } else {
        finishAction = null;
      }
    } else {
      finishAction = onStepContinue;
    }
    return Row(
      children: [
        FlatButton(
          onPressed: finishAction,
          color: Theme.of(context).backgroundColor,
          textColor: Colors.white,
          textTheme: ButtonTextTheme.normal,
          child: Text(continueTitle),
        ),
        cancelVisible
            ? Container(
                margin: const EdgeInsetsDirectional.only(start: 8.0),
                child: FlatButton(
                  onPressed: onStepCancel,
                  textColor: Colors.white70,
                  textTheme: ButtonTextTheme.normal,
                  child: Text(MaterialLocalizations.of(context).backButtonTooltip),
                ),
              )
            : null,
      ]..removeWhere((element) => element == null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      type: StepperType.vertical,
      steps: [
        Step(
          title: Text(S.of(context).SETUP_INTRODUCTION),
          content: Text(S.of(context).SETUP_WELCOME_CARD_TITLE, style: textStyle),
        ),
        Step(
          state: _username != "" ? StepState.complete : StepState.error,
          title: Text(S.of(context).SETUP_USERNAME),
          content: SetupUser(
            callback: (value) => setState(() => _username = value),
            focus: _userFocus,
          ),
        ),
        Step(
          state: _homeName != "" ? StepState.complete : StepState.error,
          title: Text(S.of(context).SETUP_HOME_NAME),
          content: CreateHome(
            callback: (value) => setState(() => _homeName = value),
            focus: _homeFocus,
          ),
        ),
        Step(
          state: _username != "" && _homeName != "" ? StepState.complete : StepState.error,
          title: Text(S.of(context).SETUP_FINISH),
          content: _username != "" && _homeName != ""
              ? Text(
                  S.of(context).SETUP_FINISH_DESCRIPTION,
                  style: textStyle,
                )
              : Text(
                  S.of(context).SETUP_FINISH_DESCRIPTION_ERROR,
                  style: textStyle,
                ),
        ),
      ],
      controlsBuilder: buildControls,
      onStepContinue: next,
      onStepTapped: goTo,
      onStepCancel: cancel,
    );
  }
}
