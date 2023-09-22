import 'dart:developer';

import 'package:api_calling/data/models/post_model.dart';
import 'package:api_calling/data/models/repositories/post_repositories.dart';
import 'package:api_calling/presentiation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubits/post_cubit/cubit/post_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PostRepository postRepository = PostRepository();

  List<PostModel> postModels = await postRepository.fetchPosts();
  log(postModels.toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) =>PostCubit (),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
