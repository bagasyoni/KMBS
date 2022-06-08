import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/transaksi/operasional/pobaranglokal_controller.dart';
import 'package:akunt/view/base_widget/mode_export.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_lokal/add_pobaranglokal_screen.dart';
import 'package:akunt/view/transaksi/operasional/po_barang_lokal/widget/pobaranglokal_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'widget/filter_tanggal.dart';

class DataPobaranglokalScreen extends StatefulWidget {
  @override
  _PobaranglokalScreenState createState() => _PobaranglokalScreenState();
}

class _PobaranglokalScreenState extends State<DataPobaranglokalScreen> {
  var komes = NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    Provider.of<PobaranglokalController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PobaranglokalController>(
        builder: (context, pobaranglokalController, child) {
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
                "Purchase Order Barang Lokal",
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
                                builder: (_) => AddPobaranglokalScreen(false)))
                        .then((value) {
                      if (value != null) {
                        if (value) {
                          pobaranglokalController.select_data();
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
                        pobaranglokalController.proses_export_detail();
                      } else if (value == 2) {
                        pobaranglokalController.proses_export();
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
                  if (pobaranglokalController.index_terpilih != null) {
                    pobaranglokalController.proses_print();
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
                                      pobaranglokalController.searchController,
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
                                    pobaranglokalController.select_data();
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
                                pobaranglokalController.select_data();
                                pobaranglokalController.notifyListeners();
                              } else {
                                pobaranglokalController.notifyListeners();
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
                                pobaranglokalController.range,
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
                child: (pobaranglokalController.data_pobarang_list.length > 0)
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                        itemCount:
                            pobaranglokalController.data_pobarang_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PobarangCard(index, pressEdit: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddPobaranglokalScreen(
                                          true,
                                          data_edit: pobaranglokalController
                                              .data_pobarang_list[index],
                                        ))).then((value) {
                              if (value != null) {
                                if (value) {
                                  pobaranglokalController.select_data();
                                }
                              }
                            });
                          }, pressDelete: () {
                            showAnimatedDialog_withCallBack(
                                context, NotifHapus(), isFlip: true,
                                callback: (value) {
                              if (value != null) {
                                if (value) {
                                  pobaranglokalController
                                      .deletePobarang(pobaranglokalController
                                          .data_pobarang_list[index]['NO_BUKTI'])
                                      .then((value) {
                                    if (value) {
                                      Toast("Delete Success !",
                                          "Berhasil menghapus data", true);
                                    } else {
                                      Toast("Delete Failed !",
                                          "Gagal menghapus data", false);
                                    }
                                    pobaranglokalController.notifyListeners();
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
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: GreyColor,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (pobaranglokalController.data_pobarang_list.length > 0)
                  Text(
                    (pobaranglokalController.offset + 1 <
                            pobaranglokalController.totalNotaTerima)
                        ? "Showing ${pobaranglokalController.offset + 1} to ${pobaranglokalController.offset + pobaranglokalController.limit} of ${pobaranglokalController.totalNotaTerima} entries"
                        : "Showing ${pobaranglokalController.offset + 1} to ${pobaranglokalController.totalNotaTerima} of ${pobaranglokalController.totalNotaTerima} entries",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                if (pobaranglokalController.data_pobarang_list.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: GreyColor,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(1, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            iconEnabledColor: HijauColor,
                            value: pobaranglokalController.limit,
                            items: pobaranglokalController.dropdownLimit,
                            onChanged: (value) {
                              if (value != null) {
                                pobaranglokalController.limit = value;
                                pobaranglokalController.select_data();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                SizedBox(
                  width: 500,
                ),
                RichText(
                  text: TextSpan(
                    text: "Total Qty : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: pobaranglokalController.qty.toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                RichText(
                  text: TextSpan(
                    text: "Total Pengeluaran : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: komes.format(pobaranglokalController.total),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (pobaranglokalController.page_index > 0) {
                      pobaranglokalController.offset -=
                          pobaranglokalController.limit;
                      pobaranglokalController.page_index--;
                      pobaranglokalController.c_page.text =
                          (pobaranglokalController.page_index + 1).toString();
                      pobaranglokalController.select_data();
                    }
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: GreyColor,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(
                      child: Text(
                        "Previous",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: (pobaranglokalController.offset == 0)
                                ? GreyColor
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                pageField(),
                InkWell(
                  onTap: () {
                    if (pobaranglokalController.page_index <=
                        pobaranglokalController.pageCount - 1) {
                      pobaranglokalController.offset +=
                          pobaranglokalController.limit;
                      pobaranglokalController.page_index++;
                      pobaranglokalController.c_page.text =
                          (pobaranglokalController.page_index + 1).toString();
                      pobaranglokalController.select_data();
                    }
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: GreyColor,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ((pobaranglokalController.pageCount -
                                        pobaranglokalController.page_index) <=
                                    1)
                                ? GreyColor
                                : Colors.black),
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

  Widget pageField() {
    PobaranglokalController pageTerima =
        Provider.of<PobaranglokalController>(context, listen: false);
    return Container(
      width: 70,
      height: 35,
      child: TextField(
        textAlign: TextAlign.center,
        controller: pageTerima.c_page,
        decoration: InputDecoration(
          hintText: "1",
          hintStyle: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, color: GreyColor),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        onSubmitted: (value) {
          int index = 1;
          try {
            index = int.parse(value.trim());
          } catch (e) {
            index = 1;
          }
          if (index == 0) {
            index = 1;
          } else {
            if (index > 0) {
              index = index - 1;
            }
          }
          if (index > pageTerima.page_index) {
            pageTerima.offset = (index * pageTerima.limit);
            pageTerima.page_index = index;
            pageTerima.c_page.text = (pageTerima.page_index + 1).toString();
            pageTerima.select_data();
          } else if (index < pageTerima.page_index) {
            pageTerima.offset = (index * pageTerima.limit);
            pageTerima.page_index = index;
            pageTerima.c_page.text = (pageTerima.page_index + 1).toString();
            pageTerima.select_data();
          }
        },
      ),
    );
  }
}
