
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../export/___app_file_exporter.dart';

class RowGenModel extends DataGridSource {
  final List<DataGridRow> rowsList;
  final List<GridColumn> columnList;
  final List<Widget> Function(DataGridRow rowdata)? cellBuilder;
  int perPageRowCount;
  List<DataGridRow> paitendRowsList = [];

  RowGenModel({
    this.cellBuilder,
    required this.rowsList,
    this.perPageRowCount = 2,
    required this.columnList,
  }) {
    paitendRowsList = rowsList;
    if (rowsList.length > perPageRowCount) {
      paitendRowsList = rowsList.sublist(0, perPageRowCount);
    }
  }

  @override
  List<DataGridRow> get rows => paitendRowsList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: secondaryBackgroundColor,
        cells: _addPaddingInListWidget(cellBuilder?.call(row) ??
            row.getCells().map<Widget>((dataCell) {
              return Center(
                child: MyRegularText(
                  color: primaryTextColor.withOpacity(0.5),
                  fontSize: NkFontSize.smallFont,
                  label: dataCell.value,
                ),
              );
            }).toList()));
  }

  List<Widget> _addPaddingInListWidget(List<Widget> listWidget) {
    return listWidget
        .map((e) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: e,
            ))
        .toList();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) {
    final int startIndex = newPageIndex * perPageRowCount;
    int endIndex = startIndex + perPageRowCount;
    if (endIndex > rowsList.length) {
      endIndex = rowsList.length;
    }

    /// Get a particular range from the sorted collection.
    if (startIndex < rowsList.length && endIndex <= rowsList.length) {
      paitendRowsList = rowsList.getRange(startIndex, endIndex).toList();
    } else {
      paitendRowsList = [];
    }
    // buildDataGridRow();
    notifyListeners();
    return Future<bool>.value(true);
  }
}
