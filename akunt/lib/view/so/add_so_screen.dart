import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/so_controller.dart';
import 'package:akunt/model/master/operasional/data_brg.dart';
import 'package:akunt/view/so/pilih_customer.dart';
import 'package:akunt/view/base_widget/save_success.dart';
import 'package:akunt/view/so/widget/add_so_card.dart';
import 'package:provider/provider.dart';

class AddSoScreen extends StatefulWidget {
  bool isModeEdit;
  var data_edit;

  AddSoScreen(this.isModeEdit, {this.data_edit});

  @override
  _AddSoScreenState createState() => _AddSoScreenState();
}

class _AddSoScreenState extends State<AddSoScreen> {
  GlobalKey<AutoCompleteTextFieldState<DataBrg>> key = new GlobalKey();
  AutoCompleteTextField searchTextField;

  _AddSoScreenState();

  @override
  void initState() {
    if (widget.isModeEdit) {
      Provider.of<SoController>(context, listen: false)
          .initData_editSo(widget.data_edit);
    } else {
      Provider.of<SoController>(context, listen: false).initData_addSo();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SoController>(builder: (context, soController, child) {
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
                (widget.isModeEdit) ? "Edit Sales Order" : "Tambah Sales Order",
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
                    soController.editSo().then((value) {
                      if (value != null) {
                        if (value) {
                          Navigator.pop(context, true);
                        }
                      }
                    });
                  } else {
                    soController.saveSo().then((value) {
                      if (value != null) {
                        if (value) {
                          showAnimatedDialog_withCallBack(
                              context,
                              SaveSuccess("Success !!",
                                  "Berhasil menyimpan Sales Order...!!"),
                              isFlip: true, callback: (value) {
                            if (value != null) {
                              if (value) {
                                soController.initData_addSo();
                                soController.notifyListeners();
                              } else {
                                soController.notifyListeners();
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            soController.no_buktiController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: soController.tglController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                                          soController.chooseDate =
                                              await showDatePicker(
                                                      context: context,
                                                      initialDate: soController
                                                              .chooseDate ??
                                                          DateTime.now(),
                                                      lastDate: DateTime(2050),
                                                      firstDate: DateTime(
                                                          DateTime.now()
                                                              .year)) ??
                                                  soController.chooseDate;
                                          soController.tglController.text =
                                              soController.format_tanggal
                                                  .format(
                                                      soController.chooseDate);
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
                                      "Kode Customer",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            soController.kodecController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 15),
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
                                              PilihCustomer(
                                                  soController.kodecController
                                                          .text.isEmpty
                                                      ? null
                                                      : soController
                                                          .namacController.text,
                                                  soController),
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            soController.jtempoController,
                                        readOnly: widget.isModeEdit,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                                          soController.chooseDateJT =
                                              await showDatePicker(
                                                      context: context,
                                                      initialDate: soController
                                                              .chooseDateJT ??
                                                          DateTime.now(),
                                                      lastDate: DateTime(2050),
                                                      firstDate: DateTime(
                                                          DateTime.now()
                                                              .year)) ??
                                                  soController.chooseDateJT;
                                          soController.jtempoController.text =
                                              soController.format_jtempo.format(
                                                  soController.chooseDateJT);
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
                            const EdgeInsets.only(left: 24, right: 24, top: 30),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Customer",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            soController.namacController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                              flex: 3,
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            soController.alamatController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller: soController.kotaController,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                                      "Notes",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: GreyColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: TextFormField(
                                        controller:
                                            soController.notesController,
                                        readOnly: false,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18),
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
                        DataBrg db_item = new DataBrg(
                          noid: item.noid,
                          kd_brg: item.kd_brg,
                          na_brg: item.na_brg,
                          satuan: item.satuan,
                          ket: item.ket,
                          harga: item.harga,
                          qty: item.qty,
                          total: item.total,
                        );
                        searchTextField.textField.controller.clear();
                        soController.addKeranjang(db_item);
                      },
                      submitOnSuggestionTap: true,
                      clearOnSubmit: false,
                      key: key,
                      suggestions: soController.brgList,
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
                        return item.kd_brg
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
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
                    SizedBox(
                      width: 36,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: soController.data_brg_keranjang.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AddSoCard(
                        context, index, soController.data_brg_keranjang[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(flex: 6, child: SizedBox()),
              Expanded(
                flex: 2,
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: "Qty : ",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                    children: [
                      TextSpan(
                        text: soController.sumQty.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: "Total : ",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                    children: [
                      TextSpan(
                        text: config()
                            .format_rupiah(soController.sumTotal.toString()),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
