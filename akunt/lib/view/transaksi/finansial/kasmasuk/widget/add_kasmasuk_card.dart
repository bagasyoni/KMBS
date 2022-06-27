import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/finansial/kasmasuk_controller.dart';
import 'package:akunt/model/transaksi/operasional/data_piutang.dart';
import 'package:provider/provider.dart';

Widget AddKasMasukCard(
    BuildContext context, int index, DataPiutang data_piutang) {
  TextEditingController acnoController = new TextEditingController();
  TextEditingController nacnoController = new TextEditingController();
  TextEditingController uraianController = new TextEditingController();
  TextEditingController jumlahController = new TextEditingController();
  TextEditingController jumlahrpController = new TextEditingController();
  TextEditingController umController = new TextEditingController();
  TextEditingController currController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController noinvController = new TextEditingController();
  // double jumlah = data_piutang.jumlah;
  // double jumlahrp = data_piutang.jumlahrp;
  // double um = data_piutang.um;
  // double rate = data_piutang.rate;
  acnoController.value = TextEditingValue(
    text: data_piutang.acno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_piutang.acno.toString().length),
    ),
  );
  nacnoController.value = TextEditingValue(
    text: data_piutang.nacno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_piutang.nacno.toString().length),
    ),
  );
  uraianController.value = TextEditingValue(
    text: data_piutang.uraian.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_piutang.uraian.toString().length),
    ),
  );
  jumlahController.value = TextEditingValue(
    text: config().format_rupiah(data_piutang.jumlah.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_piutang.jumlah.toString()).length),
    ),
  );
  jumlahrpController.value = TextEditingValue(
    text: config().format_rupiah(data_piutang.jumlahrp.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_piutang.jumlahrp.toString()).length),
    ),
  );
  umController.value = TextEditingValue(
    text: config().format_rupiah(data_piutang.um.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_piutang.um.toString()).length),
    ),
  );
  currController.value = TextEditingValue(
    text: data_piutang.curr.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_piutang.curr.toString().length),
    ),
  );
  rateController.value = TextEditingValue(
    text: config().format_rupiah(data_piutang.rate.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_piutang.rate.toString()).length),
    ),
  );
  noinvController.value = TextEditingValue(
    text: data_piutang.noinv.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_piutang.noinv.toString().length),
    ),
  );
  var kasmasukController = Provider.of<KasmController>(context, listen: false);

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
              data_piutang.no_bukti ?? "",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  readOnly: true,
                  controller: acnoController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "perkiraan",
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
                      kasmasukController.data_piutang_keranjang[index].acno =
                          acnoController.text;
                      kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].acno =
                        acnoController.text;
                    kasmasukController.hitungSubTotal();
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
                  readOnly: true,
                  controller: nacnoController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "nama perkiraan",
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
                      kasmasukController.data_piutang_keranjang[index].nacno =
                          nacnoController.text;
                      kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].nacno =
                        nacnoController.text;
                    kasmasukController.hitungSubTotal();
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
                  controller: uraianController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "uraian",
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
                      kasmasukController.data_piutang_keranjang[index].uraian =
                          uraianController.text;
                      // kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].uraian =
                        uraianController.text;
                    // kasmasukController.hitungSubTotal();
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
                  textAlign: TextAlign.right,
                  controller: jumlahController,
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
                      jumlahController.value = TextEditingValue(
                        text: config().format_rupiah(jumlahController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(jumlahController.text)
                                  .length),
                        ),
                      );
                      kasmasukController.data_piutang_keranjang[index].jumlah =
                          config().convert_rupiah(jumlahController.text);
                      kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].jumlah =
                        config().convert_rupiah(jumlahController.text);
                    kasmasukController.hitungSubTotal();
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
                  textAlign: TextAlign.right,
                  controller: jumlahrpController,
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
                      jumlahrpController.value = TextEditingValue(
                        text: config().format_rupiah(jumlahrpController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(jumlahrpController.text)
                                  .length),
                        ),
                      );
                      kasmasukController
                              .data_piutang_keranjang[index].jumlahrp =
                          config().convert_rupiah(jumlahrpController.text);
                      kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].jumlahrp =
                        config().convert_rupiah(jumlahrpController.text);
                    kasmasukController.hitungSubTotal();
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
                  textAlign: TextAlign.right,
                  controller: umController,
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
                      umController.value = TextEditingValue(
                        text: config().format_rupiah(umController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(umController.text)
                                  .length),
                        ),
                      );
                      kasmasukController.data_piutang_keranjang[index].um =
                          config().convert_rupiah(umController.text);
                      kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].um =
                        config().convert_rupiah(umController.text);
                    kasmasukController.hitungSubTotal();
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
                  controller: currController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "currency",
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
                      kasmasukController.data_piutang_keranjang[index].curr =
                          currController.text;
                      // kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].curr =
                        currController.text;
                    // kasmasukController.hitungSubTotal();
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
                  textAlign: TextAlign.right,
                  controller: rateController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "0.00",
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
                      rateController.value = TextEditingValue(
                        text: config().format_rupiah(rateController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(rateController.text)
                                  .length),
                        ),
                      );
                      kasmasukController.data_piutang_keranjang[index].rate =
                          config().convert_rupiah(rateController.text);
                      kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].rate =
                        config().convert_rupiah(rateController.text);
                    kasmasukController.hitungSubTotal();
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
                  controller: noinvController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "invoice",
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
                      kasmasukController.data_piutang_keranjang[index].noinv =
                          noinvController.text;
                      // kasmasukController.hitungSubTotal();
                      kasmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    kasmasukController.data_piutang_keranjang[index].noinv =
                        noinvController.text;
                    // kasmasukController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              kasmasukController.data_piutang_keranjang.removeAt(index);
              kasmasukController.hitungSubTotal();
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
