import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/app_dashboard/app_dashboard_screen.dart';

int _selectedIndex = 0;

class AppManagementScreen extends StatefulWidget {
  const AppManagementScreen({super.key});

  @override
  State<AppManagementScreen> createState() => _AppManagementScreenState();
}

class _AppManagementScreenState extends State<AppManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 1, vsync: this, initialIndex: _selectedIndex);
    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCommnonContainer(
            isCardView: true, margin: nkRegularPadding, child: _tabView()),
        nkSmallSizedBox,
        Flexible(
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                AppDashboardScreen(),
              ]),
        )
      ],
    );
  }

  Widget _tabView() {
    return TabBar(controller: _tabController, tabs: const [
      Tab(
        text: appDashboardStr,
      ),
    ]);
  }
}
