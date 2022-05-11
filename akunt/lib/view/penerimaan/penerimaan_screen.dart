import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/penerimaan_controller.dart';
import 'package:akunt/view/base_widget/mode_export.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:akunt/view/penerimaan/add_penerimaan_screen.dart';
import 'package:akunt/view/penerimaan/widget/penerimaan_card.dart';
import 'package:provider/provider.dart';

import 'widget/filter_tanggal.dart';

class PenerimaanScreen extends StatefulWidget {
  @override
  _PenerimaanScreenScreenState createState() => _PenerimaanScreenScreenState();
}

class _PenerimaanScreenScreenState extends State<PenerimaanScreen> {
  @override
  void initState() {
    Provider.of<PenerimaanController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PenerimaanController>(
        builder: (context, terimaController, child) {
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
                "Penerimaan Barang",
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
                    .role_staff !=
                2)
              OnHoverButton(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddPenerimaanScreeen(false)))
                        .then((value) {
                      if (value != null) {
                        if (value) {
                          terimaController.select_data(false);
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
                  showAnimatedDialog_withCallBack(context, ModeExport(0),
                      isFlip: true, callback: (value) {
                    if (value != null) {
                      if (value == 1) {
                        terimaController.proses_export_detail();
                      } else if (value == 2) {
                        terimaController.proses_export();
                      } else if (value == 3) {
                        terimaController.proses_to_export_screen(context);
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
                  if (terimaController.index_terpilih != null) {
                    terimaController.proses_print();
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
                                  controller: terimaController.searchController,
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
                                    terimaController.select_data(false);
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
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                            InkWell(
                              onTap: () {
                                showAnimatedDialog_withCallBack(
                                    context, FilterTanggal(), isFlip: true,
                                    callback: (value) {
                                  if (value != null) {}
                                });
                              },
                              child: Image.asset(
                                "assets/images/ic_tanggal.png",
                                height: 25,
                              ),
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
                                      terimaController.filterTanggalController,
                                  decoration: InputDecoration(
                                    hintText: "01/01/2021 - 01/12/2021",
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
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      try {
                                        var tanggal = value.split("-");
                                        terimaController.tanggal_awal =
                                            tanggal[0]
                                                .toString()
                                                .replaceAll("/", "-")
                                                .replaceAll(" ", "");
                                        terimaController.tanggal_akhir =
                                            tanggal[1]
                                                .toString()
                                                .replaceAll("/", "-")
                                                .replaceAll(" ", "");
                                        terimaController.select_data(false);
                                      } catch (e) {
                                        Toast(
                                            "Error",
                                            "Format filter tanggal tidak valid",
                                            false);
                                      }
                                    } else {
                                      Toast(
                                          "Error",
                                          "Silahkan pilih filter tanggal !",
                                          false);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Container(
                          height: 45,
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                iconEnabledColor: HijauColor,
                                value: terimaController.filter_supplier,
                                items: terimaController
                                    .dropdownList_filter_supplier,
                                onChanged: (value) {
                                  if (value != null) {
                                    terimaController.filter_supplier = value;
                                    terimaController.select_data(false);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: (terimaController.data_penerimaan_list.length > 0)
                    ? ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, bottom: 16, top: 8),
                        itemCount: terimaController.data_penerimaan_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          //   return PenerimaanCard(context, index,
                          //       terimaController.data_penerimaan_list[index]);
                          // })
                          return PenerimaanCard(index, pressEdit: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddPenerimaanScreeen(
                                          true,
                                          data_edit: terimaController
                                              .data_penerimaan_list[index],
                                        ))).then((value) {
                              if (value != null) {
                                if (value) {
                                  terimaController.select_data(false);
                                }
                              }
                            });
                          }, pressDelete: () {
                            showAnimatedDialog_withCallBack(
                                context, NotifHapus(), isFlip: true,
                                callback: (value) {
                              if (value != null) {
                                if (value) {
                                  terimaController
                                      .deletePenerimaan(terimaController
                                              .data_penerimaan_list[index]
                                          ['NO_BUKTI'])
                                      .then((value) {
                                    if (value) {
                                      Toast("Delete Success !",
                                          "Berhasil menghapus data", true);
                                    } else {
                                      Toast("Delete Failed !",
                                          "Gagal menghapus data", false);
                                    }
                                    terimaController.notifyListeners();
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
        /*
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: GreyColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: "Jumlah Transaksi : ",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: terimaController.data_penerimaan_list.length
                          .toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 20,
                  width: 1,
                  color: GreyColor,
                ),
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
                      text: config().format_rupiah(
                          terimaController.total_pengeluaran.toString()),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
*/

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
                if (terimaController.data_penerimaan_list.length > 0)
                  Text(
                    (terimaController.offset + 1 <
                            terimaController.totalNotaTerima)
                        ? "Showing ${terimaController.offset + 1} to ${terimaController.offset + terimaController.limit} of ${terimaController.totalNotaTerima} entries"
                        : "Showing ${terimaController.offset + 1} to ${terimaController.totalNotaTerima} of ${terimaController.totalNotaTerima} entries",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                if (terimaController.data_penerimaan_list.length > 0)
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
                            value: terimaController.limit,
                            items: terimaController.dropdownLimit,
                            onChanged: (value) {
                              if (value != null) {
                                terimaController.limit = value;
                                terimaController.select_data(false);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: "Jumlah Transaksi : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: terimaController.data_penerimaan_list.length
                            .toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 20,
                    width: 1,
                    color: GreyColor,
                  ),
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
                        text: config().format_rupiah(
                            terimaController.total_pengeluaran.toString()),
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
                    if (terimaController.page_index > 0) {
                      terimaController.offset -= terimaController.limit;
                      terimaController.page_index--;
                      terimaController.c_page.text =
                          (terimaController.page_index + 1).toString();
                      terimaController.select_data(false);
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
                            color: (terimaController.offset == 0)
                                ? GreyColor
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                pageField(),
                InkWell(
                  onTap: () {
                    if (terimaController.page_index <=
                        terimaController.pageCount - 1) {
                      terimaController.offset += terimaController.limit;
                      terimaController.page_index++;
                      terimaController.c_page.text =
                          (terimaController.page_index + 1).toString();
                      terimaController.select_data(false);
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
                            color: ((terimaController.pageCount -
                                        terimaController.page_index) <=
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
    PenerimaanController pageTerima =
        Provider.of<PenerimaanController>(context, listen: false);
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
            pageTerima.select_data(false);
          } else if (index < pageTerima.page_index) {
            pageTerima.offset = (index * pageTerima.limit);
            pageTerima.page_index = index;
            pageTerima.c_page.text = (pageTerima.page_index + 1).toString();
            pageTerima.select_data(false);
          }
        },
      ),
    );
  }
}
