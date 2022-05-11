import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/pononbahan_controller.dart';
import 'package:akunt/model/data_brg.dart';
import 'package:provider/provider.dart';

Widget AddPononbahanCard(BuildContext context, int index, DataBrg data_brg) {
  TextEditingController kdbrgController = new TextEditingController();
  TextEditingController nabrgController = new TextEditingController();
  TextEditingController satuanppcController = new TextEditingController();
  TextEditingController qtyppcController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController hargaController = new TextEditingController();
  double subTotal = data_brg.qty * data_brg.harga;
  kdbrgController.value = TextEditingValue(
    text: data_brg.kd_brg.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.kd_brg.toString().length),
    ),
  );
  nabrgController.value = TextEditingValue(
    text: data_brg.na_brg.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.na_brg.toString().length),
    ),
  );
  satuanppcController.value = TextEditingValue(
    text: data_brg.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.satuan.toString().length),
    ),
  );
  qtyppcController.value = TextEditingValue(
    text: data_brg.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.qty.toString().length),
    ),
  );
  satuanController.value = TextEditingValue(
    text: data_brg.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_brg.satuan.toString().length),
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
  var pononController =
      Provider.of<PononbahanController>(context, listen: false);

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
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: nabrgController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Nama Barang",
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
                      pononController.data_brg_keranjang[index].na_brg =
                          nabrgController.text;
                      pononController.hitungSubTotal();
                      pononController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pononController.data_brg_keranjang[index].na_brg =
                        nabrgController.text;
                    pononController.hitungSubTotal();
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
                  controller: satuanppcController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Satuan PPC",
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
                      pononController.data_brg_keranjang[index].satuan =
                          satuanppcController.text;
                      pononController.hitungSubTotal();
                      pononController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pononController.data_brg_keranjang[index].satuan =
                        satuanppcController.text;
                    pononController.hitungSubTotal();
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
                  controller: qtyppcController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "00",
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
                      double qty = double.tryParse(qtyppcController.text) ?? 0;
                      pononController.data_brg_keranjang[index].qty = qty;
                      if (qty <= 0) {
                        pononController.data_brg_keranjang.removeAt(index);
                      }
                      pononController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pononController.data_brg_keranjang[index].qty =
                        config().convert_rupiah(qtyppcController.text);
                    pononController.hitungSubTotal();
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
                  controller: satuanController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Satuan",
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
                      pononController.data_brg_keranjang[index].satuan =
                          satuanController.text;
                      pononController.hitungSubTotal();
                      pononController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pononController.data_brg_keranjang[index].satuan =
                        satuanController.text;
                    pononController.hitungSubTotal();
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
                      pononController.data_brg_keranjang[index].harga =
                          config().convert_rupiah(hargaController.text);
                      pononController.notifyListeners();
                      pononController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pononController.data_brg_keranjang[index].harga =
                        config().convert_rupiah(hargaController.text);
                    pononController.hitungSubTotal();
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
                      double qty = double.tryParse(qtyController.text) ?? 0;
                      pononController.data_brg_keranjang[index].qty = qty;
                      if (qty <= 0) {
                        pononController.data_brg_keranjang.removeAt(index);
                      }
                      pononController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    pononController.data_brg_keranjang[index].qty =
                        config().convert_rupiah(qtyController.text);
                    pononController.hitungSubTotal();
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
              pononController.data_brg_keranjang.removeAt(index);
              pononController.hitungSubTotal();
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
