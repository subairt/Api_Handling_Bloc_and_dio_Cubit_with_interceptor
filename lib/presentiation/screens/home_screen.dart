import 'package:api_calling/data/models/post_model.dart';
import 'package:api_calling/logic/cubits/post_cubit/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('API_Calling'),
      ),
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
          if (state is PostErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor:Colors.red,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }, builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostLoadedState) {
            return buildListPostview(state.posts);
          }

          return const Center(
            child: Text('An error occured'),
          );
        }),
      ),
    );
  }

  ListView buildListPostview(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];

        return ListTile(
          title: Text(post.title.toString()),
          subtitle: Text(post.toString()),
        );
      },
    );
  }
}
