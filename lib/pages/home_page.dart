import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task13_uiandbloc/utils/color_utilis.dart';

import '../blocs/image/image_bloc.dart';
import '../blocs/image/image_event.dart';
import '../blocs/image/image_state.dart';
import '../widgets/categories_widget.dart';
import '../widgets/courses_widget.dart';
import '../widgets/label_widget.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ImageBloc>().add(LoadImageEvent());
    return BlocProvider(
      create: (_) => ImageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      if (state.imagePath.isNotEmpty) {
                        context
                            .read<ImageBloc>()
                            .add(UploadImageEvent(File(state.imagePath)));
                      } else {
                        context.read<ImageBloc>().add(SelectImageEvent());
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: ColorUtility.gray,
                      backgroundImage: state.imagePath.isNotEmpty
                          ? FileImage(File(state.imagePath))
                          : const AssetImage('assets/images/placeholder.png'),
                      radius: 25,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                  'Welcome Back! ${FirebaseAuth.instance.currentUser?.displayName}'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                LabelWidget(
                  name: 'Categories',
                  onSeeAllClicked: () {},
                ),
                const CategoriesWidget(),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Rated Courses',
                  onSeeAllClicked: () {},
                ),
                const CoursesWidget(
                  rankValue: 'top rated',
                ),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Seller Courses',
                  onSeeAllClicked: () {},
                ),
                const CoursesWidget(
                  rankValue: 'top seller',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
