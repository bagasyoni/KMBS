import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/transaksi/finansial/bankkeluar_controller.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Widget BankkCard(int index, {Function pressEdit, Function pressDelete}) {
  return Consumer<BankkController>(
      builder: (context, bankkeluarController, child) {
    var data_bankk = bankkeluarController.data_bankk_list[index];
    String nobukti = data_bankk['NO_BUKTI'];
    String tanggal =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(data_bankk['TGL']));
    String kodes = data_bankk['KODE'];
    String namas = data_bankk['NAMA'];
    String jumlah = config().format_rupiah(data_bankk['JUMLAH'].toString());
    String jumlahrp = config().format_rupiah(data_bankk['JUMLAH1'].toString());
    String bacno = data_bankk['BACNO'];
    String bnama = data_bankk['BNAMA'];
    bool isDelivered = data_bankk['POSTED'] == 1 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: () {
          bankkeluarController.index_terpilih = index;
          bankkeluarController.notifyListeners();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: (index == bankkeluarController.index_terpilih)
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
                        kodes,
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
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        namas,
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
                        jumlah.toString(),
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
                        jumlahrp.toString(),
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
                        bacno,
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
                        bnama,
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
                width: 10,
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
