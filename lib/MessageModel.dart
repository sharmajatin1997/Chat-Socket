class MessageModel {
  num? id;
  num? userid;
  num? user2Id;
  num? messageType;
  String? senderName;
  String? message;
  String? created_at;
  num? senderID;
  String? senderImage;
  String? receiverName;
  num? receiverId;
  String? receiverImage;
  String? image;
  num? msgType;
  num? createdAt;

  MessageModel(
      {this.id,
        this.userid,
        this.user2Id,
        this.messageType,
        this.senderName,
        this.message,
        this.created_at,
        this.senderID,
        this.senderImage,
        this.receiverName,
        this.receiverId,
        this.receiverImage,
        this.image,
        this.msgType,
        this.createdAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    user2Id = json['user2Id'];
    messageType = json['messageType'];
    senderName = json['SenderName'];
    message = json['message'];
    created_at = json['created_at'];
    senderID = json['SenderID'];
    senderImage = json['SenderImage'];
    receiverName = json['ReceiverName'];
    receiverId = json['ReceiverId'];
    receiverImage = json['ReceiverImage'];
    image = json['image'];
    msgType = json['msg_type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['user2Id'] = this.user2Id;
    data['messageType'] = this.messageType;
    data['SenderName'] = this.senderName;
    data['message'] = this.message;
    data['created_at'] = this.created_at;
    data['SenderID'] = this.senderID;
    data['SenderImage'] = this.senderImage;
    data['ReceiverName'] = this.receiverName;
    data['ReceiverId'] = this.receiverId;
    data['ReceiverImage'] = this.receiverImage;
    data['image'] = this.image;
    data['msg_type'] = this.msgType;
    data['createdAt'] = this.createdAt;
    return data;
  }
}