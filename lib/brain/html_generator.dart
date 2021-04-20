import 'dart:io';
import 'package:sharile_v2/constants/web_static_data.dart';

class HtmlGenerator {
  String _indexHTML;

  // Generating index.html to serve files for sending
  // send index.html
  generateSendIndexHtml({Map<String, String> filePaths}) {
    String divBlocks = ''; //div for all files
    List<String> allNames = filePaths.values.toList(); // List of all file names
    List<String> allPaths = filePaths.keys.toList(); // List of all paths
    for (int i = 0; i < filePaths.length; i++) {
      String filePath = allPaths[i];
      String fileName = allNames[i];
      divBlocks +=
          '<div class="main"><a href="$filePath" download>$fileName</a></div>';
    }
    divBlocks = '<div class="container">$divBlocks</div>'; // creating main div

    _indexHTML = ''' 
            $kSendFileIndexPageHTMLTillHeadAndStyleTag
              <body>$divBlocks</body>
            </html>
        ''';

//    return _indexHTML;
  }

  //Writing index.html file in external storage directory
  writeIndexHTML({String path}) {
    File('$path/index.html').writeAsStringSync(_indexHTML);
  }

  // Generating index.html for uploading files
  // receive index.html
  generateReceiveIndexHtml() {
    String indexHTML = kReceiveFileIndexPageHTML;
    return indexHTML;
  }

  generateReceiveIndexCSS() {
    String appCSS = kReceiveFileIndexPageCSS;
    return appCSS;
  }
}
