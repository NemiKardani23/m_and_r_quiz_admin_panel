import 'package:m_and_r_quiz_admin_panel/components/nk_table/datagrid_filtering.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_table/user_data.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/student_management/model/user_management_response.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  DataHandler<List<UserManagementData>> userData =
      DataHandler<List<UserManagementData>>();

  @override
  initState() {
    super.initState();
    callApi();
  }

  callApi() {
    ApiWorker().getUserList().then((response) {
      if (response != null &&
          response.status == true &&
          response.data.isNotEmpty) {
        setState(() {
          userData.onSuccess(response.data);
        });
      } else {
        setState(() {
          userData.onEmpty(response?.message ?? ErrorStrings.noDataFound);
        });
      }
    }).catchError((error) {
      setState(() {
        userData.onError(ErrorStrings.oopsSomethingWentWrong);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        nkExtraSmallSizedBox,
        MyCommnonContainer(
          isCardView: true,
          margin: nkRegularPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyRegularText(
                label: "$userStr $listStr",
                fontSize: NkFontSize.headingFont,
              ),
              // MyThemeButton(
              //     padding: 10.horizontal,
              //     leadingIcon: const Icon(
              //       Icons.add,
              //       color: primaryIconColor,
              //     ),
              //     buttonText: "",
              //     onPressed: () {
              //       showAdaptiveDialog(
              //           context: context,
              //           builder: (builder) {
              //             return const AddFileTypeDiloag();
              //           }).then(
              //         (value) {
              //           getFileTypeList();
              //         },
              //       );
              //     }),
            ],
          ),
        ),
        nkSmallSizedBox,
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return userData.when(
      context: context,
      successBuilder: ($UserDATAList) {
        return FilteringDataGrid(
          showPagination: true,
          rowGenModel: _buildRowGenModel($UserDATAList),
        );
      },
    );
  }

  RowGenModel _buildRowGenModel(List<UserManagementData> rowList) {
    return RowGenModel(
        perPageRowCount: 10,
        cellBuilder: (rowdata) {
          return rowdata.getCells().map<Widget>((dataCell) {
            if (dataCell.columnName == "") {
              return FittedBox(
                child: CircleAvatar(
                  backgroundImage: MyNetworkImage(imageUrl: dataCell.value)
                      .networkImageProvider(),
                ),
              );
            } else {
              return Center(
                child: MyRegularText(
                  color: primaryTextColor.withOpacity(0.5),
                  fontSize: NkFontSize.smallFont,
                  label: dataCell.value,
                ),
              );
            }
          }).toList();
        },
        rowsList: _buildRowList(rowList),
        columnList: _buildColumnList());
  }

  List<GridColumn> _buildColumnList() {
    GridColumn buildColumnWidget(String columnName) {
      return GridColumn(
          columnName: columnName,
          label: Center(child: MyRegularText(label: columnName)));
    }

    return [
      buildColumnWidget(""),
      buildColumnWidget(idStr),
      buildColumnWidget(nameStr),
      buildColumnWidget(isAdminStr),
      buildColumnWidget(verifyStr),
      buildColumnWidget(numberStr),
      buildColumnWidget(stateStr),
      buildColumnWidget(countryStr),
      buildColumnWidget(statusStr),
    ];
  }

  List<DataGridRow> _buildRowList(List<UserManagementData> rowList) {
    List<DataGridCell<dynamic>> buildCell(UserManagementData value) {
      return [
        DataGridCell<String>(
          columnName: "",
          value: value.profileImageUrl?.toString() ?? "",
        ),
        DataGridCell<String>(
          columnName: idStr,
          value: value.id?.toString() ?? "",
        ),
        DataGridCell<String>(
          columnName: nameStr,
          value: value.name,
        ),
        DataGridCell<String>(
          columnName: isAdminStr,
          value: (value.isAdmin == 0 ? false : true).toString(),
        ),
        DataGridCell<String>(
          columnName: verifyStr,
          value: value.emailVerified,
        ),
        DataGridCell<String>(
          columnName: numberStr,
          value: value.phoneNumber,
        ),
        DataGridCell<String>(
          columnName: stateStr,
          value: value.state,
        ),
        DataGridCell<String>(
          columnName: countryStr,
          value: value.country,
        ),
        DataGridCell<String>(
          columnName: statusStr,
          value: value.activeStatus,
        ),
      ];
    }

    return List.generate(
      rowList.length,
      (index) {
        return DataGridRow(cells: buildCell(rowList[index]));
      },
    );
  }
}
