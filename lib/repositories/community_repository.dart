import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/helpers/global_data.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/model/UserPost.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

abstract class ICommunityRepository {
  Future<List<PostModel>> getPosts(pageNumber, pageSize);
  Future<UserPost> getUserPosts(pageNumber, pageSize,userName);
  Future<List<PostModel>> getMyPosts(pageNumber, pageSize);
  Future likePost(postSerial, liked);
  Future addPost(content, images);
  Future editPost(postSerial, content, images);
  Future deletePost(postSerial);
  Future addComment(content, postSerial);
  Future deleteComment(commentSerial, postSerial);
  Future unLikePost(postSerial);
}

class CommunityRepository extends ICommunityRepository {
  var httpService = getIt<HttpService>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future<List<PostModel>> getPosts(pageNumber, pageSize) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.get(
        'api/community/commPosts?pageNumber=$pageNumber&pageSize=$pageSize',
        headers: httpService.headers);
    print("status code =${response.statusCode}");
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body ?? "Something is wrong");
    }
    var posts =
        (response.body as List).map((e) => PostModel.fromJson(e)).toList();

    return posts;
  }

  @override
  Future<UserPost> getUserPosts(pageNumber, pageSize,userName) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.get(
        'api/community/getUserPosts?pageNumber=$pageNumber&pageSize=$pageSize&username=$userName',
        headers: httpService.headers);
    print("status code = ${response.statusCode}");
    print("response getUserPosts = ${response.body}");
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body ?? "Something is wrong");
    }
    var posts = UserPost.fromJson(response.body);

    return posts;
  }

  @override
  Future<List<PostModel>> getMyPosts(pageNumber, pageSize) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.get(
        'api/community/myPosts?pageNumber=$pageNumber&pageSize=$pageSize',
        headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body?? "Something is wrong");
    }
    print("response my posts = ${response.body}");

    var posts =
        (response.body as List).map((e) => PostModel.fromJson(e)).toList();

    return posts;
  }

//  api/community/like?postSerial=1
  @override
  Future likePost(postSerial, liked) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.post(
        'api/community/like?liked=$liked&postSerial=$postSerial', "",
        headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }

  @override
  Future unLikePost(postSerial) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.delete(
        'api/community/like?postSerial=$postSerial',
        headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }

  @override
  Future addPost(content, images) async {
    Uri uri = Uri.parse("${Api_Url}api/community");
    final request = http.MultipartRequest('POST', uri);
    final token = storage.get(STORAGE_KEYS.token);
    request.headers['Authorization'] = "Bearer $token";
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        String fileName = images![i].path.split('/').last;
        final file = await http.MultipartFile.fromPath(
          'images',
          images[i]!.path,
          filename: fileName,
        );
        request.files.add(file);
      }
    }
    request.fields["content"] = content;

    var response = await request.send();
    return response;
  }

  @override
  Future editPost(postSerial, content, images) async {
    Uri uri = Uri.parse("${Api_Url}api/community/update");
    final request = http.MultipartRequest('POST', uri);
    final token = storage.get(STORAGE_KEYS.token);
    request.headers['Authorization'] = "Bearer $token";
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        String fileName = images![i].path.split('/').last;
        final file = await http.MultipartFile.fromPath(
          'images',
          images[i]!.path,
          filename: fileName,
        );
        request.files.add(file);
      }
    }
    request.fields["postSerial"] = postSerial;
    request.fields["content"] = content;

    var response = await request.send();
    return response;
  }

  @override
  Future deletePost(postSerial) async {
    final response = await httpService.delete(
        'api/community?postSerial=$postSerial',
        headers: httpService.headers);
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }

  @override
  Future addComment(content, postSerial) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.post(
        'api/community/comment?content=$content&postSerial=$postSerial', "",
        headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }

  @override
  Future deleteComment(commentSerial, postSerial) async {
    final response = await httpService.delete(
        'api/community/comment?commentSerial=$commentSerial&postSerial=$postSerial',
        headers: httpService.headers);
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }
}
