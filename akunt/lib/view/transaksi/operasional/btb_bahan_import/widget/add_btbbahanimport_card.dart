import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/operasional/btbbahanimport_controller.dart';
import 'package:akunt/model/transaksi/operasional/data_podbahanimport.dart';
import 'package:provider/provider.dart';

Widget AddBtbBahanImportCard(
    BuildContext context, int index, DataPodBahanImport dataPodBahanImport) {
  TextEditingController kdBhnController = new TextEditingController();
  TextEditingController naBhnController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController ketController = new TextEditingController();
  TextEditingController hargaController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  double subTotal = dataPodBahanImport.qty * dataPodBahanImport.harga;
  double subTotal1 = (dataPodBahanImport.qty * dataPodBahanImport.harga) *
      double.parse((BtbBahanImportController.rate).toString());
  kdBhnController.value = TextEditingValue(
    text: dataPodBahanImport.kdbhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: dataPodBahanImport.kdbhn.toString().length),
    ),
  );
  naBhnController.value = TextEditingValue(
    text: dataPodBahanImport.nabhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: dataPodBahanImport.nabhn.toString().length),
    ),
  );
  satuanController.value = TextEditingValue(
    text: dataPodBahanImport.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: dataPodBahanImport.satuan.toString().length),
    ),
  );
  ketController.value = TextEditingValue(
    text: dataPodBahanImport.ket.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: dataPodBahanImport.ket.toString().length),
    ),
  );
  hargaController.value = TextEditingValue(
    text: config().format_rupiah(dataPodBahanImport.harga.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config()
              .format_rupiah(dataPodBahanImport.harga.toString())
              .length),
    ),
  );
  qtyController.value = TextEditingValue(
    text: dataPodBahanImport.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: dataPodBahanImport.qty.toString().length),
    ),
  );
  var btbBahanImportController =
      Provider.of<BtbBahanImportController>(context, listen: false);

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
              dataPodBahanImport.kdbhn ?? "",
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
                  controller: naBhnController,
                  readOnly: true,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Nama Bahan",
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
                      btbBahanImportController
                          .dataPodBahanImportKeranjang[index]
                          .nabhn = naBhnController.text;
                      btbBahanImportController.hitungSubTotal();
                      btbBahanImportController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    btbBahanImportController.dataPodBahanImportKeranjang[index]
                        .nabhn = naBhnController.text;
                    btbBahanImportController.hitungSubTotal();
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
                  readOnly: true,
                  controller: satuanController,
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
                      btbBahanImportController
                          .dataPodBahanImportKeranjang[index]
                          .satuan = satuanController.text;
                      btbBahanImportController.hitungSubTotal();
                      btbBahanImportController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    btbBahanImportController.dataPodBahanImportKeranjang[index]
                        .satuan = satuanController.text;
                    btbBahanImportController.hitungSubTotal();
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
                  controller: ketController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Keterangan",
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
                      btbBahanImportController
                          .dataPodBahanImportKeranjang[index]
                          .ket = ketController.text;
                      btbBahanImportController.hitungSubTotal();
                      btbBahanImportController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    btbBahanImportController.dataPodBahanImportKeranjang[index]
                        .ket = ketController.text;
                    btbBahanImportController.hitungSubTotal();
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
                      btbBahanImportController
                              .dataPodBahanImportKeranjang[index].harga =
                          config().convert_rupiah(hargaController.text);
                      // btbBahanImportController.notifyListeners();
                      btbBahanImportController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    btbBahanImportController.dataPodBahanImportKeranjang[index]
                        .harga = config().convert_rupiah(hargaController.text);
                    btbBahanImportController.hitungSubTotal();
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
                      btbBahanImportController
                          .dataPodBahanImportKeranjang[index]
                          .qty = config().convert_rupiah(qtyController.text);
                      // btbBahanImportController.hitungSubTotal();
                      // btbBahanImportController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    btbBahanImportController.dataPodBahanImportKeranjang[index]
                        .qty = config().convert_rupiah(qtyController.text);
                    btbBahanImportController.hitungSubTotal();
                    // btbBahanImportController.notifyListeners();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              config().format_rupiah(subTotal.toString()),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              config().format_rupiah(subTotal1.toString()),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          InkWell(
            onTap: () {
              btbBahanImportController.dataPodBahanImportKeranjang
                  .removeAt(index);
              btbBahanImportController.hitungSubTotal();
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
