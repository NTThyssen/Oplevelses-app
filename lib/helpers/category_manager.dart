import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/enums.dart';

class CategoryManager with ChangeNotifier {
  ActivityState _exerciseState = ActivityState.NotSelected;
  ActivityState _entertainmentState = ActivityState.NotSelected;
  ActivityState _foodState = ActivityState.NotSelected;
  ActivityState _nightlifeState = ActivityState.NotSelected;
  ActivityState _cultureState = ActivityState.NotSelected;
  ActivityState _educationState = ActivityState.NotSelected;
  ActivityState _freeState = ActivityState.NotSelected;

  ActivityState get exerciseState => _exerciseState;
  ActivityState get entertainmentState => _entertainmentState;
  ActivityState get foodState => _foodState;
  ActivityState get nightlifeState => _nightlifeState;
  ActivityState get cultureState => _cultureState;
  ActivityState get educationState => _educationState;
  ActivityState get freeState => _freeState;

  void setExerciseState(ActivityState state, BuildContext context) {
    if (_exerciseState != state) {
      _exerciseState = state;
      // TODO: implement save method to storage
      _printStatus("Exercise", state.toString());
      notifyListeners();
    }
  }

  void setEntertainmentState(ActivityState state, BuildContext context) {
    if (_entertainmentState != state) {
      _entertainmentState = state;
      // TODO: implement save method to storage
      _printStatus("Entertainment", state.toString());
      notifyListeners();
    }
  }

  void setFoodState(ActivityState state, BuildContext context) {
    if (_foodState != state) {
      _foodState = state;
      // TODO: implement save method to storage
      _printStatus("Food", state.toString());
      notifyListeners();
    }
  }

  void setNightlifeState(ActivityState state, BuildContext context) {
    if (_nightlifeState != state) {
      _nightlifeState = state;
      // TODO: implement save method to storage
      _printStatus("Nightlife", state.toString());
      notifyListeners();
    }
  }

  void setCultureState(ActivityState state, BuildContext context) {
    if (_cultureState != state) {
      _cultureState = state;
      // TODO: implement save method to storage
      _printStatus("Culture", state.toString());
      notifyListeners();
    }
  }

  void setEducationState(ActivityState state, BuildContext context) {
    if (_educationState != state) {
      _educationState = state;
      // TODO: implement save method to storage
      _printStatus("Education", state.toString());
      notifyListeners();
    }
  }

  void setFreeState(ActivityState state, BuildContext context) {
    if (_freeState != state) {
      _freeState = state;
      // TODO: implement save method to storage
      _printStatus("Free", state.toString());
      notifyListeners();
    }
  }

  void _printStatus(String variableName, variableValue) {
    print("Interest-manager changed:'$variableName' to $variableValue");
  }
}
