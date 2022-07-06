import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/finansial/memo_controller.dart';
import 'package:akunt/model/master/finansial/data_account.dart';
import 'package:provider/provider.dart';

Widget AddMemoCard(BuildContext context, int index, DataAccount data_account) {
  TextEditingController nacnoController = new TextEditingController();
  TextEditingController jumlahController = new TextEditingController();
  TextEditingController jumlahrpController = new TextEditingController();
  TextEditingController reffController = new TextEditingController();
  TextEditingController dkController = new TextEditingController();
  // double subTotal = data_account.jumlah;
  nacnoController.value = TextEditingValue(
    text: data_account.nacno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.nacno.toString().length),
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
  jumlahrpController.value = TextEditingValue(
    text: config().format_rupiah(data_account.jumlah1.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_account.jumlah1.toString()).length),
    ),
  );
  reffController.value = TextEditingValue(
    text: data_account.reff ?? "",
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.reff.toString().length),
    ),
  );
  dkController.value = TextEditingValue(
    text: config().format_rupiah(data_account.dk.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_account.dk.toString()).length),
    ),
  );

  var memoController = Provider.of<MemoController>(context, listen: false);

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
                    data_account.acno ?? "",
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
                  readOnly: true,
                  controller: nacnoController,
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
                      memoController.data_account_keranjang[index].nacno =
                          nacnoController.text;
                      memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].nacno =
                        nacnoController.text;
                    memoController.hitungSubTotal();
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
                      memoController.data_account_keranjang[index].jumlah =
                          config().convert_rupiah(jumlahController.text);
                      memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].jumlah =
                        config().convert_rupiah(jumlahController.text);
                    memoController.hitungSubTotal();
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
                      memoController.data_account_keranjang[index].jumlah1 =
                          config().convert_rupiah(jumlahrpController.text);
                      memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].jumlah1 =
                        config().convert_rupiah(jumlahrpController.text);
                    memoController.hitungSubTotal();
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
                  controller: reffController,
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
                      memoController.data_account_keranjang[index].reff =
                          reffController.text;
                      // memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].reff =
                        reffController.text;
                    // memoController.hitungSubTotal();
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
                  controller: dkController,
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
                      dkController.value = TextEditingValue(
                        text: config().format_rupiah(dkController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(dkController.text)
                                  .length),
                        ),
                      );
                      memoController.data_account_keranjang[index].dk =
                          config().convert_rupiah(dkController.text);
                      memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].dk =
                        config().convert_rupiah(dkController.text);
                    memoController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              memoController.data_account_keranjang.removeAt(index);
              memoController.hitungSubTotal();
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
