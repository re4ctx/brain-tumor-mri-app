// ignore_for_file: unused_field

import 'dart:io';

import 'package:brain_tumor_mri/details/details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _image;
  List? _output;
  final picker = ImagePicker();

  void initState() {
    super.initState();
    Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  void classifyImage() async {
    var output = await Tflite.runModelOnImage(
      path: _image!.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output!;
    });
  }

  void chooseImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage();
  }

  void cameraRoll() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff222831),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pendeteksi Tumor Otak',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    color: Color(0xff00ADB5)),
              ),
              SizedBox(height: 10),
              Text(
                'Upload atau Ambil Gambar hasil MRI otak.',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white),
              ),
              SizedBox(height: 50),
              Container(
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 250,
                      )
                    : Image.asset(
                        'assets/brain.png',
                        width: 250,
                        height: 250,
                      ),
              ),
              if (_output != null)
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Jenis Tumor : ${_output![0]["label"]} (${_output![0]["confidence"]})',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff00ADB5)), // Ubah warna latar belakang
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Ubah warna teks
  ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(image: _image!, label: '${_output![0]["label"]}', confidence: '${_output![0]["confidence"]}'),
                            ),
                          );
                        },
                        child: Text('Penjelasan'))
                  ],
                ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: cameraRoll,
                        child: Container(
                          child: Image.asset(
                            'assets/camera.png',
                            width: 75,
                            height: 75,
                          ),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: const Color(0xff222831),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff222831),
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                              BoxShadow(
                                color: const Color(0xff393e46),
                                offset: Offset(-2, -2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ambil Foto',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: chooseImage,
                        child: Container(
                          child: Image.asset(
                            'assets/gallery.png',
                            width: 75,
                            height: 75,
                          ),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: const Color(0xff222831),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff222831),
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                              BoxShadow(
                                color: const Color(0xff393e46),
                                offset: Offset(-2, -2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ambil dari Galeri',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
