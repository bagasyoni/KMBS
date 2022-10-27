import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/transaksi/operasional/pobarangimport_controller.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_import/pilih_currency.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_import/pilih_supplier.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_import/pilih_account.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_import/pilih_brand.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_import/widget/add_pobarangimport_card.dart';
import 'package:akunt/view/base_widget/save_success.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPobarangimportScreen extends StatefulWidget {
  bool isModeEdit;
  var data_edit;

  AddPobarangimportScreen(this.isModeEdit, {this.data_edit});

  @override
  _AddPobarangScreenState createState() => _AddPobarangScreenState();
}

class _AddPobarangScreenState extends State<AddPobarangimportScreen> {
  GlobalKey<AutoCompleteTextFieldState<DataBrg>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;
  var f = NumberFormat("#,##0.00", "en_US");

  _AddPobarangScreenState();

  @override
  void initState() {
    if (widget.isModeEdit) {
      Provider.of<PobarangimportController>(context, listen: false)
          .initData_editPobarang(widget.data_edit);
    } else {
      Provider.of<PobarangimportController>(context, listen: false)
          .initData_addPobarang();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PobarangimportController>(
        builder: (context, pobarangimportController, child) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              Container(
                height: 25,
                width: 1,
                color: AbuColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                (widget.isModeEdit)
                    ? "Edit Purchase Order Barang Import"
                    : "Tambah Purchase Order Barang Import",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/ic_back.png",
              height: 30,
            ),
          ),
          actions: [
            OnHoverButton(
              child: InkWell(
                onTap: () {
                  if (widget.isModeEdit) {
                    pobarangimportController.editPobarang().then((value) {
                      if (value != null) {
                        if (value) {
                          Navigator.pop(context, true);
                        }
                      }
                    });
                  } else {
                    pobarangimportController.savePobarang().then((value) {
                      if (value != null) {
                        if (value) {
                          showAnimatedDialog_withCallBack(
                              context,
                              SaveSuccess("Success !!",
                                  "Berhasil menyimpan Purchase Order Barang Import...!!"),
                              isFlip: true, callback: (value) {
                            if (value != null) {
                              if (value) {
                                pobarangimportController.initData_addPobarang();
                                pobarangimportController.notifyListeners();
                              } else {
                                pobarangimportController.notifyListeners();
                                Navigator.pop(context, true);
                              }
                            }
                          });
                        }
                      }
                    });
                  }
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_save.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Simpan",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, right: 23, top: 16),
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No. Bukti",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .no_buktiController,
                                        // readOnly: widget.isModeEdit,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Supplier",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .kodesController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 12, bottom: 15),
                                          hintText: "Cari Supplier",
                                          hintStyle: GoogleFonts.poppins(
                                              color: GreyColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                          icon: Image.asset(
                                            "assets/images/ic_search.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onTap: () {
                                          showAnimatedDialog(
                                              context,
                                              PilihSupplier(
                                                  pobarangimportController
                                                          .kodesController
                                                          .text
                                                          .isEmpty
                                                      ? null
                                                      : pobarangimportController
                                                          .namasController.text,
                                                  pobarangimportController),
                                              isFlip: false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Acno",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .acno1Controller,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 12, bottom: 15),
                                          hintText: "Cari Acno",
                                          hintStyle: GoogleFonts.poppins(
                                              color: GreyColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                          icon: Image.asset(
                                            "assets/images/ic_search.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onTap: () {
                                          showAnimatedDialog(
                                              context,
                                              PilihAccount(
                                                  pobarangimportController
                                                          .acno1Controller
                                                          .text
                                                          .isEmpty
                                                      ? null
                                                      : pobarangimportController
                                                          .acno1_nmController
                                                          .text,
                                                  pobarangimportController),
                                              isFlip: false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tanggal",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .tglController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          icon: Image.asset(
                                            "assets/images/ic_tanggal.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onTap: () async {
                                          pobarangimportController
                                              .chooseDate = await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      pobarangimportController
                                                              .chooseDate ??
                                                          DateTime.now(),
                                                  lastDate: DateTime(2050),
                                                  firstDate: DateTime(
                                                      DateTime.now().year)) ??
                                              pobarangimportController
                                                  .chooseDate;
                                          pobarangimportController
                                                  .tglController.text =
                                              pobarangimportController
                                                  .format_tanggal
                                                  .format(
                                                      pobarangimportController
                                                          .chooseDate);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jatuh Tempo",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .jtempoController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          icon: Image.asset(
                                            "assets/images/ic_tanggal.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onTap: () async {
                                          pobarangimportController
                                              .chooseDateJT = await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      pobarangimportController
                                                              .chooseDateJT ??
                                                          DateTime.now(),
                                                  lastDate: DateTime(2050),
                                                  firstDate: DateTime(
                                                      DateTime.now().year)) ??
                                              pobarangimportController
                                                  .chooseDateJT;
                                          pobarangimportController
                                                  .jtempoController.text =
                                              pobarangimportController
                                                  .format_tanggal
                                                  .format(
                                                      pobarangimportController
                                                          .chooseDateJT);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Supplier",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .namasController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          icon: Image.asset(
                                            "assets/images/ic_user_warna.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .acno1_nmController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          icon: Image.asset(
                                            "assets/images/ic_user_warna.png",
                                            height: 20,
                                          ),
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Uang",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        // color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .currController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 12, bottom: 15),
                                          hintText: "Pilih Uang",
                                          hintStyle: GoogleFonts.poppins(
                                              color: GreyColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                          icon: Image.asset(
                                            "assets/images/ic_search.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onTap: () {
                                          showAnimatedDialog(
                                              context,
                                              PilihCurrency(
                                                  pobarangimportController
                                                          .currController
                                                          .text
                                                          .isEmpty
                                                      ? null
                                                      : pobarangimportController
                                                          .currnmController
                                                          .text,
                                                  pobarangimportController),
                                              isFlip: false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .currnmController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 1, bottom: 16),
                                          icon: Image.asset(
                                            "assets/images/ic_user_warna.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alamat",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .alamatController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Brand",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .brandController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 14),
                                          hintText: "Cari Brand",
                                          hintStyle: GoogleFonts.poppins(
                                              color: GreyColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                          icon: Image.asset(
                                            "assets/images/ic_search.png",
                                            height: 20,
                                          ),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onTap: () {
                                          showAnimatedDialog(
                                              context,
                                              PilihBrand(
                                                  pobarangimportController
                                                          .brandController
                                                          .text
                                                          .isEmpty
                                                      ? null
                                                      : pobarangimportController
                                                          .brandController.text,
                                                  pobarangimportController),
                                              isFlip: false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 10, bottom: 26),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rate",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .rateController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                        onChanged: (numb) {
                                          if (numb.isNotEmpty) {
                                            PobarangimportController.rate =
                                                config().convert_rupiah(
                                                    pobarangimportController
                                                        .rateController.text);
                                            pobarangimportController
                                                .hitungSubTotal();
                                          }
                                        },
                                        onFieldSubmitted: (value) {
                                          PobarangimportController.rate =
                                              config().convert_rupiah(
                                                  pobarangimportController
                                                      .rateController.text);
                                          pobarangimportController
                                              .hitungSubTotal();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rate Kesepakatan",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .rateksController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kota",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .kotaController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 1, bottom: 16),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Keterangan",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: pobarangimportController
                                            .notesController,
                                        readOnly: false,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 18),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24, top: 8),
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: searchTextField = AutoCompleteTextField<DataBrg>(
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        icon: Image.asset(
                          "assets/images/ic_search.png",
                          height: 25,
                        ),
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        filled: true,
                        hintText: "Cari disini",
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
                      itemSubmitted: (item) {
                        DataBrg db_item = DataBrg(
                            noid: item.noid,
                            kd_brg: item.kd_brg,
                            na_brg: item.na_brg,
                            satuan: item.satuan,
                            ket: item.ket,
                            harga: item.harga,
                            qty: item.qty,
                            total: item.total,
                            total1: item.total1);
                        searchTextField.textField.controller.clear();
                        pobarangimportController.addKeranjang(db_item);
                      },
                      submitOnSuggestionTap: true,
                      clearOnSubmit: false,
                      key: key,
                      suggestions: pobarangimportController.brgList,
                      itemBuilder: (context, item) {
                        return Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        item.kd_brg,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        item.na_brg,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: GreyColor,
                                height: 1,
                              ),
                            ],
                          ),
                        );
                      },
                      itemSorter: (a, b) {
                        return a.na_brg.compareTo(b.na_brg);
                      },
                      itemFilter: (item, query) {
                        return item.na_brg
                            .toLowerCase()
                            .contains(query.toLowerCase());
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "No.",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Kode Barang",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Nama Barang",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Satuan",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Keterangan",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Harga",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Qty",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Total",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Total (Rp)",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      width: 36,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView.builder(
                        itemCount:
                            pobarangimportController.data_brg_keranjang.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AddPobarangCard(
                              context,
                              index,
                              pobarangimportController
                                  .data_brg_keranjang[index]);
                        },
                      ),
                    )),
              ),
              Container(
                height: 235,
                decoration: BoxDecoration(
                    border: Border.all(color: GreyColor), color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 2),
                      child: Row(
                        children: [
                          Expanded(flex: 5, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Total Qty",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  pobarangimportController.sumQty.toString(),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Total",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumTotal),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Total",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumTotal1),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 36,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 10, bottom: 2),
                      child: Row(
                        children: [
                          Expanded(flex: 11, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Disc",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller:
                                    pobarangimportController.discController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  // WhitelistingTextInputFormatter(
                                  //     RegExp("[0-9]")),
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 12, bottom: 13),
                                  hintStyle: GoogleFonts.poppins(
                                      color: GreyColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  hintText: "%",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onChanged: (numb) {
                                  if (numb.isNotEmpty) {
                                    pobarangimportController.disc = config()
                                        .convert_rupiah(pobarangimportController
                                            .discController.text);
                                    pobarangimportController.hitungSubTotal();
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  pobarangimportController.disc = config()
                                      .convert_rupiah(pobarangimportController
                                          .discController.text);
                                  pobarangimportController.hitungSubTotal();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumDisc),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Disc",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller:
                                    pobarangimportController.disc1Controller,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  // WhitelistingTextInputFormatter(
                                  //     RegExp("[0-9]")),
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 12, bottom: 13),
                                  hintStyle: GoogleFonts.poppins(
                                      color: GreyColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  hintText: "%",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onChanged: (numb) {
                                  if (numb.isNotEmpty) {
                                    pobarangimportController.disc1 = config()
                                        .convert_rupiah(pobarangimportController
                                            .disc1Controller.text);
                                    pobarangimportController.hitungSubTotal();
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  pobarangimportController.disc1 = config()
                                      .convert_rupiah(pobarangimportController
                                          .disc1Controller.text);
                                  pobarangimportController.hitungSubTotal();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumDisc1),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 36,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 10, bottom: 2),
                      child: Row(
                        children: [
                          Expanded(flex: 11, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "PPN",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller:
                                    pobarangimportController.ppnController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 12, bottom: 13),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  hintText: "11.00",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumPPN),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "PPN",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller:
                                    pobarangimportController.ppn1Controller,
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 12, bottom: 13),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  hintText: "11.00",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumPPN1),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 36,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 10, bottom: 2),
                      child: Row(
                        children: [
                          Expanded(flex: 11, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "PPH",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller:
                                    pobarangimportController.pphController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  // WhitelistingTextInputFormatter(
                                  //     RegExp("[0-9]")),
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 12, bottom: 13),
                                  hintStyle: GoogleFonts.poppins(
                                      color: GreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  hintText: "%",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onChanged: (numb) {
                                  if (numb.isNotEmpty) {
                                    pobarangimportController.pph = config()
                                        .convert_rupiah(pobarangimportController
                                            .pphController.text);
                                    pobarangimportController.hitungSubTotal();
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  pobarangimportController.pph = config()
                                      .convert_rupiah(pobarangimportController
                                          .pphController.text);
                                  pobarangimportController.hitungSubTotal();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumPPH),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "PPH",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                textAlign: TextAlign.right,
                                controller:
                                    pobarangimportController.pph1Controller,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  // WhitelistingTextInputFormatter(
                                  //     RegExp("[0-9]")),
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 12, bottom: 13),
                                  hintStyle: GoogleFonts.poppins(
                                      color: GreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  hintText: "%",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                onChanged: (numb) {
                                  if (numb.isNotEmpty) {
                                    pobarangimportController.pph1 = config()
                                        .convert_rupiah(pobarangimportController
                                            .pph1Controller.text);
                                    pobarangimportController.hitungSubTotal();
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  pobarangimportController.pph1 = config()
                                      .convert_rupiah(pobarangimportController
                                          .pph1Controller.text);
                                  pobarangimportController.hitungSubTotal();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumPPH1),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 36,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 10, bottom: 2),
                      child: Row(
                        children: [
                          Expanded(flex: 11, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Nett",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumNett),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Nett",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: GreyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8, right: 8, top: 6),
                                child: Text(
                                  f.format(pobarangimportController.sumNett1),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 36,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
