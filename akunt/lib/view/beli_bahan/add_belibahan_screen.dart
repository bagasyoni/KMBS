import 'package:akunt/controller/master/operasional/supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/belibahan_controller.dart';
import 'package:akunt/view/beli_bahan/pilih_pobahan.dart';
import 'package:akunt/view/base_widget/save_success.dart';
import 'package:akunt/view/beli_bahan/widget/add_belibahan_card.dart';
import 'package:provider/provider.dart';
import 'widget/keterangan_umum.dart';
import 'widget/keterangan_sj_pajak.dart';

class AddBelibahanScreen extends StatefulWidget {
  bool isModeEdit;
  var data_edit;

  AddBelibahanScreen(this.isModeEdit, {this.data_edit});

  @override
  _AddBelibahanScreenState createState() => _AddBelibahanScreenState();
}

class _AddBelibahanScreenState extends State<AddBelibahanScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int menu_index = 0;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    if (widget.isModeEdit) {
      Provider.of<BelibahanController>(context, listen: false)
          .initData_editBelibahan(widget.data_edit);
    } else {
      Provider.of<BelibahanController>(context, listen: false)
          .initData_addBelibahan();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BelibahanController>(
        builder: (context, belibahanController, child) {
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
                    ? "Edit Pembelian Bahan"
                    : "Tambah Pembelian Bahan",
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
                    belibahanController.editBelibahan().then((value) {
                      if (value != null) {
                        if (value) {
                          Navigator.pop(context, true);
                        }
                      }
                    });
                  } else {
                    belibahanController.saveBelibahan().then((value) {
                      if (value != null) {
                        if (value) {
                          showAnimatedDialog_withCallBack(
                              context,
                              SaveSuccess("Success !!",
                                  "Berhasil menyimpan Purchase Order Bahan...!!"),
                              isFlip: true, callback: (value) {
                            if (value != null) {
                              if (value) {
                                belibahanController.initData_addBelibahan();
                                belibahanController.notifyListeners();
                              } else {
                                belibahanController.notifyListeners();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  color: Colors.white, // Tab Bar color change
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    controller: _tabController,
                    unselectedLabelColor: kPrimaryColor,
                    labelColor: Colors.black,
                    indicatorWeight: 2,
                    indicatorColor: HijauColor,
                    labelStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    tabs: <Widget>[
                      Tab(
                        text: "Main",
                      ),
                      Tab(
                        text: "Surat Jalan & Faktur Pajak",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    KeteranganUmum(context, belibahanController),
                    KeteranganSjPajak(context, belibahanController),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: GreyColor,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(flex: 20, child: SizedBox()),
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
                              text: belibahanController.sumQty.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 50,
                    // ),
                    Expanded(
                      flex: 1,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "Total : ",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: config().format_rupiah(
                              belibahanController.sumTotal.toString()),
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    /*
                    Expanded(
                      flex: 4,
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
                              text: config().format_rupiah(
                                  belibahanController.sumTotal.toString()),
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    */
                    Expanded(flex: 3, child: SizedBox()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(flex: 9, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      flex: 4,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "PPN : ",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                          children: [
                            TextSpan(
                              text: config().format_rupiah(
                                  belibahanController.ppn.toString()),
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: SizedBox()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Expanded(flex: 9, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      flex: 4,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "NETT : ",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                          children: [
                            TextSpan(
                              text: config().format_rupiah(
                                  belibahanController.nett.toString()),
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
