class UserLackyJetModel{
  final String id;
  final String sequenceId;
  final String userId;
  const UserLackyJetModel(
      {
        required this.sequenceId,
        required this.userId,
        required this.id,
      });

}




class UserLackyJetDataModel{
  final String sequenceId;
  final String userId;
  const UserLackyJetDataModel(
      {
        required this.sequenceId,
        required this.userId,
      });

  factory UserLackyJetDataModel.fromJson(Map<dynamic, dynamic> json) =>
      UserLackyJetDataModel(
        sequenceId: json['sequence_id'].toString(),
        userId: json['user_id'].toString(),
      );
}