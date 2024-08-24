import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState()) {
    _loadInitialImage();
    on<UploadImageEvent>(_onUploadImage);
    on<SelectImageEvent>(_onSelectImage);
    on<LoadImageEvent>(_onLoadImage);
  }

  Future<void> _loadInitialImage() async {
    final imagePath = await _loadImagePath();
    emit(state.copyWith(imagePath: imagePath));
  }

  Future<void> _onSelectImage(
      SelectImageEvent event, Emitter<ImageState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      await _saveImagePath(imagePath);
      emit(state.copyWith(imagePath: imagePath));

      add(UploadImageEvent(File(imagePath)));
    }
  }

  Future<void> _onLoadImage(
      LoadImageEvent event, Emitter<ImageState> emit) async {
    final imagePath = await _loadImagePath();
    emit(ImageState(imagePath: imagePath));
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<String> _loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagePath') ?? '';
  }

  Future<void> _onUploadImage(
      UploadImageEvent event, Emitter<ImageState> emit) async {
    try {
      final file = event.image;
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');

      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();

      print('Uploaded image URL: $downloadUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
