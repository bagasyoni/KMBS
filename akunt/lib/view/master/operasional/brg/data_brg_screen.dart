import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/brg_controller.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/master/operasional/brg/brg_card.dart';
import 'package:akunt/view/master/operasional/brg/tambah_brg_screen.dart';
import 'package:provider/provider.dart';

// IMPORT PRINT WEB
// import 'dart:js' as js;

class DataBrgScreen extends StatefulWidget {
  @override
  _DataBrgScreenState createState() => _DataBrgScreenState();
}

class _DataBrgScreenState extends State<DataBrgScreen> {
  @override
  void initState() {
    Provider.of<BrgController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrgController>(builder: (context, brgController, child) {
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
                "Data Barang",
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
                  //   'http://localhost/KMBS/KMBS/kmbs_php/Laporan_Masterbrg.php'
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
                          builder: (_) => TambahBrgScreen(isModeEdit: false)));
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
                                  controller: brgController.searchController,
                                  onChanged: (value) {
                                    Provider.of<BrgController>(context,
                                            listen: false)
                                        .setProses(true);
                                    Provider.of<BrgController>(context,
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
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Kode Barang",
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
                      flex: 5,
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
                              "Nama Barang",
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
                              "Satuan",
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
                child: (brgController.data_brgList.length > 0)
                    ? ListView.builder(
                        itemCount: brgController.data_brgList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BrgCard(context, index, brgController,
                              pressEdit: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TambahBrgScreen(
                                          isModeEdit: true,
                                          data_brg:
                                              brgController.data_brgList[index],
                                        )));
                          }, pressDelete: () {
                            showAnimatedDialog_withCallBack(
                                context, NotifHapus(), isFlip: true,
                                callback: (value) {
                              if (value != null) {
                                if (value) {
                                  brgController.hapus_akun(
                                      brgController.data_brgList[index]);
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

        /// paginate ///
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
                if (brgController.data_brgList.length > 0)
                  Text(
                    (brgController.offset + 1 < brgController.totalNotaTerima)
                        ? "Showing ${brgController.offset + 1} to ${brgController.offset + brgController.limit} of ${brgController.totalNotaTerima} entries"
                        : "Showing ${brgController.offset + 1} to ${brgController.totalNotaTerima} of ${brgController.totalNotaTerima} entries",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                if (brgController.data_brgList.length > 0)
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
                            value: brgController.limit,
                            items: brgController.dropdownLimit,
                            onChanged: (value) {
                              if (value != null) {
                                brgController.limit = value;
                                brgController.selectDataPaginate(false);
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
                    if (brgController.page_index > 0) {
                      brgController.offset -= brgController.limit;
                      brgController.page_index--;
                      brgController.c_page.text =
                          (brgController.page_index + 1).toString();
                      brgController.selectDataPaginate(false);
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
                            color: (brgController.offset == 0)
                                ? GreyColor
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                pageField(),
                InkWell(
                  onTap: () {
                    if (brgController.page_index <=
                        brgController.pageCount - 1) {
                      brgController.offset += brgController.limit;
                      brgController.page_index++;
                      brgController.c_page.text =
                          (brgController.page_index + 1).toString();
                      brgController.selectDataPaginate(false);
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
                            color: ((brgController.pageCount -
                                        brgController.page_index) <=
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
    BrgController pageTerima =
        Provider.of<BrgController>(context, listen: false);
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
