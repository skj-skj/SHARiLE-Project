//Receive File Index Page Only HTML Data
String kReceiveFileIndexPageHTML = '''
      <!DOCTYPE html>
      <html lang="en">
         <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>SHARiLE File Upload</title>
            <link rel="stylesheet" href="./app.css">
         </head>
         <body>
            <div class="mainBody row">
               <form method="post" action="/upload" enctype="multipart/form-data">
                  <div class="labelDiv">
                     <label for="myFile" class="myFileLabel">Select a file:</label>
                  </div>
                  <div class="fileInputDiv">
                     <input id="myFile" type="file" name="upload"/>
                  </div>
                  <!-- <br/><br/> -->
                  <button type="submit" class="uploadButton">Upload File</button>
               </form>
            </div>
         </body>
      </html>
''';

// Receive File Index Page Only HTML's CSS Style
String kReceiveFileIndexPageCSS = '''
      body {
        background-color: #55b9f3
      }
      
      div.mainBody {
        text-align: center
      }
      
      button.uploadButton {
        font-size: 18px;
        border: 0;
        width: 10em;
        height: 5em;
        border-radius: 70px;
        background: #55b9f3;
        box-shadow: 18px 18px 36px #489dcf, -18px -18px 36px #62d5ff
      }
      
      label.myFileLabel {
        color: #000;
        font-size: 18px;
        margin: 20px 0
      }
      
      div.labelDiv {
        display: inline-block;
        vertical-align: middle;
        text-align: center;
        width: 15em;
        padding: 10px;
        margin: 20px;
        border-radius: 70px;
        background: #55b9f3;
        box-shadow: 18px 18px 36px #489dcf, -18px -18px 36px #62d5ff
      }
      
      input#myFile::-webkit-file-upload-button {
        background-color: #55b9f3;
        padding: 15px;
        font-size: 18px;
        border: 0;
        border-radius: 70px;
        box-shadow: inset 7px 7px 0 #489dcf, inset -7px -7px 0 #62d5ff
      }
      
      input#myFile {
        font-size: 18px
      }
      
      div.fileInputDiv {
        font-size: 18px;
        padding: 10px 0;
        margin: 20px 30%;
        border-radius: 70px;
        background: #55b9f3;
        box-shadow: inset 18px 18px 36px #489dcf, inset -18px -18px 36px #62d5ff
      }
''';

String kSendFileIndexPageHTMLTillHeadAndStyleTag = '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>SHARile File Sharing Solution</title>
</head>

<style>
    html {
        margin: 0;
        padding: 0
    }

    body {
        background: linear-gradient(to left, #8942a8, #ba382f);
        font-family: Baloo;
        margin: 0
    }

    .container {
        margin-top: 200px;
        margin-left: 600px
    }

    .container .main a:link,
    a:visited {
        background: linear-gradient(to left, #8942a8, #ba382f);
        color: #fff;
        padding: 14px 25px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        margin: 10px;
        border-radius: 16px;
        box-shadow: 5px 10px #888;
        font-style: italic
    }

    .animation-area {
        width: 100%;
        height: 100vh
    }

    .box-area {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden
    }

    .box-area li {
        position: absolute;
        display: block;
        list-style: none;
        width: 25px;
        height: 25px;
        background: rgba(255, 255, 255, .2);
        animation: animate 20s linear infinite;
        bottom: -150px
    }

    .box-area li:nth-child(1) {
        left: 86%;
        width: 80px;
        height: 80px;
        animation-delay: 0s
    }

    .box-area li:nth-child(2) {
        left: 12%;
        width: 30px;
        height: 30px;
        animation-delay: 1.5s;
        animation-duration: 10s
    }

    .box-area li:nth-child(3) {
        left: 70%;
        width: 100px;
        height: 100px;
        animation-delay: 5.5s
    }

    .box-area li:nth-child(4) {
        left: 42%;
        width: 150px;
        height: 150px;
        animation-delay: 0s;
        animation-duration: 15s
    }

    .box-area li:nth-child(5) {
        left: 65%;
        width: 40px;
        height: 40px;
        animation-delay: 0s
    }

    .box-area li:nth-child(6) {
        left: 15%;
        width: 110px;
        height: 110px;
        animation-delay: 3.5s
    }

    @keyframes animate {
        0% {
            transform: translateY(0) rotate(0);
            opacity: 1
        }

        100% {
            transform: translateY(-800px) rotate(360deg);
            opacity: 0
        }
    }
</style>
''';

String kSendFileIndexPageAnimationDiv = '''
    <div class="animation-area">
        <ul class="box-area">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
''';

//''' Old Legacy ReceiveFile Index Page 1
//          <html>
//            <head>
//              <title>SHARiLE File Upload</title>
//            </head>
//            <body>
//              <form method="post" action="/upload" enctype="multipart/form-data">
//                <input type="file" name="upload" /><br/><br/>
//                <button type="submit">Upload File</button>
//              </form>
//            </body>
//          </html>
//          '''

/* Old Legacy ReceiveFile Index Page 2
<!DOCTYPE html>
          <html lang="en">
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>SHARiLE File Upload</title>
              <link rel="stylesheet" href="./app.css">
            </head>
            <body>
              <form method="post" action="/upload" enctype="multipart/form-data">
                <input type="file" name="upload" /><br/><br/>
                <button type="submit">Upload File</button>
              </form>
            </body>
          </html>
*/
