import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/belibahan_controller.dart';
import 'package:akunt/model/data_bhn.dart';
import 'package:provider/provider.dart';

Widget AddBelibahanCard(BuildContext context, int index, DataBhn data_bhn) {
  TextEditingController kd_bhnController = new TextEditingController();
  TextEditingController na_bhnController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController ketController = new TextEditingController();
  TextEditingController hargaController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController sisaController = new TextEditingController();
  double subTotal = data_bhn.qty * data_bhn.harga;
  kd_bhnController.value = TextEditingValue(
    text: data_bhn.kd_bhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bhn.kd_bhn.toString().length),
    ),
  );
  na_bhnController.value = TextEditingValue(
    text: data_bhn.na_bhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bhn.na_bhn.toString().length),
    ),
  );
  satuanController.value = TextEditingValue(
    text: data_bhn.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bhn.satuan.toString().length),
    ),
  );
  ketController.value = TextEditingValue(
    text: data_bhn.ket.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bhn.ket.toString().length),
    ),
  );
  hargaController.value = TextEditingValue(
    text: config().format_rupiah(data_bhn.harga.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_bhn.harga.toString()).length),
    ),
  );
  qtyController.value = TextEditingValue(
    text: data_bhn.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bhn.qty.toString().length),
    ),
  );
  sisaController.value = TextEditingValue(
    text: data_bhn.sisa.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_bhn.sisa.toString().length),
    ),
  );
  var belibahanController =
      Provider.of<BelibahanController>(context, listen: false);

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
            flex: 2,
            child: Text(
              data_bhn.kd_bhn,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data_bhn.na_bhn,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              data_bhn.satuan,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              data_bhn.ket,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: hargaController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Rp 0",
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
                      hargaController.value = TextEditingValue(
                        text: config().format_rupiah(hargaController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(hargaController.text)
                                  .length),
                        ),
                      );
                      belibahanController.data_bhn_keranjang[index].harga =
                          config().convert_rupiah(hargaController.text);
                      belibahanController.notifyListeners();
                      belibahanController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belibahanController.data_bhn_keranjang[index].harga =
                        config().convert_rupiah(hargaController.text);
                    belibahanController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
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
                      belibahanController.data_bhn_keranjang[index].qty =
                          double.parse(qtyController.text);
                      // belibahanController.notifyListeners();
                      // belibahanController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belibahanController.data_bhn_keranjang[index].qty =
                        double.parse(qtyController.text);
                    belibahanController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              config().format_rupiah(subTotal.toString()),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          InkWell(
            onTap: () {
              belibahanController.data_bhn_keranjang.removeAt(index);
              belibahanController.hitungSubTotal();
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
