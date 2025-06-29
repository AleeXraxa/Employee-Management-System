import 'package:employee_management_system/core/app_exports.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<double> hours;

  const WeeklyBarChart({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    final maxHour = (hours.reduce((a, b) => a > b ? a : b)).ceilToDouble();
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          maxY: maxHour < 2 ? 2 : maxHour,
          barGroups: hours.asMap().entries.map((entry) {
            int index = entry.key;
            double value = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: AppColors.primaryColor,
                  width: 18,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) {
                  return Text('${value.toInt()}h',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ));
                },
                interval: 2,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Mon',
                    'Tue'
                  ];
                  return Text(days[value.toInt()],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontFamily: 'Poppins',
                      ));
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
