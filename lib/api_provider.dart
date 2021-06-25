import 'package:dio/dio.dart'as DioPackage;

class ApiProvider {
  DioPackage.Dio dio = DioPackage.Dio();
  static ApiProvider _curr;

  static ApiProvider get current {
    //if (_curr == null) {
    _curr = new ApiProvider();
    //}
    return _curr;
  }

  String html = "https://";

  Future<DioPackage.Response> getContact(
      String user
      ) async{
    DioPackage.Response response;

    response = await dio.get(html+"reqres.in/api/users/$user",
    );

    print(response);
    return response;

  }

  Future<DioPackage.Response> createContact(
      String firstname,
      String lastname,
      String job,
      String phonenumber,
      String email,
      String web,
      ) async{
    DioPackage.Response response;

    response = await dio.post(html+"reqres.in/api/users/",
    data:{
          "firstname" : firstname ,
          "lastname" : lastname,
          "job" : job,
          "lastname" : lastname,
          "lastname" : lastname,
          "lastname" : lastname,
        }
    );

    print(response);
    return response;

  }

  Future<DioPackage.Response> register(
      String email,
      String password,
      ) async{
    DioPackage.Response response;

    response = await dio.post(html+"reqres.in/api/register",
        data:{
          "email" : "eve.holt@reqres.in" ,
          "password" : "pistol",
        }
    );

    print(response);
    return response;
  }

  Future<DioPackage.Response> login(
      String email,
      String password,
      ) async{
    DioPackage.Response response;

    response = await dio.post(html+"reqres.in/api/login",
        data:{
          "email" : "eve.holt@reqres.in" ,
          "password" : "cityslicka",
        }
    );

    print(response);
    return response;
  }
}