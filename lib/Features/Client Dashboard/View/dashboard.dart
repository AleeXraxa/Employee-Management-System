import 'package:employee_management_system/Features/Client%20Dashboard/View/add_feedback.dart';
import 'package:employee_management_system/core/app_exports.dart';

class ClientDashboard extends StatefulWidget {
  final UserModel clientData;
  const ClientDashboard({
    super.key,
    required this.clientData,
  });

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  final authController = Get.find<AuthController>();
  final clientController = Get.find<ClientTaskController>();

  @override
  void initState() {
    super.initState();
    clientController.fetchTasks(widget.clientData.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, Client',
                        style: AppTextStyles.bodyTextMedium,
                      ),
                      Text(
                        "Let's Start Your Day",
                        style: AppTextStyles.bodyText,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      authController.logout();
                    },
                    icon: FaIcon(FontAwesomeIcons.rightToBracket),
                  ),
                ],
              ),
              SizedBox(height: 0.02.sh),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4FBF7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.clientData.username.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Employee',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (clientController.isLoading.value) {
                  return CircularProgressIndicator();
                }

                if (clientController.tasks.isEmpty) {
                  return Center(child: Text('No tasks assigned.'));
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: clientController.tasks.length,
                  itemBuilder: (_, index) {
                    final task = clientController.tasks[index];
                    return TaskCard(
                      onDelete: () {},
                      task: task,
                      user: Rxn(widget.clientData),
                      showStatus: true,
                      onTap: () {
                        Get.to(() =>
                            AddFeedback(client: widget.clientData, task: task));
                      },
                    );
                  },
                );
              })
            ],
          ),
        ),
      )),
    );
  }
}
