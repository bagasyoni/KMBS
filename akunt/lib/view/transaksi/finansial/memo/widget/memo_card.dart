import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/transaksi/finansial/memo_controller.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Widget MemoCard(int index, {Function pressEdit, Function pressDelete}) {
  return Consumer<MemoController>(builder: (context, memoController, child) {
    var data_memo = memoController.data_memo_list[index];
    String nobukti = data_memo['NO_BUKTI'];
    String tanggal =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(data_memo['TGL']));
    String curr = data_memo['CURR'];
    String rate = data_memo['RATE'].toString();
    String debet = config().format_rupiah(data_memo['DEBET'].toString());
    String kredit = config().format_rupiah(data_memo['KREDIT'].toString());
    String debetrp = config().format_rupiah(data_memo['DEBET1'].toString());
    String kreditrp = config().format_rupiah(data_memo['KREDIT1'].toString());
    bool isDelivered = data_memo['POSTED'] == 1 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: () {
          memoController.index_terpilih = index;
          memoController.notifyListeners();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: (index == memoController.index_terpilih)
                    ? HijauColor
                    : Colors.white),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        nobukti,
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        tanggal,
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        curr,
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        rate,
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        debet.toString(),
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        kredit.toString(),
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        debetrp,
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        kredit,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              if (Provider.of<LoginController>(context, listen: false)
                      .role_staff ==
                  1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OnHoverButton(
                    child: InkWell(
                      onTap: pressEdit,
                      child: Container(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/ic_edit.png",
                              height: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Edit",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                height: 40,
                width: 1,
                color: AbuColor,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: (isDelivered)
                    ? Image.asset(
                        "assets/images/ic_delivered.png",
                        height: 30,
                      )
                    : OnHoverButton(
                        child: InkWell(
                          onTap: (Provider.of<LoginController>(context,
                                          listen: false)
                                      .role_staff ==
                                  1)
                              ? pressDelete
                              : () {
                                  Toast("No Access", "", false);
                                },
                          child: Image.asset(
                            "assets/images/ic_hapus.png",
                            height: 30,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}
