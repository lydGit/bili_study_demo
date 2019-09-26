import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class StateModel extends Model{
  int _index = 0;
  int get index => _index;

  void increaseCount(){
    _index +=1;
    debugPrint("StateManageDemo4 = $_index");
    notifyListeners();
  }
}