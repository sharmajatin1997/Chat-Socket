class ChatModel {
  int? id;
  int? userid;
  int? user2id;
  int? groupId;
  int? groupType;
  int? deleteId;
  int? lastMsgId;
  int? typing;
  int? deletedId;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? lastMessage;
  String? email;
  String? phone;
  String? name;
  String? groupcreatedbyimage;
  String? groupName;
  String? groupImage;
  int? onlinestatus;
  String? userImage;
  String? createdAtt;
  int? msgType;
  int? unreadcount;
  int? blockstatus;
  List<TeamMember>? teamMember;

  ChatModel(
      {this.id,
        this.userid,
        this.user2id,
        this.groupId,
        this.groupType,
        this.deleteId,
        this.lastMsgId,
        this.typing,
        this.deletedId,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.lastMessage,
        this.email,
        this.phone,
        this.name,
        this.groupcreatedbyimage,
        this.groupName,
        this.groupImage,
        this.onlinestatus,
        this.userImage,
        this.createdAtt,
        this.msgType,
        this.unreadcount,
        this.blockstatus,
        this.teamMember});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    user2id = json['user2id'];
    groupId = json['group_id'];
    groupType = json['group_type'];
    deleteId = json['delete_id'];
    lastMsgId = json['last_msg_id'];
    typing = json['typing'];
    deletedId = json['deleted_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['user_id'];
    lastMessage = json['lastMessage'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    groupcreatedbyimage = json['groupcreatedbyimage'];
    groupName = json['group_name'];
    groupImage = json['group_image'];
    onlinestatus = json['onlinestatus'];
    userImage = json['userImage'];
    createdAtt = json['created_att'];
    msgType = json['msg_type'];
    unreadcount = json['unreadcount'];
    blockstatus = json['blockstatus'];
    if (json['team_member'] != null) {
      teamMember = <TeamMember>[];
      json['team_member'].forEach((v) {
        teamMember!.add(new TeamMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['user2id'] = this.user2id;
    data['group_id'] = this.groupId;
    data['group_type'] = this.groupType;
    data['delete_id'] = this.deleteId;
    data['last_msg_id'] = this.lastMsgId;
    data['typing'] = this.typing;
    data['deleted_id'] = this.deletedId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['lastMessage'] = this.lastMessage;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['groupcreatedbyimage'] = this.groupcreatedbyimage;
    data['group_name'] = this.groupName;
    data['group_image'] = this.groupImage;
    data['onlinestatus'] = this.onlinestatus;
    data['userImage'] = this.userImage;
    data['created_att'] = this.createdAtt;
    data['msg_type'] = this.msgType;
    data['unreadcount'] = this.unreadcount;
    data['blockstatus'] = this.blockstatus;
    if (this.teamMember != null) {
      data['team_member'] = this.teamMember!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMember {
  int? id;
  int? groupUserId;
  int? groupbyid;
  int? groupId;
  int? groupType;
  bool? admin;
  int? amount;
  String? createdAt;
  String? updatedAt;
  String? profileImage;
  String? name;

  TeamMember(
      {this.id,
        this.groupUserId,
        this.groupbyid,
        this.groupId,
        this.groupType,
        this.admin,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.profileImage,
        this.name});

  TeamMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupUserId = json['group_user_id'];
    groupbyid = json['groupbyid'];
    groupId = json['group_id'];
    groupType = json['group_type'];
    admin = json['admin'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profileImage = json['profile_image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_user_id'] = this.groupUserId;
    data['groupbyid'] = this.groupbyid;
    data['group_id'] = this.groupId;
    data['group_type'] = this.groupType;
    data['admin'] = this.admin;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profile_image'] = this.profileImage;
    data['name'] = this.name;
    return data;
  }
}