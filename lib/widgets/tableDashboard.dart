import 'package:flutter/material.dart';
import 'package:spashta_base_app/models/table.dart';
import 'package:spashta_base_app/constants.dart';
import 'package:spashta_base_app/styling/textStyles.dart';

class TableDashboard extends StatefulWidget {
  final TableResponseModel? response;

  TableDashboard({this.response});
  @override
  _TableDashboardState createState() => _TableDashboardState();
}

class _TableDashboardState extends State<TableDashboard> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;

  List<DataColumn> getColumns() {
    List<String> columnData = [];
    widget.response!.schema!.header!.forEach((element) {
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
    var dts = DTS(tableContent: widget.response!);
    int tableItemCount = widget.response!.rows!.length;
    int defaultRows = PaginatedDataTable.defaultRowsPerPage;
    _rowsPerPage = tableItemCount < defaultRows ? tableItemCount : defaultRows;
    return Container(
      constraints:
          BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/watermark.png'), fit: BoxFit.fill),
      ),
      child: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
              cardTheme: CardTheme(
                  color: light,
                  shadowColor: dark,
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              dividerColor: dark,
              dataTableTheme: DataTableThemeData(
                  dataTextStyle: tableDataTextStyle,
                  headingTextStyle: tableHeaderTextStyle)),
          child: PaginatedDataTable(
            header: Text(widget.response!.schema!.title!,
                textAlign: TextAlign.center, style: tableTitleTextStyle),
            columns: getColumns(),
            source: dts,
            showFirstLastButtons: true,
            onRowsPerPageChanged: tableItemCount < defaultRows
                ? null
                : (rowCount) {
                    setState(() {
                      _rowsPerPage1 = rowCount!;
                    });
                  },
            rowsPerPage:
                tableItemCount < defaultRows ? _rowsPerPage : _rowsPerPage1,
          ),
        ),
      ),
    );
  }
}

class DTS extends DataTableSource {
  final TableResponseModel tableContent;

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
                (states) => Color(0xFFFBCAEF))
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
