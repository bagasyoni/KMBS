import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/piu_controller.dart';
import 'package:akunt/model/data_jual.dart';
import 'package:provider/provider.dart';

Widget AddPiuCard(BuildContext context, int index, DataJual data_jual) {
  TextEditingController no_beliController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();
  TextEditingController totalController = new TextEditingController();
  TextEditingController bayarController = new TextEditingController();
  no_beliController.value = TextEditingValue(
    text: data_jual.no_bukti.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_jual.no_bukti.toString().length),
    ),
  );
  notesController.value = TextEditingValue(
    text: data_jual.notes.toString(),
    selection: TextSelection.fromPosition(
      TextPosition(offset: data_jual.notes.toString().length),
    ),
  );
  totalController.value = TextEditingValue(
    text: config().format_rupiah(data_jual.total.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_jual.total.toString()).length),
    ),
  );
  bayarController.value = TextEditingValue(
    text: config().format_rupiah(data_jual.bayar.toString()),
    selection: TextSelection.fromPosition(
      TextPosition(
          offset: config().format_rupiah(data_jual.bayar.toString()).length),
    ),
  );
  var piuController = Provider.of<PiuController>(context, listen: false);

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
              data_jual.no_bukti ?? "",
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
                      piuController.data_jual_keranjang[index].notes =
                          notesController.text;
                      piuController.notifyListeners();
                      piuController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    piuController.data_jual_keranjang[index].notes =
                        notesController.text;
                    piuController.hitungSubTotal();
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
                      piuController.data_jual_keranjang[index].total =
                          config().convert_rupiah(totalController.text);
                      piuController.notifyListeners();
                      piuController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    piuController.data_jual_keranjang[index].total =
                        config().convert_rupiah(totalController.text);
                    piuController.hitungSubTotal();
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
                      piuController.data_jual_keranjang[index].bayar =
                          config().convert_rupiah(bayarController.text);
                      piuController.notifyListeners();
                      piuController.hitungSubTotal();
                    }
                  },
                  onFieldSubmitted: (value) {
                    piuController.data_jual_keranjang[index].bayar =
                        config().convert_rupiah(bayarController.text);
                    piuController.hitungSubTotal();
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              piuController.data_jual_keranjang.removeAt(index);
              piuController.hitungSubTotal();
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
