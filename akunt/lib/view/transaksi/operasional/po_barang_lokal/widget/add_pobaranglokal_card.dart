import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/operasional/pobaranglokal_controller.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Widget AddPobarangCard(BuildContext context, int index, DataBrg data_brg) {
  TextEditingController kd_brgController = new TextEditingController();
  TextEditingController na_brgController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController ketController = new TextEditingController();
  TextEditingController hargaController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  double subTotal = data_brg.qty * data_brg.harga;
  double subTotal1 = (data_brg.qty * data_brg.harga) *
      double.parse((PobaranglokalController.rate).toString());
  kd_brgController.value = TextEditingValue(
    text: data_brg.kd_brg.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.kd_brg.toString().length),
    ),
  );
  na_brgController.value = TextEditingValue(
    text: data_brg.na_brg.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.na_brg.toString().length),
    ),
  );
  satuanController.value = TextEditingValue(
    text: data_brg.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.satuan.toString().length),
    ),
  );
  ketController.value = TextEditingValue(
    text: data_brg.ket.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.ket.toString().length),
    ),
  );
  hargaController.value = TextEditingValue(
    text: config().format_rupiah(data_brg.harga.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_brg.harga.toString()).length),
    ),
  );
  qtyController.value = TextEditingValue(
    text: data_brg.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.qty.toString().length),
    ),
  );
  var pobaranglokalController =
      Provider.of<PobaranglokalController>(context, listen: false);

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "${index + 1}.",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    data_brg.kd_brg ?? "",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: na_brgController,
                  readOnly: true,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "Nama Bahan",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      pobaranglokalController.data_brg_keranjang[index].na_brg =
                          na_brgController.text;
                      pobaranglokalController.hitungSubTotal();
                      pobaranglokalController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pobaranglokalController.data_brg_keranjang[index].na_brg =
                        na_brgController.text;
                    pobaranglokalController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: satuanController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "-",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      pobaranglokalController.data_brg_keranjang[index].satuan =
                          satuanController.text;
                      pobaranglokalController.hitungSubTotal();
                      pobaranglokalController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pobaranglokalController.data_brg_keranjang[index].satuan =
                        satuanController.text;
                    pobaranglokalController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: ketController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "Keterangan",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      pobaranglokalController.data_brg_keranjang[index].ket =
                          ketController.text;
                      pobaranglokalController.hitungSubTotal();
                      pobaranglokalController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pobaranglokalController.data_brg_keranjang[index].ket =
                        ketController.text;
                    pobaranglokalController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: hargaController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "Rp 0",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      hargaController.value = TextEditingValue(
                        text: config().format_rupiah(hargaController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(hargaController.text)
                                  .length),
                        ),
                      );
                      pobaranglokalController.data_brg_keranjang[index].harga =
                          config().convert_rupiah(hargaController.text);
                      // pobaranglokalController.notifyListeners();
                      pobaranglokalController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pobaranglokalController.data_brg_keranjang[index].harga =
                        config().convert_rupiah(hargaController.text);
                    pobaranglokalController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: qtyController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "Qty",
                    hintStyle: GoogleFonts.poppins(
                        color: GreyColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      pobaranglokalController.data_brg_keranjang[index].qty =
                          config().convert_rupiah(qtyController.text);
                      // pobaranglokalController.hitungSubTotal();
                      // pobaranglokalController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pobaranglokalController.data_brg_keranjang[index].qty =
                        config().convert_rupiah(qtyController.text);
                    pobaranglokalController.hitungSubTotal();
                    // pobaranglokalController.notifyListeners();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  config().format_rupiah(subTotal.toString()),
                  style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  config().format_rupiah(subTotal1.toString()),
                  style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              pobaranglokalController.data_brg_keranjang.removeAt(index);
              pobaranglokalController.hitungSubTotal();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                "assets/images/ic_hapus.png",
                height: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
