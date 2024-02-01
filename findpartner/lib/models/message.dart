import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findpartner/models/enum/message_type.dart';

class Message {
  String? content;
  String? senderUid;
  String? messageId;
  MessageType? type;
  Timestamp? time;

  Message({this.content, this.senderUid, this.messageId, this.type, this.time});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderUid = json['senderUid'];
    messageId = json['messageId'];
    if (json['type'] == 'text') {
      type = MessageType.TEXT;
    } else if (json['type'] == 'image') {
      type = MessageType.IMAGE;
    } else if (json['type'] == 'audio') {
      type = MessageType.AUDIO;
    } else if (json['type'] == 'video') {
      type = MessageType.VIDEO;
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['senderUid'] = this.senderUid;
    data['messageId'] = this.messageId;
    if (this.type == MessageType.TEXT) {
      data['type'] = 'text';
    } else if (this.type == MessageType.IMAGE) {
      data['type'] = 'image';
    } else if (this.type == MessageType.AUDIO) {
      data['type'] = 'audio';
    } else if (this.type == MessageType.VIDEO) {
      data['type'] = 'video';
    }
    data['time'] = this.time;
    return data;
  }
}
