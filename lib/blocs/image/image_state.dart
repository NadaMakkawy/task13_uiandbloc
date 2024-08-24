class ImageState {
  final String imagePath;

  ImageState({this.imagePath = ''});

  ImageState copyWith({String? imagePath}) {
    return ImageState(imagePath: imagePath ?? this.imagePath);
  }
}
