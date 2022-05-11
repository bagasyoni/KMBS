import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/mutasibhn_controller.dart';
import 'package:akunt/model/data_bhn.dart';
import 'package:provider/provider.dart';

Widget AddMutasibhnCard(BuildContext context, int index, DataBhn data_bahan) {
  TextEditingController kd_bhnController = new TextEditingController();
  TextEditingController na_bhnController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController stockrController = new TextEditingController();
  TextEditingController fisikController = new TextEditingController();
  kd_bhnController.value = TextEditingValue(
    text: data_bahan.kd_bhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bahan.kd_bhn.toString().length),
    ),
  );
  na_bhnController.value = TextEditingValue(
    text: data_bahan.na_bhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bahan.na_bhn.toString().length),
    ),
  );
  satuanController.value = TextEditingValue(
    text: data_bahan.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bahan.satuan.toString().length),
    ),
  );
  qtyController.value = TextEditingValue(
    text: data_bahan.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bahan.qty.toString().length),
    ),
  );
  stockrController.value = TextEditingValue(
    text: data_bahan.stockr.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bahan.stockr.toString().length),
    ),
  );
  fisikController.value = TextEditingValue(
    text: data_bahan.fisik.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bahan.fisik.toString().length),
    ),
  );
  var mutasibhnController =
      Provider.of<MutasibhnController>(context, listen: false);

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
              data_bahan.kd_bhn ?? "",
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
                  controller: na_bhnController,
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
                      mutasibhnController.data_bhn_keranjang[index].na_bhn =
                          na_bhnController.text;
                      mutasibhnController.hitungSubTotal();
                      mutasibhnController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibhnController.data_bhn_keranjang[index].na_bhn =
                        na_bhnController.text;
                    mutasibhnController.hitungSubTotal();
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
                      mutasibhnController.data_bhn_keranjang[index].satuan =
                          satuanController.text;
                      // mutasibhnController.hitungSubTotal();
                      mutasibhnController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibhnController.data_bhn_keranjang[index].satuan =
                        satuanController.text;
                    // mutasibhnController.hitungSubTotal();
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
                      mutasibhnController.data_bhn_keranjang[index].qty =
                          double.parse(qtyController.text);
                      mutasibhnController.notifyListeners();
                      mutasibhnController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibhnController.data_bhn_keranjang[index].qty =
                        double.parse(qtyController.text);
                    mutasibhnController.hitungSubTotal();
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
                      mutasibhnController.data_bhn_keranjang[index].stockr =
                          double.parse(stockrController.text);
                      mutasibhnController.notifyListeners();
                      mutasibhnController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibhnController.data_bhn_keranjang[index].stockr =
                        double.parse(stockrController.text);
                    mutasibhnController.hitungSubTotal();
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
                      mutasibhnController.data_bhn_keranjang[index].fisik =
                          double.parse(fisikController.text);
                      mutasibhnController.notifyListeners();
                      mutasibhnController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    mutasibhnController.data_bhn_keranjang[index].fisik =
                        double.parse(fisikController.text);
                    mutasibhnController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              mutasibhnController.data_bhn_keranjang.removeAt(index);
              mutasibhnController.hitungSubTotal();
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
