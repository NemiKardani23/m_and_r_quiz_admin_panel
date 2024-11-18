import 'package:m_and_r_quiz_admin_panel/components/nk_table/user_data.dart';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../export/___app_file_exporter.dart';

/// Renders filtering data grid
class FilteringDataGrid extends StatefulWidget {
  final RowGenModel rowGenModel;
  final int footerFrozenColumnsCount;
  final bool showPagination;
  // final List<DataColumn> columns;
  // final List<DataRow> rows;
  const FilteringDataGrid({
    super.key,
    required this.rowGenModel,
    this.footerFrozenColumnsCount = 0,
    this.showPagination = false,
  });

  @override
  State<FilteringDataGrid> createState() => _FilteringDataGridState();
}

class _FilteringDataGridState extends State<FilteringDataGrid> {
  bool isLandscapeInMobileView = false;

  late bool isWebOrDesktop;

  @override
  void initState() {
    super.initState();
    isWebOrDesktop = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: NkGeneralSize.nkCommonBorderRadius,
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
                filterPopupTextStyle:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: primaryTextColor,
                        ),
                filterPopupDisabledTextStyle:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: primaryTextColor.withOpacity(0.5),
                        ),
                filterIconColor: Theme.of(context).iconTheme.color,
                sortIconColor: Theme.of(context).iconTheme.color,
                selectionColor: Theme.of(context).primaryColor,
                frozenPaneLineColor: dividerColor.withOpacity(.1),
                frozenPaneElevation: 10,
                gridLineColor: dividerColor.withOpacity(0.8),
                rowHoverColor: primaryHoverColor.withOpacity(0.2),
                gridLineStrokeWidth: 0,
                headerColor: revenueProgressBarColor),
            child: SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.horizontal,
              frozenColumnsCount: 3,
              footerFrozenColumnsCount: widget.footerFrozenColumnsCount,
              isScrollbarAlwaysShown: true,
              allowSorting: false,
              rowsPerPage: widget.rowGenModel.perPageRowCount,
              shrinkWrapRows: true,
              allowFiltering: false,
              source: widget.rowGenModel,
              columns: widget.rowGenModel.columnList,
              showHorizontalScrollbar: true,
              columnWidthMode: context.isMobile
                  ? ColumnWidthMode.fitByColumnName
                  : ColumnWidthMode.fill,
            ),
          ),
        ),
        if (widget.showPagination) ...[
          nkSmallSizedBox,
          SizedBox(
            width: double.infinity,
            child: SfDataPagerTheme(
              data: SfDataPagerThemeData(
                dropdownButtonBorderColor: grey,
                itemBorderRadius: NkGeneralSize.nkCommonSmoothBorderRadius,
                selectedItemColor: selectionColor.withOpacity(0.08),
                itemTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: primaryTextColor.withOpacity(0.5)),
                selectedItemTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                        color: primaryTextColor,
                        fontWeight: NkGeneralSize.nkBoldFontWeight),
              ),
              child: SfDataPager(
                firstPageItemVisible: false,
                lastPageItemVisible: false,
                previousPageItemVisible: true,
                availableRowsPerPage: const [2, 5, 10, 20, 40, 60, 100],
                onRowsPerPageChanged: (value) {
                  setState(() {
                    widget.rowGenModel.perPageRowCount =
                        value ?? widget.rowGenModel.perPageRowCount;
                  });
                },
                pageItemBuilder: (text) {
                  if (text == 'Next') {
                    return Container(
                      padding: 5.all,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: secondaryIconColor,
                        ),
                      ),
                    );
                  }
                  if (text == 'Previous') {
                    return Container(
                      padding: 5.all,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: secondaryIconColor,
                        ),
                      ),
                    );
                  }
                },
                pageCount: (widget.rowGenModel.rowsList.length /
                        widget.rowGenModel.perPageRowCount)
                    .ceil()
                    .toDouble(),
                delegate: widget.rowGenModel,
              ),
            ),
          ),
          nkSmallSizedBox,
        ]
      ],
    );
    // return DataTable(columns: widget.columns, rows: widget.rows);
  }
}
