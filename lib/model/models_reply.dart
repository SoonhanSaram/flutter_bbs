class Reply {
  int rNum;
  String rContent;
  String rNickName;
  int rDepth;
  int rbNum;
  DateTime bSDate;
  DateTime? bUDate;
  DateTime? bDDate;

  Reply({
    required this.rNum,
    required this.rContent,
    required this.rNickName,
    required this.rDepth,
    required this.rbNum,
    required this.bSDate,
    this.bUDate,
    this.bDDate,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      rNum: json['r_num'],
      rContent: json['r_content'],
      rNickName: json['r_nickName'],
      rDepth: json['r_depth'],
      rbNum: json['rb_num'],
      bSDate: DateTime.parse(json['b_sdate']) ?? DateTime.now(),
    );
  }
}
