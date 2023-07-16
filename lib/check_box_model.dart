// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class MyCheckBox {
  bool isCheck;
  Color color;
  MyCheckBox({
    this.isCheck = false,
    required this.color,
  });

  @override
  bool operator ==(covariant MyCheckBox other) {
    if (identical(this, other)) return true;

    return other.isCheck == isCheck && other.color == color;
  }

  @override
  int get hashCode => isCheck.hashCode ^ color.hashCode;
}

class UnicCheckBoxes {
  final items = [
    MyCheckBox(isCheck: false, color: Colors.green),
    MyCheckBox(isCheck: true, color: Colors.red),
    MyCheckBox(isCheck: false, color: Colors.yellow),
  ];

  void onItemTap(MyCheckBox tappedItem) {
    for (var item in items) {
      if (item == tappedItem) {
        item.isCheck = true;
      } else {
        item.isCheck = false;
      }
    }
  }
}

class CheckBoxModel extends ChangeNotifier {
  int _animationDuration = 200;
  final _checkBoxesType = UnicCheckBoxes();
  final _checkBoxList = <MyCheckBox>[];

  List<MyCheckBox> get checkBoxList => _checkBoxList;

  double get animationDuration => _animationDuration.toDouble();
  set animationDuration(double value) => _animationDuration = value.toInt();

  void addCheckBoxes() {
    final checkBoxesTypeCount = _checkBoxesType.items.length;
    for (var i = 0; i < 10; i++) {
      final randomInt = Random().nextInt(checkBoxesTypeCount);
      _checkBoxList.add(_checkBoxesType.items[randomInt]);
    }
    notifyListeners();
  }

  void removeCheckBoxes() {
    _checkBoxList.clear();
    notifyListeners();
  }

  void onTapItem(int num) {
    final tappedItem = _checkBoxList[num];
    if (tappedItem.isCheck) {
      return;
    }
    _checkBoxesType.onItemTap(tappedItem);
    for (var item in _checkBoxList) {
      if (item == tappedItem) {
        item.isCheck = true;
      } else {
        item.isCheck = false;
      }
    }
    notifyListeners();
  }
}
