import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'package:http_server/http_server.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sharile_v2/brain/html_generator.dart';
import 'package:sharile_v2/constants/web_static_data.dart';
// import 'package:sharile_v2/components/route_animation.dart';
// import 'package:sharile_v2/filePicker/sharile_file_picker.dart';

class ServerBrain {
  HttpServer _server;
  String _ipAddress = '0.0.0.0';
  HtmlGenerator _htmlGenerator = HtmlGenerator();
  Map<String, String> _filePaths = {};

  ServerBrain() {
    setIpAddress();
  }

  void setIpAddress() async {
    // getting Gateway ip Address;
    _ipAddress = await GetIp.ipAddress;
  }

  startServer({int port}) async {
    // getting Gateway ip Address;
    _ipAddress = await GetIp.ipAddress;
    // Starting the server
    _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    // Appending the port to the ip Address
    _ipAddress += ':${_server.port}';
    print(_ipAddress);
  }

  stopServer() {
    // Stops the Server
    _server.close();
    // Clear Temporary Files
    // FilePicker.platform.clearTemporaryFiles();
    // Deleting all Data in _filePaths
    _filePaths = {};
  }

  sendFile({Map<String, String> selectedFileResult}) async {
    // Select Files

    Map<String, String> result = selectedFileResult;
    // await Navigator.push(context, MaterialPageRoute(builder: (context) => SharileFilePicker()));
    print(result);
    // FilePickerResult result = await FilePicker.platform
    //     .pickFiles(allowMultiple: true, withData: false, withReadStream: true);
    // Converting to Map of <String, String>
//     if (result != null) {
//       List<String> tempPaths = result.paths;
//       List<String> tempNames = result.names;
//       for (int i = 0; i < result.count; i++) {
//         _filePaths.addAll({'${tempPaths[i]}': tempNames[i]});
//         print(_filePaths);
//       }
// //      _filePaths = Map.fromIterable(result.paths, key: (e) => e)
//     }

//    _filePaths = await FilePicker.platform.getMultiFilePath(); //Old Legacy Code of File Picker

    _filePaths = result;
    // Creating Virtual Directory
    VirtualDirectory staticFiles = VirtualDirectory('.')
      ..allowDirectoryListing = true
      ..jailRoot = false;

    // Getting dirPath
    String dirPath = (await getExternalStorageDirectory()).path;
    print('DirPath :' + dirPath);

    //Generating index.html for selected files.
    _htmlGenerator.generateSendIndexHtml(filePaths: _filePaths);

    // Writing index.html to dirPath
    _htmlGenerator.writeIndexHTML(path: dirPath);

    // Listening Request
    _server.listen((req) {
      //This is to limit the maximum conneciton
      // active connections 4 means max 3 connection:
      // 1 for browser to view index.html, 2 for downloading
      if (_server.connectionsInfo().active < 5) {
        //Serving index file
        staticFiles.directoryHandler = (dir, request) {
          var indexUri = Uri.file(dir.path).resolve('$dirPath/index.html');
          staticFiles.serveFile(File(indexUri.toFilePath()), request);
        };
        // req.response.write("Reached Maximum Connection Limit");
        // req.response.close();
        // print("Active: ${_server.connectionsInfo().active}");
        // print("Total: ${_server.connectionsInfo().total}");
        // print("Idle: ${_server.connectionsInfo().idle}");
        // print("Closing: ${_server.connectionsInfo().closing}");
        staticFiles.serveRequest(req);
      }
    });
  }

  uploadFile() async {
    print("Inside upload");
    Directory rootDir = (await getExternalStorageDirectory());
    print(rootDir.path);
    // Splitting Dir Path
    List<String> dirPathList = rootDir.path.split('/');
    // getting Position of 'Android'
    int posAndroidDir = dirPathList.indexOf('Android');
    // Adding 'SHARiLE' at the position of 'Android'
    dirPathList.insert(posAndroidDir, 'SHARiLE');
    //Joining the List<Strings> to generate the dirPath
    String dirPath = dirPathList.sublist(0, posAndroidDir + 1).join('/');
    print(dirPath);

    //Create Directory on Android Device
    Directory sharileDirPath = Directory(dirPath);
    if (!sharileDirPath.existsSync()) {
      print('Creating Dir');
      await sharileDirPath.create(recursive: true);
//      Directory(dirPath)
//          .create(recursive: true)
//          .then((Directory directory) => print('Path: ${directory.path}'));
      print('Created Dir');
    } else {
      print('Already Existed');
    }

    _server.listen((request) async {
      if (request.uri.path == '/') {
        print("Home");
        //starting page to upload file (not accessing endpoint '/upload')
        request.response
          ..headers.contentType = ContentType.html
          //HTML form
          ..write(_htmlGenerator.generateReceiveIndexHtml());
      } else if (request.uri.path == '/app.css') {
        //starting page to upload file (not accessing endpoint '/app.css')
        request.response
          ..headers.contentType = ContentType('text', 'css')
          //CSS style
          ..write(_htmlGenerator.generateReceiveIndexCSS());
      } else if (request.uri.path == '/upload') {
        // accessing 'upload' endpoint
        // Removing DataBytes variable
        // List<int> dataBytes = [];

        await for (var data in request) {
          // received data but don't know the file name & type
          // dataBytes.addAll(data);
          // storing data in storage as temp file
          await File('$dirPath/temp').writeAsBytes(data, mode: FileMode.append);
        }
        // Converting Data to Stream & getting file name and type
        String boundary = request.headers.contentType.parameters['boundary'];
        final transformer = MimeMultipartTransformer(boundary);

        //Removing bodyStream
        // final bodyStream = Stream.fromIterable([dataBytes]);

        //Getting parts data from temp file as stream instead of bodyStream.
        // final parts = await transformer.bind(bodyStream).toList();
        final parts = await transformer
            .bind(File('$dirPath/temp').readAsBytes().asStream())
            .toList();

        for (var part in parts) {
          //getting the content info
          final contentDisposition = part.headers['content-disposition'];
          print(contentDisposition);
          // getting content/file in form of list
          final content = await part.toList();
          // logic to get file name from contentDisposition
          final int startPos =
              contentDisposition.indexOf('filename="') + 'filename="'.length;
          final int endPos = contentDisposition.length - 1;
          // set filename variable
          final filename = contentDisposition.substring(startPos, endPos);
          // Write file to phone storage
          await File('$dirPath/$filename').writeAsBytes(content[0]);
        }

        //Deleting temp file
        File('$dirPath/temp').delete();

        //File Received Response
        request.response
          ..headers.contentType = ContentType.html
          ..write(kFileReceivedSuccessfully);
      }

      //closing the request
      await request.response.close();
    });
  }

  getIpAddress() {
    // Returns the Gateway ip Address with port
    return _ipAddress;
  }
}
