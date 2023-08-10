import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_share/social_share.dart';
import 'package:tinder_clone/theme/colors.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopUpSharing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return new AlertDialog(
      title: const Text('Choisi ton reseaux:'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram),
                onPressed: () async {
                  Directory tempDir = await getTemporaryDirectory();
                  String tempPath = tempDir.path;
                  File file = File(tempDir.path + '/img_1.jpeg');
                  final byteData = await rootBundle.load('assets/images/img_1.jpeg');
                  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                  await SocialShare.shareInstagramStory(file.path);
                  Navigator.of(context).pop();
                },
              ),
              new IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook),
                onPressed: () async {
                  Directory tempDir = await getTemporaryDirectory();
                  String tempPath = tempDir.path;
                  File file = File(tempDir.path + '/img_1.jpeg');
                  final byteData = await rootBundle.load('assets/images/img_1.jpeg');
                  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                  await SocialShare.shareFacebookStory(
                    file.path,
                    "#ffffff",
                    "#000000",
                    "https://google.com",
                    appId: "863975147846629",
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Close'),
        ),
      ],
    );
  }
}
