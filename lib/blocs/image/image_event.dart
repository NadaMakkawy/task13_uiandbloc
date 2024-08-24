import 'dart:io';

class ImageEvent {}

class SelectImageEvent extends ImageEvent {}

class UploadImageEvent extends ImageEvent {
  final File image;
  UploadImageEvent(this.image);
}

class LoadImageEvent extends ImageEvent {}
