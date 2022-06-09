import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/belimesin_controller.dart';
import 'package:akunt/model/transaksi/operasional/data_pod.dart';
import 'package:provider/provider.dart';

Widget AddBelimesinCard(BuildContext context, int index, DataPod data_pod) {
  TextEditingController kdbhnController = new TextEditingController();
  TextEditingController nabhnController = new TextEditingController();
  TextEditingController drController = new TextEditingController();
  TextEditingController satuanppController = new TextEditingController();
  TextEditingController qtyppController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController hargaController = new TextEditingController();
  TextEditingController bulatController = new TextEditingController();
  TextEditingController diskController = new TextEditingController();
  TextEditingController valController = new TextEditingController();
  double subTotal = data_pod.qty * data_pod.harga;
  kdbhnController.value = TextEditingValue(
    text: data_pod.kdbhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.kdbhn.toString().length),
    ),
  );
  nabhnController.value = TextEditingValue(
    text: data_pod.nabhn.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.nabhn.toString().length),
    ),
  );
  drController.value = TextEditingValue(
    text: data_pod.dr.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.dr.toString().length),
    ),
  );
  satuanppController.value = TextEditingValue(
    text: data_pod.satuanpp.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.satuanpp.toString().length),
    ),
  );
  qtyppController.value = TextEditingValue(
    text: data_pod.qtypp.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.qtypp.toString().length),
    ),
  );
  satuanController.value = TextEditingValue(
    text: data_pod.satuan.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.satuan.toString().length),
    ),
  );
  hargaController.value = TextEditingValue(
    text: config().format_rupiah(data_pod.harga.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_pod.harga.toString()).length),
    ),
  );
  qtyController.value = TextEditingValue(
    text: data_pod.qty.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.qty.toString().length),
    ),
  );
  diskController.value = TextEditingValue(
    text: data_pod.disk.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.disk.toString().length),
    ),
  );
  valController.value = TextEditingValue(
    text: data_pod.val.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_pod.val.toString().length),
    ),
  );
  var belimesinController =
      Provider.of<BelimesinController>(context, listen: false);

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
              data_pod.kdbhn ?? "",
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
                  controller: nabhnController,
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
                      belimesinController.data_pod_keranjang[index].nabhn =
                          nabhnController.text;
                      belimesinController.hitungSubTotal();
                      belimesinController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].nabhn =
                        nabhnController.text;
                    belimesinController.hitungSubTotal();
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
                  controller: drController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Dragon",
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
                      belimesinController.data_pod_keranjang[index].dr =
                          drController.text;
                      belimesinController.hitungSubTotal();
                      belimesinController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].dr =
                        drController.text;
                    belimesinController.hitungSubTotal();
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
                  controller: satuanppController,
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
                      belimesinController.data_pod_keranjang[index].satuanpp =
                          satuanppController.text;
                      belimesinController.hitungSubTotal();
                      belimesinController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].satuanpp =
                        satuanppController.text;
                    belimesinController.hitungSubTotal();
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
                  controller: qtyppController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "0",
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
                      double qtypp = double.tryParse(qtyppController.text) ?? 0;
                      belimesinController.data_pod_keranjang[index].qtypp =
                          qtypp;
                      if (qtypp <= 0) {
                        belimesinController.data_pod_keranjang.removeAt(index);
                      }
                      belimesinController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].qtypp =
                        config().convert_rupiah(qtyppController.text);
                    belimesinController.hitungSubTotal();
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
                      belimesinController.data_pod_keranjang[index].satuan =
                          satuanController.text;
                      belimesinController.hitungSubTotal();
                      belimesinController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].satuan =
                        satuanController.text;
                    belimesinController.hitungSubTotal();
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
                      // qtyController.value = TextEditingValue(
                      //   text: qtyController.text,
                      //   selection: TextSelection.fromPosition(
                      //     TextPosition(offset: qtyController.text.length),
                      //   ),
                      // );
                      belimesinController.data_pod_keranjang[index].qty =
                          double.parse(qtyController.text);
                      belimesinController.notifyListeners();
                      belimesinController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].qty =
                        double.parse(qtyController.text);
                    belimesinController.hitungSubTotal();
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
                      belimesinController.data_pod_keranjang[index].harga =
                          config().convert_rupiah(hargaController.text);
                      belimesinController.notifyListeners();
                      belimesinController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].harga =
                        config().convert_rupiah(hargaController.text);
                    belimesinController.hitungSubTotal();
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
                  controller: bulatController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Bulat",
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
                      // qtyController.value = TextEditingValue(
                      //   text: qtyController.text,
                      //   selection: TextSelection.fromPosition(
                      //     TextPosition(offset: qtyController.text.length),
                      //   ),
                      // );
                      belimesinController.data_pod_keranjang[index].bulat =
                          double.parse(bulatController.text);
                      belimesinController.notifyListeners();
                      belimesinController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].bulat =
                        double.parse(bulatController.text);
                    belimesinController.hitungSubTotal();
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
                  controller: diskController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Diskon",
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
                      // qtyController.value = TextEditingValue(
                      //   text: qtyController.text,
                      //   selection: TextSelection.fromPosition(
                      //     TextPosition(offset: qtyController.text.length),
                      //   ),
                      // );
                      belimesinController.data_pod_keranjang[index].disk =
                          double.parse(diskController.text);
                      belimesinController.notifyListeners();
                      belimesinController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].disk =
                        double.parse(diskController.text);
                    belimesinController.hitungSubTotal();
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
                  controller: valController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Val",
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
                      // qtyController.value = TextEditingValue(
                      //   text: qtyController.text,
                      //   selection: TextSelection.fromPosition(
                      //     TextPosition(offset: qtyController.text.length),
                      //   ),
                      // );
                      belimesinController.data_pod_keranjang[index].val =
                          double.parse(valController.text);
                      belimesinController.notifyListeners();
                      belimesinController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    belimesinController.data_pod_keranjang[index].val =
                        double.parse(valController.text);
                    belimesinController.hitungSubTotal();
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
              belimesinController.data_pod_keranjang.removeAt(index);
              belimesinController.hitungSubTotal();
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
