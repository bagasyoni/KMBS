import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/surat_controller.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PilihSurat extends StatefulWidget {
  String surat_terpilih;
  var controller;

  PilihSurat(this.surat_terpilih, this.controller);

  @override
  _PilihSuratState createState() => _PilihSuratState();
}

class _PilihSuratState extends State<PilihSurat> {
  TextEditingController searchController = TextEditingController();
  int index_terpilih;
  var dataterpilih;

  @override
  void initState() {
    Provider.of<SuratController>(context, listen: false).selectData("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SuratController>(
        builder: (context, suratController, child) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height - 100,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text("Pilih Surat Jalan",
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
                      suratController.selectData(value);
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
                    flex: 1,
                    child: Text(
                      "No.",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "No SJ",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Tanggal SJ",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Jatuh Tempo",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Kode Customer",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Nama Customer",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Kota",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Alamat",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: GreyColor),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Keterangan",
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
                itemCount: suratController.data_surat_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return SuratCard(index);
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
                    widget.controller.nosjController.text = suratController
                        .data_surat_list[index_terpilih]['NO_BUKTI'];
                    widget.controller.tglController.text = suratController
                        .data_surat_list[index_terpilih]['TGL'];
                    widget.controller.jtempoController.text = suratController
                        .data_surat_list[index_terpilih]['JTEMPO'];
                    widget.controller.kodecController.text = suratController
                        .data_surat_list[index_terpilih]['KODEC'];
                    widget.controller.namacController.text = suratController
                        .data_surat_list[index_terpilih]['NAMAC'];
                    widget.controller.kotaController.text = suratController
                        .data_surat_list[index_terpilih]['KOTA'];
                    widget.controller.alamatController.text = suratController
                        .data_surat_list[index_terpilih]['ALAMAT'];
                    widget.controller.notesController.text = suratController
                        .data_surat_list[index_terpilih]['NOTES'];
                    Navigator.pop(context, dataterpilih);
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

  Widget SuratCard(int index) {
    bool isActive = index == index_terpilih;
    var data_surat = Provider.of<SuratController>(context, listen: false)
        .data_surat_list[index];
    if (widget.surat_terpilih != null) {
      if (data_surat['NO_BUKTI'] == widget.surat_terpilih) {
        isActive = true;
        index_terpilih = index;
      }
    }
    return InkWell(
      onTap: () {
        widget.surat_terpilih = data_surat['NO_BUKTI'];
        index_terpilih = index;
        dataterpilih = Provider.of<SuratController>(context, listen: false)
            .data_surat_list[index_terpilih];
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
                  flex: 1,
                  child: Text(
                    data_surat['NO_ID'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    data_surat['NO_BUKTI'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    data_surat['TGL'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    data_surat['JTEMPO'].toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    data_surat['KODEC'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    data_surat['NAMAC'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    data_surat['KOTA'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    data_surat['ALAMAT'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.black),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    data_surat['NOTES'],
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
