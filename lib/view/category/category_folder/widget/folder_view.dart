import 'package:dynamic_routes/dynamic_routes_navigator.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_manager_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class FolderView extends StatefulWidget {
  final List<CategoryManagerModel> children;
  final String? title;
  const FolderView({super.key, required this.children, this.title});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> with DynamicRoutesInitiator {
  @override
  void initState() {
    dynamicRoutesInitiator.setCache(widget.children.length-1);
    super.initState();
  }

  _folderViewState() {
    
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  _gridView() {
    return ResponsiveGridList(
          minItemWidth: context.isMobile ? context.width : 300,
          minItemsPerRow: 1,
          maxItemsPerRow: 4,
          children: List.generate(widget.children.length, (index) {
            final beby = widget.children[index];
            return MyCommnonContainer(
              isCardView: true,
              child: Column(
                children: [
                  MyRegularText(label:beby.name??"" ),
                  
                ],
              ),
            );
          }).toList(),
        );
  }
}
