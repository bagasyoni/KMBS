import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/belimesin_controller.dart';
import 'package:akunt/view/base_widget/mode_export.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:akunt/view/beli_mesin/add_belimesin_screen.dart';
import 'package:akunt/view/beli_mesin/widget/belimesin_card.dart';
import 'package:provider/provider.dart';

import 'widget/filter_tanggal.dart';

class DataBelimesinScreen extends StatefulWidget {
  @override
  _BelimesinScreenState createState() => _BelimesinScreenState();
}

class _BelimesinScreenState extends State<DataBelimesinScreen> {
  @override
  void initState() {
    Provider.of<BelimesinController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BelimesinController>(
        builder: (context, belimesinController, child) {
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
                "Pembelian Mesin/Import",
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
            if (Provider.of<LoginController>(context, listen: false)
                    .role_staff ==
                1)
              OnHoverButton(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddBelimesinScreen(false)))
                        .then((value) {
                      if (value != null) {
                        if (value) {
                          belimesinController.select_data();
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/ic_add.png",
                          height: 30,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Tambah Baru",
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
            OnHoverButton(
              child: InkWell(
                hoverColor: Colors.white,
                onTap: () {
                  showAnimatedDialog_withCallBack(context, ModeExport(1),
                      isFlip: true, callback: (value) {
                    if (value != null) {
                      if (value == 1) {
                        belimesinController.proses_export_detail();
                      } else if (value == 2) {
                        belimesinController.proses_export();
                      }
                    }
                  });
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_download.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Export",
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
            OnHoverButton(
              child: InkWell(
                hoverColor: Colors.white,
                onTap: () {
                  if (belimesinController.index_terpilih != null) {
                    belimesinController.proses_print();
                  } else {
                    Toast(
                        "Peringatan",
                        "Silahkan pilih satu transaksi untuk di cetak !",
                        false);
                  }
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_print.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Cetak Invoice",
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
        backgroundColor: kBackgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 16, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: GreyColor,
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset:
                                  Offset(1, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ic_search.png",
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                width: 1,
                                height: 25,
                                color: GreyColor,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                child: TextField(
                                  controller:
                                      belimesinController.searchController,
                                  decoration: InputDecoration(
                                    hintText: "Cari Disini",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: GreyColor),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 14),
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    belimesinController.select_data();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          showAnimatedDialog_withCallBack(
                              context, FilterTanggal(), isFlip: true,
                              callback: (value) {
                            if (value != null) {
                              if (value) {
                                belimesinController.select_data();
                                belimesinController.notifyListeners();
                              } else {
                                belimesinController.notifyListeners();
                                Navigator.pop(context, true);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: GreyColor,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(1, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/ic_tanggal.png",
                                height: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  width: 1,
                                  height: 25,
                                  color: GreyColor,
                                ),
                              ),
                              Text(
                                belimesinController.range,
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
                  ],
                ),
              ),
              Expanded(
                child: (belimesinController.data_belimesin_list.length > 0)
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                        itemCount:
                            belimesinController.data_belimesin_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BelimesinCard(index, pressEdit: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddBelimesinScreen(
                                          true,
                                          data_edit: belimesinController
                                              .data_belimesin_list[index],
                                        ))).then((value) {
                              if (value != null) {
                                if (value) {
                                  belimesinController.select_data();
                                }
                              }
                            });
                          }, pressDelete: () {
                            showAnimatedDialog_withCallBack(
                                context, NotifHapus(), isFlip: true,
                                callback: (value) {
                              if (value != null) {
                                if (value) {
                                  belimesinController
                                      .deleteBelimesin(belimesinController
                                              .data_belimesin_list[index]
                                          ['NO_BUKTI'])
                                      .then((value) {
                                    if (value) {
                                      Toast("Delete Success !",
                                          "Berhasil menghapus data", true);
                                    } else {
                                      Toast("Delete Failed !",
                                          "Gagal menghapus data", false);
                                    }
                                    belimesinController.notifyListeners();
                                  });
                                }
                              }
                            });
                          });
                        })
                    : Container(
                        child: Center(
                          child: Text(
                            "Tidak ada data",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: GreyColor),
                          ),
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
