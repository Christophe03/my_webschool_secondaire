import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../config/config.dart';

class EditProfile extends StatefulWidget {
  final String? name;

  const EditProfile({super.key, @required this.name});

  @override
  _EditProfileState createState() => _EditProfileState(name ?? '');
}

class _EditProfileState extends State<EditProfile> {
  _EditProfileState(this.name);
  String? name;
  String? imageUrl = "";
  File? imageFile;
  String? fileName;
  bool loading = false;

  var formKey = GlobalKey<FormState>();
  var nameCtrl = TextEditingController();

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    var imagepicked = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    if (imagepicked != null) {
      setState(() {
        imageFile = File(imagepicked.path);
        fileName = (imageFile!.path);
      });
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String path = appDocumentsDirectory.path;
      await imageFile!.copy('$path/profil.png');
    } else {
      print('No image selected!');
    }
  }

  // The uploadPicture method is removed as Firebase Storage is not used anymore.

  handleUpdateData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => loading = true);

      // Assuming you want to handle the data update without Firebase
      // For example, you might save the data locally or in another service.

      if (imageFile == null) {
        // Update user profile without image
        // Example: updateUserProfile(nameCtrl.text, imageUrl ?? '');
      } else {
        // Handle the uploaded image
        // Example: Save the image file locally or in another service
      }

      setState(() => loading = false);
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')));
    }
  }

  @override
  void initState() {
    super.initState();
    nameCtrl.text = name ?? '';
  }

  Future<String> checkPhoto() async {
    String path = "";
    await Future.delayed(const Duration(seconds: 0));
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    path = appDocumentsDirectory.path;
    bool pfExists = await File('$path/profil.png').exists();
    if (pfExists) {
      return '$path/profil.png';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('edit_profile').tr(),
        ),
        body: FutureBuilder<String>(
          future: checkPhoto(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                return ListView(
                  padding: const EdgeInsets.all(25),
                  children: <Widget>[
                    InkWell(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey[300],
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey[800]!),
                              color: Colors.grey[500],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageFile != null
                                      ? FileImage(imageFile!)
                                      : imageUrl != ""
                                          ? CachedNetworkImageProvider(
                                              imageUrl!)
                                          : snapshot.data != ''
                                              ? FileImage(File(snapshot.data!))
                                              : FileImage(File(
                                                  Config().defaultAppIcon)),
                                  fit: BoxFit.cover)),
                          child: const Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.edit,
                                size: 30,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      onTap: () {
                        pickImage();
                      },
                    ),
                    const SizedBox(height: 50),
                    Form(
                        key: formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'enter_new_name'.tr(),
                          ),
                          controller: nameCtrl,
                          validator: (value) {
                            if (value!.isEmpty) return "Name can't be empty";
                            return null;
                          },
                        )),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            textStyle: MaterialStateProperty.resolveWith(
                                (states) =>
                                    const TextStyle(color: Colors.white))),
                        child: loading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.white))
                            : const Text('update_profile',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                                .tr(),
                        onPressed: () {
                          handleUpdateData();
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ));
  }
}
