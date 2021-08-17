import 'package:flutter/material.dart';
import 'package:spashta_base_app/models/dashboard.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

class MultiDashboard extends StatefulWidget {
  final DashboardResponseModel? response;

  MultiDashboard({this.response});
  @override
  _MultiDashboardState createState() => _MultiDashboardState();
}

class _MultiDashboardState extends State<MultiDashboard> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;

  List<DataColumn> getColumns(int index) {
    List<String> columnData = [];
    widget.response!.responses![index].schema!.header!.forEach((element) {
      columnData.add(element.displayName!);
    });
    List<DataColumn> columns = [];
    columnData.forEach((element) {
      columns.add(DataColumn(label: Text(element)));
    });
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: light,
        image: DecorationImage(
            image: AssetImage('assets/images/watermark.png'), fit: BoxFit.fill),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      constraints:
          BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
      child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          itemCount: widget.response!.responses!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 2
                      : 1,
              crossAxisSpacing: 40.0,
              mainAxisSpacing: 40.0),
          itemBuilder: (context, index) {
            if (widget.response!.responses![index].type == "TABLE") {
              var dts = DTS(tableContent: widget.response!.responses![index]);
              int tableItemCount =
                  widget.response!.responses![index].rows!.length;
              int defaultRows = PaginatedDataTable.defaultRowsPerPage;
              _rowsPerPage =
                  tableItemCount < defaultRows ? tableItemCount : defaultRows;
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: dark),
                    borderRadius: BorderRadius.circular(15.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: SingleChildScrollView(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          cardTheme: CardTheme(
                              color: light,
                              shadowColor: dark,
                              elevation: 5.0,
                              // margin: EdgeInsets.symmetric(
                              //     vertical: 5.0, horizontal: 5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          dividerColor: dark,
                          dataTableTheme: DataTableThemeData(
                              dataTextStyle: tableDataTextStyle,
                              headingTextStyle: tableHeaderTextStyle)),
                      child: PaginatedDataTable(
                        header: Text(
                            widget.response!.responses![index].schema!.title!,
                            textAlign: TextAlign.center,
                            style: tableTitleTextStyle),
                        columns: getColumns(index),
                        source: dts,
                        showFirstLastButtons: true,
                        onRowsPerPageChanged: tableItemCount < defaultRows
                            ? null
                            : (rowCount) {
                                setState(() {
                                  _rowsPerPage1 = rowCount!;
                                });
                              },
                        rowsPerPage: tableItemCount < defaultRows
                            ? _rowsPerPage
                            : _rowsPerPage1,
                      ),
                    ),
                  ),
                ),
              );
            } else
              return Container();
          }),
    );
  }
}

class DTS extends DataTableSource {
  final Response tableContent;

  DTS({required this.tableContent});

  List<DataCell> getCells(List<String> rowCells) {
    List<DataCell> cells = [];
    rowCells.forEach((cellData) {
      if (cellData == "")
        cells.add(DataCell(Text("-")));
      else
        cells.add(DataCell(Text(cellData)));
    });
    return cells;
  }

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
        color: index % 2 == 0
            ? MaterialStateProperty.resolveWith<Color?>(
                (states) => Color(0xFFFAFAC6))
            //FBCAEF - COTTON CANDY
            //FAFAC6 - CREAM
            : null,
        index: index,
        cells: getCells(tableContent.rows![index].cells!));
  }

  @override
  int get rowCount => tableContent.rows!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
