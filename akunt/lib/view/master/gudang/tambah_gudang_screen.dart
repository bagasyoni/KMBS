import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/gudang_controller.dart';
import 'package:akunt/view/master/gudang/widget/keterangan_satu.dart';
import 'package:provider/provider.dart';

import 'widget/keterangan_dua.dart';

class TambahGudangScreen extends StatefulWidget {
  bool isModeEdit;
  var data_gudang;

  TambahGudangScreen({this.isModeEdit, this.data_gudang});

  @override
  _TambahGudangScreenState createState() => _TambahGudangScreenState();
}

class _TambahGudangScreenState extends State<TambahGudangScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int menu_index = 0;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    var m_gudang = Provider.of<GudangController>(context, listen: false);
    m_gudang.init_add_gudang().then((value) {
      if (widget.isModeEdit) {
        m_gudang.init_edit_gudang(widget.data_gudang);
      } else {
        m_gudang.resetField();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GudangController>(
        builder: (context, gudangController, child) {
      return Scaffold(
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
                (widget.isModeEdit) ? "Edit Gudang" : "Tambah Gudang",
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
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: EdgeInsets.only(left: 24, right: 24, top: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kode",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
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
                                            gudangController.kodeController,
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
                            Expanded(flex: 15, child: SizedBox()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24, top: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
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
                                            gudangController.namaController,
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
                            Expanded(flex: 15, child: SizedBox()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
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
                        text: "Keterangan Satu",
                      ),
                      Tab(
                        text: "Keterangan Dua",
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
                    KeteranganSatu(gudangController),
                    KeteranganDua(context, gudangController),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24, right: 23, top: 8, bottom: 16),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: GreyColor,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OnHoverButton(
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: GreyColor),
                            color: kBackgroundColor,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                          child: Text(
                            "Batal",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    OnHoverButton(
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HijauColor,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                          child: Text(
                            "Simpan",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (widget.isModeEdit) {
                            gudangController
                                .edit_gudang(widget.data_gudang['NO_ID'])
                                .then((value) {
                              if (value != null) {
                                if (value) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                          } else {
                            gudangController.daftar_gudang().then((value) {
                              if (value != null) {
                                if (value) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
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
