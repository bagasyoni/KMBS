import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/hutbahan_controller.dart';
import 'package:akunt/model/data_beli.dart';
import 'package:provider/provider.dart';

Widget AddHutbahanCard(BuildContext context, int index, DataBeli data_beli) {
  TextEditingController no_beliController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();
  TextEditingController totalController = new TextEditingController();
  TextEditingController sisaController = new TextEditingController();
  TextEditingController bayarController = new TextEditingController();
  no_beliController.value = TextEditingValue(
    text: data_beli.no_bukti.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_beli.no_bukti.toString().length),
    ),
  );
  notesController.value = TextEditingValue(
    text: data_beli.notes.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_beli.notes.toString().length),
    ),
  );
  totalController.value = TextEditingValue(
    text: config().format_rupiah(data_beli.total.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_beli.total.toString()).length),
    ),
  );
  sisaController.value = TextEditingValue(
    text: config().format_rupiah(data_beli.sisa.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_beli.sisa.toString()).length),
    ),
  );
  bayarController.value = TextEditingValue(
    text: config().format_rupiah(data_beli.bayar.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_beli.bayar.toString()).length),
    ),
  );
  var hutbahanController =
      Provider.of<HutbahanController>(context, listen: false);

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
              data_beli.no_bukti ?? "",
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
                  controller: notesController,
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
                      notesController.value = TextEditingValue(
                        text: notesController.text,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: notesController.text.length),
                        ),
                      );
                      hutbahanController.data_beli_keranjang[index].notes =
                          notesController.text;
                      hutbahanController.notifyListeners();
                      hutbahanController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    hutbahanController.data_beli_keranjang[index].notes =
                        notesController.text;
                    hutbahanController.hitungSubTotal();
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
                  controller: totalController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Total",
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
                      totalController.value = TextEditingValue(
                        text: config().format_rupiah(totalController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(totalController.text)
                                  .length),
                        ),
                      );
                      hutbahanController.data_beli_keranjang[index].total =
                          config().convert_rupiah(totalController.text);
                      hutbahanController.notifyListeners();
                      hutbahanController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    hutbahanController.data_beli_keranjang[index].total =
                        config().convert_rupiah(totalController.text);
                    hutbahanController.hitungSubTotal();
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
                  controller: sisaController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Sisa",
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
                      sisaController.value = TextEditingValue(
                        text: config().format_rupiah(sisaController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(sisaController.text)
                                  .length),
                        ),
                      );
                      hutbahanController.data_beli_keranjang[index].sisa =
                          config().convert_rupiah(sisaController.text);
                      hutbahanController.notifyListeners();
                      hutbahanController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    hutbahanController.data_beli_keranjang[index].sisa =
                        config().convert_rupiah(sisaController.text);
                    hutbahanController.hitungSubTotal();
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
                  controller: bayarController,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 16),
                    hintText: "Bayar",
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
                      bayarController.value = TextEditingValue(
                        text: config().format_rupiah(bayarController.text),
                        selection: TextSelection.fromPosition(
                          TextPosition(
                              offset: config()
                                  .format_rupiah(bayarController.text)
                                  .length),
                        ),
                      );
                      hutbahanController.data_beli_keranjang[index].bayar =
                          config().convert_rupiah(bayarController.text);
                      hutbahanController.notifyListeners();
                      hutbahanController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    hutbahanController.data_beli_keranjang[index].bayar =
                        config().convert_rupiah(bayarController.text);
                    hutbahanController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              hutbahanController.data_beli_keranjang.removeAt(index);
              hutbahanController.hitungSubTotal();
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
