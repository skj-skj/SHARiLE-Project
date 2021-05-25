import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharile_v2/filePicker/file_system_main.dart';
// import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  // const ItemTile({
  //   this.name,
  //   this.path,
  //   this.isFile,
  //   this.isFolder,
  // });

  // final String name;
  // final String path;
  // final bool isFile;
  // final bool isFolder;

  final FileSystemModel item;

  const ItemTile({this.item});

  // const ItemTile(FileSystemModel item,);

  String getPath() {
    return item.path;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Provider.of<FileSystemModelList>(context, listen: true)
              .isFileSelected(item)
          ? Theme.of(context).accentColor
          : Colors.white,
      // color: Theme.of(context).primaryColor,
      child: ListTile(
        onTap: () {
          // print(item.path);
          if (item.isFolder) {
            // print("Inside if isFolder");
            Provider.of<FileSystemModelList>(context, listen: false)
                .currentPath = item.path;
          } else {
            if (!Provider.of<FileSystemModelList>(context, listen: false)
                .isFileSelected(item)) {
              print("Adding"); //For Debugging
              Provider.of<FileSystemModelList>(context, listen: false)
                  .addInSelectedFiles(item);
            } else {
              print("Removing"); //For Debugging
              Provider.of<FileSystemModelList>(context, listen: false)
                  .removeFromSelectedFiles(item);
            }
            Provider.of<FileSystemModelList>(context, listen: false)
                .printSelectedFiles(); //For Debugging

            print("____----END----____"); //For Debugging

            // Provider.of<FileSystemModelList>(context,listen: false).printSelectedFiles();
          }
        },
        leading: item.isFile ? FlutterLogo() : Icon(Icons.folder_open),
        title: Text(item.name),
      ),
    );
  }
}
