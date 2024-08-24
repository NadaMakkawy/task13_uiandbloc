import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'image_event.dart';
import 'image_state.dart';

// // class ImageBloc extends Bloc<ImageEvent, ImageState> {
// //   final FirebaseStorage storage = FirebaseStorage.instance;

// //   ImageBloc() : super(ImageState()) {
// //     on<SelectImageEvent>(_onSelectImage);
// //     on<UploadImageEvent>(_onUploadImage);
// //   }

// //   Future<void> _onSelectImage(
// //       SelectImageEvent event, Emitter<ImageState> emit) async {
// //     final picker = ImagePicker();
// //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       final imageFile = File(pickedFile.path);
// //       emit(state.copyWith(imageUrl: imageFile.path));
// //     }
// //   }

// //   Future<void> _onUploadImage(
// //       UploadImageEvent event, Emitter<ImageState> emit) async {
// //     String imageUrl = await uploadImage(event.image);
// //     emit(ImageState(imageUrl: imageUrl));
// //   }

// //   Future<String> uploadImage(File image) async {
// //     Reference ref =
// //         storage.ref().child('images/${DateTime.now().toIso8601String()}');
// //     await ref.putFile(image);
// //     return await ref.getDownloadURL();
// //   }
// // }

// class ImageBloc extends Bloc<ImageEvent, ImageState> {
//   final FirebaseStorage storage = FirebaseStorage.instance;

//   ImageBloc() : super(ImageState()) {
//     on<SelectImageEvent>(_onSelectImage);
//     on<UploadImageEvent>(_onUploadImage);
//     on<LoadImageEvent>(_onLoadImage);
//   }

//   Future<void> _onSelectImage(
//       SelectImageEvent event, Emitter<ImageState> emit) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final imageFile = File(pickedFile.path);

//       emit(state.copyWith(imageUrl: imageFile.path));
//     }
//   }

//   Future<void> _onUploadImage(
//       UploadImageEvent event, Emitter<ImageState> emit) async {
//     String imageUrl = await uploadImage(event.image);
//     await _saveImageUrl(imageUrl);
//     emit(ImageState(imageUrl: imageUrl));
//   }

//   Future<void> _onLoadImage(
//       LoadImageEvent event, Emitter<ImageState> emit) async {
//     final imageUrl = await _loadImageUrl();
//     emit(ImageState(imageUrl: imageUrl));
//   }

//   Future<String> uploadImage(File image) async {
//     Reference ref =
//         storage.ref().child('images/${DateTime.now().toIso8601String()}');
//     await ref.putFile(image);
//     return await ref.getDownloadURL();
//   }

//   Future<void> _saveImageUrl(String url) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('imageUrl', url);
//   }

//   Future<String> _loadImageUrl() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('imageUrl') ?? '';
//   }
// }

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState()) {
    on<SelectImageEvent>(_onSelectImage);
    on<LoadImageEvent>(_onLoadImage);
  }

  Future<void> _onSelectImage(
      SelectImageEvent event, Emitter<ImageState> emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      await _saveImagePath(imagePath); // Save local path
      emit(state.copyWith(imagePath: imagePath));
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
}
