// class ImageState {
//   final String imageUrl;

//   ImageState({this.imageUrl = ''});

//   ImageState copyWith({String? imageUrl}) {
//     return ImageState(imageUrl: imageUrl ?? this.imageUrl);
//   }
// }
class ImageState {
  final String imagePath;

  ImageState({this.imagePath = ''});

  ImageState copyWith({String? imagePath}) {
    return ImageState(imagePath: imagePath ?? this.imagePath);
  }
}
