import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController nameController = TextEditingController(
    text: 'Chirag Ferwani',
  );
  final TextEditingController usernameController = TextEditingController(
    text: '@chirag27',
  );
  final TextEditingController linkedinController = TextEditingController(
    text: 'chiragferwani',
  );
  final TextEditingController githubController = TextEditingController(
    text: '@chiragferwani27',
  );
  final TextEditingController webController = TextEditingController(
    text: 'chiragferwani.vercel.app',
  );
  final TextEditingController instaController = TextEditingController(
    text: '@chirag27',
  );
  final TextEditingController twitterController = TextEditingController(
    text: '@chiragf27',
  );

  bool editingName = false;
  bool editingUsername = false;
  bool editingLinkedin = false;
  bool editingGithub = false;
  bool editingWeb = false;
  bool editingInsta = false;
  bool editingTwitter = false;

  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        _profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage('assets/images/profile.jpg')
                                as ImageProvider,
                    radius: 56,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(Icons.camera_alt, size: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _buildEditableField(
                controller: nameController,
                label: 'Name',
                editing: editingName,
                onEdit: () => setState(() => editingName = true),
                onSave: () => setState(() => editingName = false),
              ),
              _buildEditableField(
                controller: usernameController,
                label: 'Username',
                editing: editingUsername,
                onEdit: () => setState(() => editingUsername = true),
                onSave: () => setState(() => editingUsername = false),
              ),
              _buildSocialField(
                FontAwesomeIcons.linkedin,
                linkedinController,
                'LinkedIn',
                editingLinkedin,
                () => setState(() => editingLinkedin = true),
                () => setState(() => editingLinkedin = false),
              ),
              _buildSocialField(
                FontAwesomeIcons.github,
                githubController,
                'GitHub',
                editingGithub,
                () => setState(() => editingGithub = true),
                () => setState(() => editingGithub = false),
              ),
              _buildSocialField(
                Icons.language,
                webController,
                'Website',
                editingWeb,
                () => setState(() => editingWeb = true),
                () => setState(() => editingWeb = false),
              ),
              _buildSocialField(
                FontAwesomeIcons.instagram,
                instaController,
                'Instagram',
                editingInsta,
                () => setState(() => editingInsta = true),
                () => setState(() => editingInsta = false),
              ),
              _buildSocialField(
                FontAwesomeIcons.twitter,
                twitterController,
                'Twitter',
                editingTwitter,
                () => setState(() => editingTwitter = true),
                () => setState(() => editingTwitter = false),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  'SAVE',
                  style: TextStyle(
                    fontFamily: 'boldfont',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 10,
                  ),
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required bool editing,
    required VoidCallback onEdit,
    required VoidCallback onSave,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 1.2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                label,
                style: const TextStyle(fontFamily: 'boldfont', fontSize: 15),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                enabled: editing,
                style: const TextStyle(fontSize: 15, fontFamily: 'boldfont'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            IconButton(
              icon: Icon(editing ? Icons.check : Icons.edit, size: 18),
              onPressed: editing ? onSave : onEdit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialField(
    IconData icon,
    TextEditingController controller,
    String label,
    bool editing,
    VoidCallback onEdit,
    VoidCallback onSave,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 1.2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(icon, size: 22),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                enabled: editing,
                style: const TextStyle(fontSize: 15, fontFamily: 'boldfont'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            IconButton(
              icon: Icon(editing ? Icons.check : Icons.edit, size: 18),
              onPressed: editing ? onSave : onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
