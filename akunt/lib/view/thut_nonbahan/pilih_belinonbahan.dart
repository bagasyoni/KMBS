import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/belinonbahan_controller.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PilihBelinonbahan extends StatefulWidget {
  String Belinonbahan_terpilih;
  var controller;

  PilihBelinonbahan(this.Belinonbahan_terpilih, this.controller);

  @override
  _PilihBelinonbahanState createState() => _PilihBelinonbahanState();
}

class _PilihBelinonbahanState extends State<PilihBelinonbahan> {
  TextEditingController searchController = TextEditingController();
  int index_terpilih;

  @override
  void initState() {
    Provider.of<BelinonbahanController>(context, listen: false).selectData("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BelinonbahanController>(
        builder: (context, belinonbahanController, child) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height - 100,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text("Pilih Beli Non Bahan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Card(
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                      icon: Image.asset(
                        "assets/images/ic_search.png",
                        height: 25,
                      ),
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
                    onChanged: (value) {
                      belinonbahanController.selectData(value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "No Bukti",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Kode Supplier",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Nama Supplier",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Dragon",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: belinonbahanController.data_belinonbahan_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return BelinonbahanCard(index);
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Divider(height: 0, color: GreyColor),
            Row(children: [
              Expanded(
                  child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10))),
                  child: Text("Batal",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black87)),
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () async {
                  if (index_terpilih != null) {
                    widget.controller.nobeliController.text =
                        belinonbahanController
                            .data_belinonbahan_list[index_terpilih]['NO_BUKTI'];
                    widget.controller.kodesController.text =
                        belinonbahanController
                            .data_belinonbahan_list[index_terpilih]['KODES'];
                    widget.controller.namasController.text =
                        belinonbahanController
                            .data_belinonbahan_list[index_terpilih]['NAMAS'];
                    widget.controller.drController.text = belinonbahanController
                        .data_belinonbahan_list[index_terpilih]['DR'];
                    Navigator.pop(context);
                  } else {
                    Toast("Peringatan", "Belum ada data terpilih", false);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(10))),
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              )),
            ]),
          ]),
        ),
      );
    });
  }

  Widget BelinonbahanCard(int index) {
    bool isActive = index == index_terpilih;
    var data_belibahan =
        Provider.of<BelinonbahanController>(context, listen: false)
            .data_belinonbahan_list[index];
    if (widget.Belinonbahan_terpilih != null) {
      if (data_belibahan['NO_BUKTI'] == widget.Belinonbahan_terpilih) {
        isActive = true;
        index_terpilih = index;
      }
    }
    return InkWell(
      onTap: () {
        index_terpilih = index;
        widget.Belinonbahan_terpilih = data_belibahan['NO_BUKTI'];
        setState(() {});
      },
      child: Container(
        color: isActive ? kPrimaryColor : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    data_belibahan['NO_BUKTI'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    data_belibahan['KODES'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    data_belibahan['NAMAS'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    data_belibahan['DR'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
