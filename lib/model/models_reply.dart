class Reply {
  int rNum;
  String rContent;
  String rNickName;
  int rDepth;
  int rbNum;
  DateTime? rSDate;
  DateTime? rUDate;
  DateTime? rDDate;

  Reply({
    required this.rNum,
    required this.rContent,
    required this.rNickName,
    required this.rDepth,
    required this.rbNum,
    required this.rSDate,
    required this.rUDate,
    required this.rDDate,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    print(json);
    return Reply(
      rNum: json['r_num'],
      rContent: json['r_content'],
      rNickName: json['r_nickName'],
      rDepth: json['r_depth'],
      rbNum: json['rb_num'],
      rSDate: json['r_sdate'] != null ? DateTime.parse(json['r_sdate']) : null,
      rUDate: json['r_udate'] != null ? DateTime.parse(json['r_udate']) : null,
      rDDate: json['r_ddate'] != null ? DateTime.parse(json['r_ddate']) : null,
    );
  }
}
