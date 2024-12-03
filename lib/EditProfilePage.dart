import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'entity/user.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  File? _profileImage; 
  final ImagePicker _picker = ImagePicker(); 

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
    weightController = TextEditingController(
        text: widget.user.weight?.toStringAsFixed(1) ?? "");
    heightController = TextEditingController(
        text: widget.user.height?.toStringAsFixed(1) ?? "");
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  // Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // Bisa menggunakan gallery atau kamera
    );
    if (image != null) {
      setState(() {
        _profileImage = File(image.path); // Menyimpan gambar ke dalam file
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan foto profil jika ada
              Center(
                child: GestureDetector(
                  onTap: _pickImage, // Menambahkan gesture untuk memilih gambar
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/default_profile.png')
                            as ImageProvider,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: "Weight (kg)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(labelText: "Height (cm)"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedUser = User(
                    username: usernameController.text,
                    email: emailController.text,
                    birthdate: widget.user.birthdate,
                    gender: widget.user.gender,
                    password: widget.user.password,
                    weight: double.tryParse(weightController.text),
                    height: double.tryParse(heightController.text),
                  );

                  Navigator.pop(context, updatedUser);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
