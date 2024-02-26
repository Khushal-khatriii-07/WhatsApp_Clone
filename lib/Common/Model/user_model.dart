class UserModel {
  final String userName;
  final String userId;
  final String profileImageUrl;
  final bool active;
  final int lastSeen;
  final String phoneNumber;
  final List<String> groupId;

  UserModel(
      {required this.userName,
        required this.lastSeen,
      required this.userId,
      required this.profileImageUrl,
      required this.active,
      required this.phoneNumber,
      required this.groupId});

  Map<String, dynamic> toMap(){
    return{
      'userName' : userName,
      'userId' : userId,
      'lastSeen' : lastSeen,
      'profileImageUrl' : profileImageUrl,
      'active' : active,
      'phoneNumber': phoneNumber,
      'groupId' : groupId
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        userName: map['userName'] ?? '',
        userId: map['userId'] ?? '',
        profileImageUrl: map['profileImageUrl'] ?? '',
        active: map['active'] ?? false,
        phoneNumber: map['phoneNumber']?? '',
        groupId: List<String>.from(map['groupId']),
        lastSeen: map['lastSeen'] ?? 0,
    );
  }
}
