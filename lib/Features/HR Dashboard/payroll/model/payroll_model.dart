class PayrollModel {
  final String employeeId;
  final int presentDays;
  final int absentDays;
  final int leaveDays;
  final double basicSalary;
  final double bonus;
  final double totalSalary;
  final String month;
  final String year;

  PayrollModel({
    required this.employeeId,
    required this.presentDays,
    required this.absentDays,
    required this.leaveDays,
    required this.basicSalary,
    required this.bonus,
    required this.totalSalary,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'presentDays': presentDays,
      'absentDays': absentDays,
      'leaveDays': leaveDays,
      'basicSalary': basicSalary,
      'bonus': bonus,
      'totalSalary': totalSalary,
      'month': month,
      'year': year,
    };
  }

  factory PayrollModel.fromMap(String id, Map<String, dynamic> map) {
    return PayrollModel(
      employeeId: map['employeeId'],
      presentDays: map['presentDays'],
      absentDays: map['absentDays'],
      leaveDays: map['leaveDays'],
      basicSalary: map['basicSalary'],
      bonus: map['bonus'],
      totalSalary: map['totalSalary'],
      month: map['month'],
      year: map['year'],
    );
  }
}
