import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:weatherapp/models/User.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late User currentUser;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _visible = true;
      });
    });
  }

  Future<void> _changeImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName =
          '${currentUser.name}${path.extension(image.path)}';
      final String savedImagePath =
          path.join(appDir.path, 'assets/images', fileName);

      // Create the assets/images directory if it doesn't exist
      final Directory imageDir =
          Directory(path.join(appDir.path, 'assets/images'));
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }
      final File newImage = await File(image.path).copy(savedImagePath);

      setState(() {
        currentUser.imageAsset = newImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: Duration(milliseconds: 2000),
      child: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            GestureDetector(
              onLongPress: _changeImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: currentUser.imageAsset != ''
                    ? FileImage(File(currentUser.imageAsset!))
                    : AssetImage('assets/images/avatar.jpg') as ImageProvider,
              ),
            ),
            SizedBox(height: 16),
            Text(
              currentUser.name ?? 'Name not provided',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              currentUser.email ?? 'Email not provided',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            UserInfoTile(
                icon: Icons.phone,
                info: currentUser.phone ?? 'Phone not provided'),
            UserInfoTile(
                icon: Icons.location_on,
                info: currentUser.address ?? 'Address not provided'),
            UserInfoTile(
                icon: Icons.location_city,
                info: currentUser.city ?? 'no city provided'),
            UserInfoTile(
                icon: Icons.location_city,
                info: currentUser.state ?? 'no state provided'),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.edit),
              label: Text('Update Profile'),
              onPressed: () {},
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              label: Text('Change Image'),
              onPressed: _changeImage,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  final IconData icon;
  final String info;

  UserInfoTile({required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(info),
    );
  }
}
