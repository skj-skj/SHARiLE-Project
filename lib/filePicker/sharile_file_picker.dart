import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:provider/provider.dart';
import 'file_system_main.dart';
import 'root_path_model.dart';
import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(
//     SharileFilePicker(),
//   );
// }

Future<void> requestStoragePermission() async {
  var storageStatus = await Permission.storage.status;
  if (!storageStatus.isGranted) {
    final status = await Permission.storage.request();
    print(status);
  } else {
    print('Already Granted');
  }
}

class SharileFilePicker extends StatelessWidget {
  static const String id = 'sharile_file_picker';
// Platform messages are asynchronous, so we initialize in an async method.
  Future<List<StorageInfo>> getStorageLocationInfo() async {
    List<StorageInfo> _storageInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    return _storageInfo;
  }

  final String rootPath = "";
  @override
  Widget build(BuildContext context) {
    requestStoragePermission();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RootPathModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FileSystemModelList(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("SHARiLE File Picker"),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(text: "Storage"),
                  Tab(text: "File Picker"),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      // context.read<FileSystemModelList>().printSelectedFiles();
                      Map<String, String> selectedFilesToSend =
                          context.read<FileSystemModelList>().selectedFiles;
                      // Navigator.popUntil(context, (route) => false)
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context, selectedFilesToSend);
                      // });
                    },
                    child: Icon(Icons.done),
                  ),
                )
              ],
            ),
            body: TabBarView(
              children: [
                Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print("Internal Storage");
                          DefaultTabController.of(context).animateTo(1);
                          List<StorageInfo> storageInfo =
                              await getStorageLocationInfo();

                          //This if Checks if the storageInfo gets Internal Storage path as the length of storage info should be atleast 1.
                          if (storageInfo.length >= 1) {
                            String path = storageInfo[0].rootDir;
                            print("$path");
                            final snackBar = SnackBar(content: Text("$path"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            if (path.length > 1) {
                              // context.read<RootPathModel>().selectedRootPath =
                              //     storageInfo[0].rootDir;

                              context
                                  .read<FileSystemModelList>()
                                  .setRootPath(path);
                              context.read<FileSystemModelList>().currentPath =
                                  path;

                              context
                                  .read<FileSystemModelList>()
                                  .genListOfFileAndFolder();
                            }
                          }
                        },
                        child: Text("Internal Storage"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print("External Storage");
                          DefaultTabController.of(context).animateTo(1);
                          List<StorageInfo> storageInfo =
                              await getStorageLocationInfo();
                          //This if Checks if the storageInfo gets External Storage path as the length of storage info should be atleast 2.
                          if (storageInfo.length > 1) {
                            String path = storageInfo[1].rootDir;
                            print("$path");

                            if (path.length > 1) {
                              // context.read<RootPathModel>().selectedRootPath =
                              //     storageInfo[1].rootDir;
                              context
                                  .read<FileSystemModelList>()
                                  .setRootPath(path);
                              context.read<FileSystemModelList>().currentPath =
                                  path;

                              context
                                  .read<FileSystemModelList>()
                                  .genListOfFileAndFolder();
                            }
                          }
                          // DefaultTabController.of(context).animateTo(1);
                        },
                        child: Text("External Storage"),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: Consumer<RootPathModel>(
                      builder: (context, rootPath, child) {
                        return Consumer<FileSystemModelList>(
                          builder: (context, list, child) {
                            return ListView(
                              children: list.listOfFileAndFolderTiles,
                            );
                          },
                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(rootPath.selectedRootPath),
                          //     Icon(Icons.folder),
                          //   ],
                          // ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
