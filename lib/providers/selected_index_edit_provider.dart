import 'package:flutter/foundation.dart';

class SelectedIndexEditProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
