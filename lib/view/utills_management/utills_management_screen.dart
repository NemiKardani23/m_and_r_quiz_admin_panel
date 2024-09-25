import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/category_type_management_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/file_type_management_screen.dart';

int _selectedIndex = 0;

class UtillsManagementScreen extends StatefulWidget {
  const UtillsManagementScreen({super.key});

  @override
  State<UtillsManagementScreen> createState() => _UtillsManagementScreenState();
}

class _UtillsManagementScreenState extends State<UtillsManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: _selectedIndex);
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
              children: const [FileTypeManagementScreen(), CategoryTypeManagementScreen()]),
        )
      ],
    );
  }

  Widget _tabView() {
    return TabBar(controller: _tabController, tabs: const [
      Tab(
        text: "$fileTypeStr $managementStr",
      ),
      Tab(
        text: "$categoryTypeStr $managementStr",
      ),
    ]);
  }
}
