import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/mutasibrg_controller.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:provider/provider.dart';

Widget AddMutasibrgCard(BuildContext context, int index, DataBrg data_brg) {
  TextEditingController kd_brgController = new TextEditingController();
  TextEditingController na_brgController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController stockrController = new TextEditingController();
  TextEditingController fisikController = new TextEditingController();
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
  qtyController.value = TextEditingValue(
    text: data_brg.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.qty.toString().length),
    ),
  );
  stockrController.value = TextEditingValue(
    text: data_brg.stockr.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.stockr.toString().length),
    ),
  );
  fisikController.value = TextEditingValue(
    text: data_brg.fisik.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.fisik.toString().length),
    ),
  );
  var mutasibrgController =
      Provider.of<MutasibrgController>(context, listen: false);

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
            child: Text(
              "${index + 1}.",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data_brg.kd_brg ?? "",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: na_brgController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "-",
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
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      mutasibrgController.data_brg_keranjang[index].na_brg =
                          na_brgController.text;
                      mutasibrgController.hitungSubTotal();
                      mutasibrgController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibrgController.data_brg_keranjang[index].na_brg =
                        na_brgController.text;
                    mutasibrgController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: satuanController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "satuan",
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
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      mutasibrgController.data_brg_keranjang[index].satuan =
                          satuanController.text;
                      // mutasibrgController.hitungSubTotal();
                      mutasibrgController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibrgController.data_brg_keranjang[index].satuan =
                        satuanController.text;
                    // mutasibrgController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: qtyController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Qty",
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
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      mutasibrgController.data_brg_keranjang[index].qty =
                          double.parse(qtyController.text);
                      mutasibrgController.notifyListeners();
                      mutasibrgController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibrgController.data_brg_keranjang[index].qty =
                        double.parse(qtyController.text);
                    mutasibrgController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: stockrController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "-",
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
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      mutasibrgController.data_brg_keranjang[index].stockr =
                          double.parse(stockrController.text);
                      mutasibrgController.notifyListeners();
                      mutasibrgController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibrgController.data_brg_keranjang[index].stockr =
                        double.parse(stockrController.text);
                    mutasibrgController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: fisikController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "-",
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
                  onChanged: (numb) {
                    if (numb.isNotEmpty) {
                      mutasibrgController.data_brg_keranjang[index].fisik =
                          double.parse(fisikController.text);
                      mutasibrgController.notifyListeners();
                      mutasibrgController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibrgController.data_brg_keranjang[index].fisik =
                        double.parse(fisikController.text);
                    mutasibrgController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              mutasibrgController.data_brg_keranjang.removeAt(index);
              mutasibrgController.hitungSubTotal();
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
