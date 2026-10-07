import 'package:http/http.dart' as http;


class AlbumApiService {
  String url = "https://fakestoreapi.com/products";

  Future<String> getResponse() async {
    http.Response json = await http.get(Uri.parse(url));

    if (json.statusCode == 200) {
      return json.body;
    }
    {
      throw "Something went wrong.Please try again!";
    }
  }
}
