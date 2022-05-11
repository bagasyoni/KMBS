import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/sparepart_controller.dart';
import 'package:provider/provider.dart';

class TambahSparepartScreen extends StatefulWidget {
  bool isModeEdit;
  var data_sparepart;

  TambahSparepartScreen({this.isModeEdit, this.data_sparepart});

  @override
  _TambahSparepartScreenState createState() => _TambahSparepartScreenState();
}

class _TambahSparepartScreenState extends State<TambahSparepartScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int menu_index = 0;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    var m_sparepart = Provider.of<SparepartController>(context, listen: false);
    m_sparepart.init_add_sparepart().then((value) {
      if (widget.isModeEdit) {
        m_sparepart.init_edit_sparepart(widget.data_sparepart);
      } else {
        m_sparepart.resetField();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SparepartController>(
        builder: (context, sparepartController, child) {
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
                (widget.isModeEdit) ? "Edit Sparepart" : "Tambah Sparepart",
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
          child: new SingleChildScrollView(
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
                          padding:
                              EdgeInsets.only(left: 24, right: 24, top: 16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kode Barang",
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: TextFormField(
                                          controller: sparepartController
                                              .kdbhnController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 18, bottom: 18),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
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
                              Expanded(flex: 25, child: SizedBox()),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 24, right: 24, top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama Barang",
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: TextFormField(
                                          controller: sparepartController
                                              .nabhnController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 18, bottom: 18),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
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
                              Expanded(flex: 25, child: SizedBox()),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 24, right: 24, top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Satuan",
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: TextFormField(
                                          controller: sparepartController
                                              .satuanController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 18, bottom: 18),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
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
                              Expanded(flex: 30, child: SizedBox()),
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
              ],
            ),
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
                            sparepartController
                                .edit_sparepart(widget.data_sparepart['NO_ID'])
                                .then((value) {
                              if (value != null) {
                                if (value) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                          } else {
                            sparepartController.daftar_sparepart().then((value) {
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
