import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/finansial/bankkeluar_controller.dart';
import 'package:akunt/model/transaksi/operasional/data_hutang.dart';
import 'package:provider/provider.dart';

Widget AddBankKeluarCard(
    BuildContext context, int index, DataHutang data_hutang) {
  TextEditingController acnoController = new TextEditingController();
  TextEditingController nacnoController = new TextEditingController();
  TextEditingController uraianController = new TextEditingController();
  TextEditingController jumlahController = new TextEditingController();
  TextEditingController jumlahrpController = new TextEditingController();
  TextEditingController umController = new TextEditingController();
  TextEditingController currController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  TextEditingController noinvController = new TextEditingController();
  // double jumlah = data_hutang.jumlah;
  // double jumlah1 = data_hutang.jumlah1;
  // double um = data_hutang.um;
  // double currd = data_hutang.currd;
  // double rated = data_hutang.rated;
  acnoController.value = TextEditingValue(
    text: data_hutang.acno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_hutang.acno.toString().length),
    ),
  );
  nacnoController.value = TextEditingValue(
    text: data_hutang.nacno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_hutang.nacno.toString().length),
    ),
  );
  uraianController.value = TextEditingValue(
    text: data_hutang.uraian.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_hutang.uraian.toString().length),
    ),
  );
  jumlahController.value = TextEditingValue(
    text: config().format_rupiah(data_hutang.jumlah.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_hutang.jumlah.toString()).length),
    ),
  );
  jumlahrpController.value = TextEditingValue(
    text: config().format_rupiah(data_hutang.jumlahrp.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_hutang.jumlahrp.toString()).length),
    ),
  );
  umController.value = TextEditingValue(
    text: config().format_rupiah(data_hutang.um.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_hutang.um.toString()).length),
    ),
  );
  currController.value = TextEditingValue(
    text: data_hutang.curr.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_hutang.curr.toString().length),
    ),
  );
  rateController.value = TextEditingValue(
    text: config().format_rupiah(data_hutang.rate.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_hutang.rate.toString()).length),
    ),
  );
  noinvController.value = TextEditingValue(
    text: data_hutang.noinv.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_hutang.noinv.toString().length),
    ),
  );
  var bankkeluarController =
      Provider.of<BankkController>(context, listen: false);

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 3),
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
            flex: 2,
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
                    data_hutang.no_bukti ?? "",
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
                  controller: acnoController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "perkiraan",
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
                      bankkeluarController.data_hutang_keranjang[index].acno =
                          acnoController.text;
                      bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].acno =
                        acnoController.text;
                    bankkeluarController.hitungSubTotal();
                  },
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
                  readOnly: true,
                  controller: nacnoController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
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
                      bankkeluarController.data_hutang_keranjang[index].nacno =
                          nacnoController.text;
                      bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].nacno =
                        nacnoController.text;
                    bankkeluarController.hitungSubTotal();
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
                  controller: uraianController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
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
                      bankkeluarController.data_hutang_keranjang[index].uraian =
                          uraianController.text;
                      // bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].uraian =
                        uraianController.text;
                    // bankkeluarController.hitungSubTotal();
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
                  controller: jumlahController,
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
                      bankkeluarController.data_hutang_keranjang[index].jumlah =
                          config().convert_rupiah(jumlahController.text);
                      bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].jumlah =
                        config().convert_rupiah(jumlahController.text);
                    bankkeluarController.hitungSubTotal();
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
                  controller: jumlahrpController,
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
                      bankkeluarController
                              .data_hutang_keranjang[index].jumlahrp =
                          config().convert_rupiah(jumlahrpController.text);
                      bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].jumlahrp =
                        config().convert_rupiah(jumlahrpController.text);
                    bankkeluarController.hitungSubTotal();
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
                  controller: umController,
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
                      bankkeluarController.data_hutang_keranjang[index].um =
                          config().convert_rupiah(umController.text);
                      bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].um =
                        config().convert_rupiah(umController.text);
                    bankkeluarController.hitungSubTotal();
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
                  controller: currController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "currency",
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
                      bankkeluarController.data_hutang_keranjang[index].curr =
                          currController.text;
                      // bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].curr =
                        currController.text;
                    // bankkeluarController.hitungSubTotal();
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
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: rateController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "0.00",
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
                      rateController.value = TextEditingValue(
                        text: config().format_rupiah(rateController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(rateController.text)
                                  .length),
                        ),
                      );
                      bankkeluarController.data_hutang_keranjang[index].rate =
                          config().convert_rupiah(rateController.text);
                      bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].rate =
                        config().convert_rupiah(rateController.text);
                    bankkeluarController.hitungSubTotal();
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
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: noinvController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    hintText: "invoice",
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
                      bankkeluarController.data_hutang_keranjang[index].noinv =
                          noinvController.text;
                      // bankkeluarController.hitungSubTotal();
                      bankkeluarController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankkeluarController.data_hutang_keranjang[index].noinv =
                        noinvController.text;
                    // bankkeluarController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              bankkeluarController.data_hutang_keranjang.removeAt(index);
              bankkeluarController.hitungSubTotal();
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
