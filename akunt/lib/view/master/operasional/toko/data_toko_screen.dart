import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/toko_controller.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/master/operasional/toko/toko_card.dart';
import 'package:akunt/view/master/operasional/toko/tambah_toko_screen.dart';
import 'package:provider/provider.dart';

// IMPORT PRINT WEB
// import 'dart:js' as js;

class DataTokoScreen extends StatefulWidget {
  @override
  _DataTokoScreenState createState() => _DataTokoScreenState();
}

class _DataTokoScreenState extends State<DataTokoScreen> {
  @override
  void initState() {
    Provider.of<TokoController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TokoController>(builder: (context, tokoController, child) {
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
                "Data Toko",
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
                hoverColor: Colors.white,
                onTap: () {
                  // js.context.callMethod('open', [
                  //   'http://localhost/KMBS/KMBS/kmbs_php/Laporan_Mastertoko.php'
                  // ]);
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
                        "Cetak",
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
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TambahTokoScreen(isModeEdit: false)));
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
                                  controller: tokoController.searchController,
                                  onChanged: (value) {
                                    Provider.of<TokoController>(context,
                                            listen: false)
                                        .setProses(true);
                                    Provider.of<TokoController>(context,
                                            listen: false)
                                        .search(value);
                                  },
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
                                ),
                              ),
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
                    EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "No.",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Kode Toko",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Nama Toko",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Alamat",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
                            color: Colors.teal[100],
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: (tokoController.data_tokoList.length > 0)
                    ? ListView.builder(
                        itemCount: tokoController.data_tokoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return tokoCard(context, index, tokoController,
                              pressEdit: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TambahTokoScreen(
                                          isModeEdit: true,
                                          data_toko: tokoController
                                              .data_tokoList[index],
                                        )));
                          }, pressDelete: () {
                            showAnimatedDialog_withCallBack(
                                context, NotifHapus(), isFlip: true,
                                callback: (value) {
                              if (value != null) {
                                if (value) {
                                  tokoController.hapus_akun(
                                      tokoController.data_tokoList[index]);
                                }
                              }
                            });
                          });
                        },
                      )
                    : Container(
                        child: Center(
                          child: Text(
                            "Tidak ada data",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: GreyColor),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),

        /// paginate
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
                if (tokoController.data_tokoList.length > 0)
                  Text(
                    (tokoController.offset + 1 < tokoController.totalNotaTerima)
                        ? "Showing ${tokoController.offset + 1} to ${tokoController.offset + tokoController.limit} of ${tokoController.totalNotaTerima} entries"
                        : "Showing ${tokoController.offset + 1} to ${tokoController.totalNotaTerima} of ${tokoController.totalNotaTerima} entries",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                if (tokoController.data_tokoList.length > 0)
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
                            value: tokoController.limit,
                            items: tokoController.dropdownLimit,
                            onChanged: (value) {
                              if (value != null) {
                                tokoController.limit = value;
                                tokoController.selectDataPaginate(false);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (tokoController.page_index > 0) {
                      tokoController.offset -= tokoController.limit;
                      tokoController.page_index--;
                      tokoController.c_page.text =
                          (tokoController.page_index + 1).toString();
                      tokoController.selectDataPaginate(false);
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
                            color: (tokoController.offset == 0)
                                ? GreyColor
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                pageField(),
                InkWell(
                  onTap: () {
                    if (tokoController.page_index <=
                        tokoController.pageCount - 1) {
                      tokoController.offset += tokoController.limit;
                      tokoController.page_index++;
                      tokoController.c_page.text =
                          (tokoController.page_index + 1).toString();
                      tokoController.selectDataPaginate(false);
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
                            color: ((tokoController.pageCount -
                                        tokoController.page_index) <=
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

  ///paginate
  Widget pageField() {
    TokoController pageTerima =
        Provider.of<TokoController>(context, listen: false);
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
            pageTerima.selectDataPaginate(false);
          } else if (index < pageTerima.page_index) {
            pageTerima.offset = (index * pageTerima.limit);
            pageTerima.page_index = index;
            pageTerima.c_page.text = (pageTerima.page_index + 1).toString();
            pageTerima.selectDataPaginate(false);
          }
        },
      ),
    );
  }
}
