import 'package:flutter_learn_service/home/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<PostModel>> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=1'));

    if (response.statusCode == 200) {
      return postModelFromJson(response.body);
    } else {
      throw Exception('Datalar gelmedi');
    }
  }
}
