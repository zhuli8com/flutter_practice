enum HttpMethod { GET, POST, DELETE }

//https://api.devio.org/uapi/swagger-ui.html#/Test
abstract class BaseRequest {
  var pathParams;
  var useHttps;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if (useHttps == true) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    print("uri:${uri.toString()}");
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = Map();
  BaseRequest addHeader(String k, Object v) {
    params[k] = v.toString();
    return this;
  }
}
