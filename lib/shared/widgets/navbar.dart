import 'package:employee_management_system/core/app_exports.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavBarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Colors.white,
          elevation: 10,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(icon: FontAwesomeIcons.house, index: 0),
                _buildNavItem(icon: FontAwesomeIcons.listCheck, index: 1),
                const SizedBox(width: 40), // space for FAB
                _buildNavItem(icon: FontAwesomeIcons.clipboardUser, index: 2),
                _buildNavItem(icon: FontAwesomeIcons.moneyCheck, index: 3),
              ],
            ),
          ),
        ));
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.green : Colors.grey),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: isSelected ? 20 : 0,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
