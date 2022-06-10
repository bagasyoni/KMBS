import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/finansial/bankmasuk_controller.dart';
import 'package:akunt/model/master/finansial/data_account.dart';
import 'package:provider/provider.dart';

Widget AddBankMasukCard(
    BuildContext context, int index, DataAccount data_account) {
  TextEditingController nacnoController = new TextEditingController();
  TextEditingController no_fakturController = new TextEditingController();
  TextEditingController uraianController = new TextEditingController();
  TextEditingController jumlahinvController = new TextEditingController();
  TextEditingController jumlahController = new TextEditingController();
  TextEditingController jumlah1Controller = new TextEditingController();
  TextEditingController umController = new TextEditingController();
  TextEditingController currdController = new TextEditingController();
  TextEditingController ratedController = new TextEditingController();
  TextEditingController noinvController = new TextEditingController();
  // double jumlah = data_account.jumlah;
  // double jumlah1 = data_account.jumlah1;
  // double um = data_account.um;
  // double currd = data_account.currd;
  // double rated = data_account.rated;
  nacnoController.value = TextEditingValue(
    text: data_account.nacno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.nacno.toString().length),
    ),
  );
  no_fakturController.value = TextEditingValue(
    text: data_account.no_faktur ?? "",
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.no_faktur.toString().length),
    ),
  );
  uraianController.value = TextEditingValue(
    text: data_account.reff ?? "",
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.reff.toString().length),
    ),
  );
  noinvController.value = TextEditingValue(
    text: data_account.noinv ?? "",
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.noinv.toString().length),
    ),
  );
  jumlahinvController.value = TextEditingValue(
    text: config().format_rupiah(data_account.jumlahinv.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_account.jumlahinv.toString()).length),
    ),
  );
  jumlahController.value = TextEditingValue(
    text: config().format_rupiah(data_account.jumlah.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_account.jumlah.toString()).length),
    ),
  );
  jumlah1Controller.value = TextEditingValue(
    text: config().format_rupiah(data_account.jumlah1.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_account.jumlah1.toString()).length),
    ),
  );
  umController.value = TextEditingValue(
    text: config().format_rupiah(data_account.um.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_account.um.toString()).length),
    ),
  );
  currdController.value = TextEditingValue(
    text: config().format_rupiah(data_account.currd.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_account.currd.toString()).length),
    ),
  );
  ratedController.value = TextEditingValue(
    text: config().format_rupiah(data_account.rated.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_account.rated.toString()).length),
    ),
  );
  var bankmasukController =
      Provider.of<BankmController>(context, listen: false);

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
              data_account.acno ?? "",
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
                  readOnly: true,
                  controller: nacnoController,
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
                      bankmasukController.data_account_keranjang[index].nacno =
                          nacnoController.text;
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index].nacno =
                        nacnoController.text;
                    bankmasukController.hitungSubTotal();
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
                  controller: no_fakturController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "No Faktur",
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
                      bankmasukController.data_account_keranjang[index]
                          .no_faktur = no_fakturController.text;
                      // bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index]
                        .no_faktur = no_fakturController.text;
                    // bankmasukController.hitungSubTotal();
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
                    hintText: "Uraian",
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
                      bankmasukController.data_account_keranjang[index].reff =
                          uraianController.text;
                      // bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index].reff =
                        uraianController.text;
                    // bankmasukController.hitungSubTotal();
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
                  controller: jumlahinvController,
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
                      jumlahinvController.value = TextEditingValue(
                        text: config().format_rupiah(jumlahinvController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(jumlahinvController.text)
                                  .length),
                        ),
                      );
                      bankmasukController
                              .data_account_keranjang[index].jumlahinv =
                          config().convert_rupiah(jumlahinvController.text);
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController
                            .data_account_keranjang[index].jumlahinv =
                        config().convert_rupiah(jumlahinvController.text);
                    bankmasukController.hitungSubTotal();
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
                      bankmasukController
                              .data_account_keranjang[index].jumlah =
                          config().convert_rupiah(jumlahController.text);
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index].jumlah =
                        config().convert_rupiah(jumlahController.text);
                    bankmasukController.hitungSubTotal();
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
                  controller: jumlah1Controller,
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
                      jumlah1Controller.value = TextEditingValue(
                        text: config().format_rupiah(jumlah1Controller.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(jumlah1Controller.text)
                                  .length),
                        ),
                      );
                      bankmasukController
                              .data_account_keranjang[index].jumlah1 =
                          config().convert_rupiah(jumlah1Controller.text);
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index].jumlah1 =
                        config().convert_rupiah(jumlah1Controller.text);
                    bankmasukController.hitungSubTotal();
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
                      bankmasukController.data_account_keranjang[index].um =
                          config().convert_rupiah(umController.text);
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index].um =
                        config().convert_rupiah(umController.text);
                    bankmasukController.hitungSubTotal();
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
                  controller: currdController,
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
                      currdController.value = TextEditingValue(
                        text: config().format_rupiah(currdController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(currdController.text)
                                  .length),
                        ),
                      );
                      bankmasukController.data_account_keranjang[index].currd =
                          config().convert_rupiah(currdController.text);
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index].currd =
                        config().convert_rupiah(currdController.text);
                    bankmasukController.hitungSubTotal();
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
                  controller: ratedController,
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
                      ratedController.value = TextEditingValue(
                        text: config().format_rupiah(ratedController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(ratedController.text)
                                  .length),
                        ),
                      );
                      bankmasukController
                              .data_account_keranjang[index].rated =
                          config().convert_rupiah(ratedController.text);
                      bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController
                            .data_account_keranjang[index].rated =
                        config().convert_rupiah(ratedController.text);
                    bankmasukController.hitungSubTotal();
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
                    hintText: "No Invoice",
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
                      bankmasukController.data_account_keranjang[index]
                          .noinv = noinvController.text;
                      // bankmasukController.hitungSubTotal();
                      bankmasukController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    bankmasukController.data_account_keranjang[index]
                        .noinv = noinvController.text;
                    // bankmasukController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              bankmasukController.data_account_keranjang.removeAt(index);
              bankmasukController.hitungSubTotal();
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
