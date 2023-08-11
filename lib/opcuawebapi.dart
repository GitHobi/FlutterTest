import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'dart:async';

class OpcUaWebApi {
  String host = "10.43.61.156";
  int port = 8084;
  String basePath = "/api/1.0/opcua";

  int monitoredItemHandle = 0;

  Map<int, Function(int, dynamic)> callbacks = {};

  Cookie? cookie;
  String sessionId = "";
  late Timer timer;

  late IOWebSocketChannel channel;

  void Function(int, dynamic)? dataUpdateCallback;

  OpcUaWebApi(this.host, int port, String basePath);

  void _processIncomingData(String message) {
    //print ( "$message");
    var jsonData = jsonDecode(message);
    if (jsonData.containsKey('DataNotifications')) {
      List<dynamic> data = jsonData['DataNotifications'];
      for (var item in data) {
        var clientHandle = item["clientHandle"];
        if (callbacks.containsKey(clientHandle)) {
          callbacks[clientHandle]!(clientHandle, item["value"]);
        } else {
          if (dataUpdateCallback != null) {
            dataUpdateCallback!(clientHandle, item["value"]);
          }
        }
      }
    } else {
      print("unkonwn data: $message");
    }
  }

  Future<void> connectWs() async {
    var webSocketUrl = "ws://$host:$port/api/1.0/pushchannel";
    channel = IOWebSocketChannel.connect(webSocketUrl,
        headers: {'Cookie': 'ClientId=${cookie!.value}'});

    channel.stream.listen((message) {
      //print('Received message from WebSocket: $message');
      _processIncomingData(message);
      // Handle WebSocket messages here
    });
  }

  Future<void> openSession() async {
    print("Connecting to $host:$port/$basePath");

    final url = Uri.http('$host:$port', '/api/1.0/auth');

    HttpClient client = HttpClient();
    HttpClientRequest clientRequest = await client.getUrl(url);
    HttpClientResponse response = await clientRequest.close();

    if (response.statusCode == 204) {
      //print("${response.cookies.first.name} = ${response.cookies.first.value}");
      cookie = response.cookies
          .firstWhere((element) => (element.name == "ClientId"));

      final url3 = Uri.http('$host:$port', '$basePath/sessions');
      var jsdata = {
        "url": "opc.tcp://10.43.61.156:4840",
        "userIdentityToken": {"username": "Anonymous", "password": ""},
        "timeout": 0
      };
      var data = jsonEncode(jsdata);

      String body = await _doPostReqeust(url3, data);
      Map<String, dynamic> sessionInfo = jsonDecode(body);
      sessionId = sessionInfo.entries
          .firstWhere((element) => element.key.toLowerCase() == "id")
          .value;

      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        ping();
      });

      var webSocketUrl = 'ws://$host:$port/api/1.0/pushchannel';
      channel = IOWebSocketChannel.connect(webSocketUrl,
          headers: {'Cookie': 'ClientId=${cookie!.value}'});

      channel.stream.listen((message) {
        //print('Received message from WebSocket: $message');
        _processIncomingData(message);
        // Handle WebSocket messages here
      });
    } else {
      throw Exception("Could not open session");
    }
  }

  void shutdown() {
    timer.cancel();
    channel.sink.close();
  }

  Future<void> ping() async {
    Uri u = Uri(host: host, port: port, scheme: "http", path: "/api/1.0/ping");
    await _doGetRequest(u);
  }

  Future<void> writeIntValue(String nodeId, int value) async {
    String nodeAttribute = "Value";
    Uri u = _buildUri(
        "$basePath/sessions/$sessionId/nodes/${Uri.encodeComponent(nodeId)}/attributes/$nodeAttribute");
    var jsdata = {"value": value};
    var data = jsonEncode(jsdata);
    await _doPutRequest(u, data);
    return;
  }

  Future<int> createSubscription() async {
    Uri u = _buildUri("$basePath/sessions/$sessionId/subscriptions");
    var jsdata = {"publishingInterval": 100, "publishingEnabled": true};
    var data = jsonEncode(jsdata);
    var body = await _doPostReqeust(u, data);
    //print(body);
    var d = jsonDecode(body);
    return d['subscriptionId'];
  }

  Future<dynamic> monitorItems(
      String nodeId, int subscriptionId, int? clientHandle) async {
    if (clientHandle == null) {
      clientHandle = monitoredItemHandle;
      monitoredItemHandle++;
    }

    Uri u = _buildUri(
        "$basePath/sessions/$sessionId/subscriptions/$subscriptionId/monitoredItems");
    var jsdata = {
      "itemToMonitor": {"nodeId": "$nodeId", "attribute": "value"},
      "monitoringParameters": {
        "samplingInterval": 100,
        "queueSize": "1",
        "clientHandle": clientHandle
      },
      "timestampsToReturn": "Neither",
      "monitoringMode": "reporting"
    };
    var data = jsonEncode(jsdata);
    var body = await _doPostReqeust(u, data);
    //print(body);
    var d = jsonDecode(body);
    var monitoredItemId = d['monitoredItemId'];
    return jsonDecode(
        '{"monitoredItemId": $monitoredItemId, "clientHandle": $clientHandle}');
  }

  Future<dynamic> readValue(String nodeId) async {
    String body = await _readValue(nodeId);
    var data = jsonDecode(body);
    return data['value'];
  }

  Future<String> _readValue(String nodeId) async {
    String nodeAttribute = "value";
    Uri u = _buildUri(
        "$basePath/sessions/$sessionId/nodes/${Uri.encodeComponent(nodeId)}/attributes/$nodeAttribute");
    String body = await _doGetRequest(u);
    return body;
  }

  Future<int> resolveNamespace(String namespace) async {
    String ns = Uri.encodeComponent(namespace);
    Uri u = _buildUri("$basePath/sessions/$sessionId/namespaces/$ns");
    String body = await _doGetRequest(u);
    var data = jsonDecode(body);
    return data["index"];
  }

  Uri _buildUri(String path) {
    return Uri(host: host, port: port, scheme: "http", path: path);
  }

  Future<String> _doPutRequest(Uri uri, String data) async {
    if (cookie == null) {
      throw Exception("no session");
    }
    //print("PUT ${uri.toString()}");
    final client = HttpClient();
    final request = await client.putUrl(uri);
    request.cookies.add(cookie!);

    request.headers.contentType = ContentType.json;
    request.write(data);

    final resp = await request.close();
    //print(resp.statusCode);
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final body = await resp.transform(utf8.decoder).join();
      //print(body);
      return body;
    } else {
      final body = await resp.transform(utf8.decoder).join();
      throw Exception("Fehler - $body");
    }
  }

  Future<String> _doPostReqeust(Uri uri, String data) async {
    if (cookie == null) {
      throw Exception("no session");
    }
    //print("POST ${uri.toString()}");
    final client = HttpClient();
    final request = await client.postUrl(uri);
    request.cookies.add(cookie!);

    request.headers.contentType = ContentType.json;
    request.write(data);

    final resp = await request.close();
    //print(resp.statusCode);
    if (resp.statusCode == 201 || resp.statusCode == 201) {
      final body = await resp.transform(utf8.decoder).join();
      //print(body);
      return body;
    } else {
      final body = await resp.transform(utf8.decoder).join();
      throw Exception("Fehler - $body");
    }
  }

  Future<String> _doGetRequest(Uri uri) async {
    //print("GET ${uri.toString()}");
    if (cookie == null) {
      throw Exception("no session");
    }
    final client = HttpClient();
    final request = await client.getUrl(uri);
    request.cookies.add(cookie!);
    final resp = await request.close();

    if (resp.statusCode == 200 || resp.statusCode == 204) {
      final body = await resp.transform(utf8.decoder).join();
      return body;
    } else {
      final body = await resp.transform(utf8.decoder).join();
      throw Exception("Fehler - $body");
    }
  }
}
