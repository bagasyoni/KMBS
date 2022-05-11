// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/laporan_stockb_controller.dart';

class FilterTanggal extends StatefulWidget {
  @override
  _FilterTanggalState createState() => _FilterTanggalState();
}

class _FilterTanggalState extends State<FilterTanggal> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LapStockbController>(builder: (context, lapStockb, child) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 1.5,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16, bottom: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(Icons.clear, size: 25),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Filter Tanggal",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SfDateRangePicker(
                          controller: lapStockb.filter_tanggalController,
                          onSelectionChanged: lapStockb.onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.range,
                          selectionColor: HijauColor,
                          endRangeSelectionColor: HijauColor,
                          backgroundColor: Colors.white,
                          rangeSelectionColor: Colors.greenAccent,
                          startRangeSelectionColor: HijauColor,
                          todayHighlightColor: HijauColor,
                          initialSelectedRange:
                              PickerDateRange(DateTime.now(), DateTime.now()),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: InkWell(
                  onTap: () async {
                    if (lapStockb.isEnable_button) {
                      lapStockb.select_data();
                      Navigator.pop(context, true);
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color:
                          (lapStockb.isEnable_button) ? HijauColor : GreyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: HijauColor),
                    ),
                    child: Center(
                      child: Text(
                        "OK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
