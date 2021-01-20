import 'package:flutter/cupertino.dart';

class Tag {
  final String key;
  final String message;

  Tag(this.message, {this.key}) {
    key != null ? print("key:$key ------ data:$message") : print("data:$message");
  }
}




