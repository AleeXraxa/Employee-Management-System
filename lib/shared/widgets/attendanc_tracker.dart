import 'package:flutter/material.dart';
import 'dart:math';

class AttendancePayrollWidget extends StatelessWidget {
  final TextStyle titleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final TextStyle subtitleStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  final TextStyle greenStyle =
      TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w600);

  AttendancePayrollWidget({super.key});

  Widget buildInfoBox(String number, String label,
      {bool applyTransform = false}) {
    final boxContent = Container(
      width: 100, // ✅ Provide fixed size to avoid layout issues with transform
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(number, style: subtitleStyle),
          SizedBox(height: 4),
          Text(label, style: greenStyle),
        ],
      ),
    );

    if (applyTransform) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(pi / 30),
        child: boxContent,
      );
    } else {
      return boxContent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Attendance :', style: titleStyle),
                Text('January 2025', style: subtitleStyle),
              ],
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                buildInfoBox('34', 'Present'),
                buildInfoBox('03', 'Absent'),
                buildInfoBox('02', 'Holiday'),
                buildInfoBox('08', 'Half Day'),
                buildInfoBox('03', 'Week Off'),
                buildInfoBox('02', 'Leave'),
              ],
            ),
            SizedBox(height: 24),
            Text('Payroll :', style: titleStyle),
            SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                buildInfoBox('50,000.00', 'Basic', applyTransform: true),
                buildInfoBox('25,000.00', 'Extra Bonus'),
                buildInfoBox('75,000.00', 'Total'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
