import 'dart:io';
import 'package:flutter/foundation.dart';
import 'custom_widgets/item_tile.dart';
import 'constants/back_tile.dart';

class FileSystemModel {
  final String name;
  final String path;
  final bool isFile;
  final bool isFolder;

  FileSystemModel({
    this.name,
    this.path,
    this.isFile,
    this.isFolder,
  });
}

class FileSystemModelList extends ChangeNotifier {
  FileSystemModelList();

  String _currentPath;
  List<String> _rootPath = [];
  Map<String,String> _selectedFiles = {};
  // Set<FileSystemModel> get selectedFiles => _selectedFiles;

  Map<String,String> get selectedFiles => _selectedFiles;

  void printSelectedFiles() {
    _selectedFiles.entries.forEach((item) {
      print(item.value + " : "+ item.key);

     });
    // _selectedFiles.forEach((item) {
    //   print(item.name + " : " + item.path);
    // });
  }

  void addInSelectedFiles(FileSystemModel item) {
    _selectedFiles[item.path] = item.name;
    // _selectedFiles.add(item);
    notifyListeners();
  }

  void removeFromSelectedFiles(FileSystemModel item) {
    _selectedFiles.remove(item.path);
    notifyListeners();
  }

  bool isFileSelected(FileSystemModel item) {
    if(_selectedFiles.keys.contains(item.path)){
      return true;
    }else{
      return false;
    }
  }

  List<String> get rootPath => _rootPath;

  void setRootPath(String path) {
    if (!_rootPath.contains(path)) {
      _rootPath.add(path);
    }
  }

  bool isRootPath(String path) {
    if (_rootPath.contains(path)) {
      return true;
    } else {
      return false;
    }
  }

  String get currentPath => _currentPath;

  set currentPath(String path) {
    if (path == "../" && !isRootPath(_currentPath)) {
      int currentPathLength = _currentPath.split("/").length;
      _currentPath =
          _currentPath.split("/").sublist(0, currentPathLength - 1).join("/");
      print(_currentPath);
    } else if (path != "../") {
      _currentPath = path;
    } else {
      print("Can't Access Root Directory");
    }

    genListOfFileAndFolder();
    notifyListeners();
  }

  List<FileSystemModel> list = [];
  // List<FileSystemModel> get list => _list;

  List<ItemTile> _listTiles = [ItemTile(item: kBackTile)];
  List<ItemTile> get listOfFileAndFolderTiles => _listTiles;

  void genListOfFileAndFolderTiles() {
    _listTiles = [ItemTile(item: kBackTile)];

    list.forEach((item) {
      _listTiles.add(ItemTile(item: item));
    });

    notifyListeners();
  }

  void genListOfFileAndFolder() {
    list = [];
    var myDir = new Directory(_currentPath);
    List<FileSystemEntity> filesNfolders = myDir.listSync();
    List<FileSystemModel> tempFiles = [];
    List<FileSystemModel> tempFolders = [];

    for (FileSystemEntity item in filesNfolders) {
      String path = item.path;
      String name = path.split("/").last;
      bool isFile = (item is File) ? true : false;
      bool isFolder = !isFile;

      if (isFile) {
        tempFiles.add(FileSystemModel(
          name: name,
          path: path,
          isFile: isFile,
          isFolder: isFolder,
        ));
      } else {
        tempFolders.add(FileSystemModel(
          name: name,
          path: path,
          isFile: isFile,
          isFolder: isFolder,
        ));
      }
    }

    tempFolders
        .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
    tempFiles
        .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));

    list.addAll(tempFolders);
    list.addAll(tempFiles);

    genListOfFileAndFolderTiles();
  }
}
