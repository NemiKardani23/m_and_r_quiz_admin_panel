import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/board/bord_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/chapter/chapter_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/standard/standard_screen.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/subject/subject_screen.dart';

int _selectedIndex = 0;

class BasicScreen extends StatefulWidget {
  const BasicScreen({super.key});

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: _selectedIndex);
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
        Flexible(
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                BordScreen(),
                StandardScreen(),
                SubjectScreen(),
                ChapterScreen(),
              ]),
        )
      ],
    );
  }

  Widget _tabView() {
    return TabBar(controller: _tabController, tabs: const [
      Tab(
        text: boardStr,
      ),
      Tab(
        text: standardStr,
      ),
      Tab(
        text: subjectStr,
      ),
      Tab(
        text: chapterStr,
      ),
    ]);
  }
}
