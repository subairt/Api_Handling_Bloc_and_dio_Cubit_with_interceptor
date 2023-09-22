import 'package:api_calling/data/models/post_model.dart';
import 'package:api_calling/data/models/repositories/post_repositories.dart';
import 'package:bloc/bloc.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()){
    fetchPosts();
  }

  PostRepository postRepository = PostRepository();

  void fetchPosts() async {
    try {
      List<PostModel> posts = await postRepository.fetchPosts();
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }
}
