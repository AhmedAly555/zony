class CourierStopWindowModel {
  final String? slotCode;
  final String? date;
  final String? fromTime;
  final String? toTime;

  CourierStopWindowModel({
    this.slotCode,
    this.date,
    this.fromTime,
    this.toTime,
  });

  factory CourierStopWindowModel.fromJson(Map<String, dynamic> json) {
    return CourierStopWindowModel(
      slotCode: json['slot_code'],
      date: json['date'],
      fromTime: json['from_time'],
      toTime: json['to_time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'slot_code': slotCode,
        'date': date,
        'from_time': fromTime,
        'to_time': toTime,
      };
}
