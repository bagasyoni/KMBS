import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/memo_controller.dart';
import 'package:akunt/model/data_account.dart';
import 'package:provider/provider.dart';

Widget AddMemoCard(BuildContext context, int index, DataAccount data_account) {
  TextEditingController acnoController = new TextEditingController();
  TextEditingController nacnoController = new TextEditingController();
  TextEditingController reffController = new TextEditingController();
  TextEditingController debetController = new TextEditingController();
  TextEditingController kreditController = new TextEditingController();
  acnoController.value = TextEditingValue(
    text: data_account.acno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.acno.toString().length),
    ),
  );
  nacnoController.value = TextEditingValue(
    text: data_account.nacno.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.nacno.toString().length),
    ),
  );
  reffController.value = TextEditingValue(
    text: data_account.reff ?? "",
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_account.reff.toString().length),
    ),
  );
  debetController.value = TextEditingValue(
    text: config().format_rupiah(data_account.debet.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_account.debet.toString()).length),
    ),
  );
  kreditController.value = TextEditingValue(
    text: config().format_rupiah(data_account.kredit.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset:
              config().format_rupiah(data_account.kredit.toString()).length),
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
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: reffController,
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
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller: debetController,
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
                      debetController.value = TextEditingValue(
                        text: config().format_rupiah(debetController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(debetController.text)
                                  .length),
                        ),
                      );
                      memoController.data_account_keranjang[index].debet =
                          config().convert_rupiah(debetController.text);
                      memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].debet =
                        config().convert_rupiah(debetController.text);
                    memoController.hitungSubTotal();
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
                  controller: kreditController,
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
                      kreditController.value = TextEditingValue(
                        text: config().format_rupiah(kreditController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(kreditController.text)
                                  .length),
                        ),
                      );
                      memoController.data_account_keranjang[index].kredit =
                          config().convert_rupiah(kreditController.text);
                      memoController.hitungSubTotal();
                      memoController.notifyListeners();
                    }
                  },
                  onFieldSubmitted: (value) {
                    memoController.data_account_keranjang[index].kredit =
                        config().convert_rupiah(kreditController.text);
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
