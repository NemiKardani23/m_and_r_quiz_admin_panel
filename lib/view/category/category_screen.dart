import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/category_folder/category_folder_screen.dart';

class CategoryScreen extends StatefulWidget {
  final StatefulNavigationShell? child;
  const CategoryScreen({super.key, this.child});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CategoryFolderScreen();
  }
}
