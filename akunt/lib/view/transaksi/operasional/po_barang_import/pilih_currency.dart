import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/currency_controller.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PilihCurrency extends StatefulWidget {
  String currency_terpilih;
  var controller;

  PilihCurrency(this.currency_terpilih, this.controller);

  @override
  _PilihCurrencyState createState() => _PilihCurrencyState();
}

class _PilihCurrencyState extends State<PilihCurrency> {
  TextEditingController searchController = TextEditingController();
  int index_terpilih;

  @override
  void initState() {
    Provider.of<CurrencyController>(context, listen: false).selectData("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyController>(
        builder: (context, currencyController, child) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height - 100,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text("Pilih Currency",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Card(
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                      icon: Image.asset(
                        "assets/images/ic_search.png",
                        height: 25,
                      ),
                      hintText: "Cari disini",
                      hintStyle: GoogleFonts.poppins(
                          color: GreyColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      currencyController.selectData(value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Kode",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Nama",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Rate",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currencyController.data_currencyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return currencyCard(index);
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Divider(height: 0, color: GreyColor),
            Row(children: [
              Expanded(
                  child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10))),
                  child: Text("Batal",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black87)),
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () async {
                  if (index_terpilih != null) {
                    widget.controller.currController.text = currencyController
                        .data_currencyList[index_terpilih]['KODE'];
                    widget.controller.currnmController.text = currencyController
                        .data_currencyList[index_terpilih]['NAMA'];
                    widget.controller.rateController.text = currencyController
                        .data_currencyList[index_terpilih]['Rate']
                        .toString();
                    Navigator.pop(context);
                  } else {
                    Toast("Peringatan", "Belum ada data terpilih", false);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(10))),
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              )),
            ]),
          ]),
        ),
      );
    });
  }

  Widget currencyCard(int index) {
    bool isActive = index == index_terpilih;
    var data_currency = Provider.of<CurrencyController>(context, listen: false)
        .data_currencyList[index];
    if (widget.currency_terpilih != null) {
      if (data_currency['KODE'] == widget.currency_terpilih) {
        isActive = true;
        index_terpilih = index;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          index_terpilih = index;
          widget.currency_terpilih = data_currency['KODE'];
          setState(() {});
        },
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      data_currency['KODE'],
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      data_currency['NAMA'],
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      data_currency['Rate'].toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  (isActive)
                      ? Image.asset(
                          "assets/images/ic_success.png",
                          width: 30,
                        )
                      : SizedBox(
                          width: 30,
                          height: 30,
                        ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
