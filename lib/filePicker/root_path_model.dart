import 'package:flutter/cupertino.dart';

class RootPathModel extends ChangeNotifier{
  String _rootPath = "Please Select Path";

  String get selectedRootPath => _rootPath;

  set selectedRootPath(String path){
    _rootPath = path;
    notifyListeners();
  }
}