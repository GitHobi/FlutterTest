import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:web_socket_channel/io.dart';

class DataBinding {
  Function? _callback_setTitle;

  void connectToData() {
    
    final receivePort = ReceivePort();
    Isolate.spawn(myIsolate1, receivePort.sendPort);

    receivePort.listen((message) {
      if ( message is String ) {
      print('Ergebnis vom Isolat: $message');      
      _callback_setTitle! ( message);
      }
      
    });
  }

  void setCallBackSetTitle(Function(String txt) aFn) {
    _callback_setTitle = aFn;
  }
}

void myIsolate1(SendPort sendPort) async {
  print("Isolate1 start");

  final rcvPort = ReceivePort(); // ReceivePort for the spawned isolate.
  sendPort.send(rcvPort.sendPort); // Send the SendPort to the main isolate.
  // Listen to the ReceivePort and calculate the factorial.
  rcvPort.listen((message) {
    print("Isolte1 - received: $message");
    sendPort.send('return $message');
  });

  final channel = IOWebSocketChannel.connect('ws://127.0.0.1:8080');

  // Nachrichten aus dem Websocket empfangen
  channel.stream.listen((message) {
    print('Nachricht vom Server erhalten: $message');
    sendPort.send("$message");
  }, onError: (error) {
    print('Fehler in der Websocket-Verbindung: $error');
  }, onDone: () {
    print('Websocket-Verbindung geschlossen!');
  });
}
