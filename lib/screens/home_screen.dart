import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pet_health/screens/image_screen.dart';
import 'dart:convert';
import 'dart:io';

import 'package:pet_health/screens/profile_screen.dart';
import 'package:pet_health/screens/splash_screen.dart';
import 'package:pet_health/view/WebViewScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  String apiData = '';

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await _imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> fetchDataFromAPI() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Parsing data yang sesuai dari respon API
      final username = data['name'];
      setState(() {
        apiData = username;
      });
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ),
            );
          },
          icon: Icon(
            FeatherIcons.arrowLeft,
            color: Color(0xFF818AF9),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.account_circle,
              color: Color(0xFF818AF9),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 22),
            _buildGreetings(),
            SizedBox(height: 17),
            _buildCard(),
            SizedBox(height: 20),
            if (_imageFile != null)
              Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_imageFile!),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Catty Cat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),
            _buildButtonRow(),
            if (apiData.isNotEmpty)
              Text(
                'Data from API: $apiData',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }

  AspectRatio _buildCard() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color(0xFF818AF9),
        ),
        child: Stack(
          children: [
            Image.asset(
              'images/assets/background_card.png',
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Your ",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: Color(0xFFDEE1FE),
                        height: 150 / 100,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Catrine ",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: "will get \nvaccination "),
                        TextSpan(
                          text: "tomorrow \nat 07.00 am!",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildDetailsButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildGreetings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello, Human!',
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          _buildShoppingBagIcon(),
        ],
      ),
    );
  }

  IconButton _buildShoppingBagIcon() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        FeatherIcons.shoppingBag,
        color: Color(0xFF818AF9),
      ),
    );
  }

  Widget _buildDetailsButton() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "See details",
        style: GoogleFonts.manrope(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Row _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WebviewPage(),
              ),
            );
          },
          child: Text('Baca Artikel'),
        ),
        ElevatedButton(
          onPressed: () {
            fetchDataFromAPI();
          },
          child: Text('Data Hewan'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageView (),
              ),
            );
          },
          child: Text('Tambah Foto Hewan'),
        ),
      ],
    );
    
  }
  
}
