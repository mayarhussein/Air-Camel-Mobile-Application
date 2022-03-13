import 'dart:io';

import 'package:flutter/material.dart';
import 'package:air_camel/providers/client_data.dart';
import 'package:air_camel/widgets/appbar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key}) : super(key: key);

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  var client = ClientData.myClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: const Text(
                "Upload a photo of yourself:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                      setState(
                          () => client = client.copy(imagePath: newImage.path));
                    },
                    child: Image.network(client.image),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                             shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                              ),
                      onPressed: () {},
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
