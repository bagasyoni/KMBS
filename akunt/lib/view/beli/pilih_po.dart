// import 'package:google_fonts/google_fonts.dart';
// import 'package:akunt/config/color.dart';
// import 'package:akunt/controller/po_controller.dart';
// import 'package:akunt/view/base_widget/toast.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

// class PilihPo extends StatefulWidget {
//   String po_terpilih;
//   var controller;

//   PilihPo(this.po_terpilih, this.controller);

//   @override
//   _PilihPoState createState() => _PilihPoState();
// }

// class _PilihPoState extends State<PilihPo> {
//   TextEditingController searchController = TextEditingController();
//   int index_terpilih;

//   @override
//   void initState() {
//     Provider.of<PoController>(context, listen: false).modalData("");
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PoController>(builder: (context, poController, child) {
//       return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Container(
//           width: MediaQuery.of(context).size.width - 500,
//           height: MediaQuery.of(context).size.height - 200,
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//               child: Text("Pilih Purchase Order",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black),
//                   textAlign: TextAlign.center),
//             ),
//             Divider(),
//             Padding(
//               padding: EdgeInsets.only(left: 8, right: 8, top: 8),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Container(
//                   height: 45,
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: TextFormField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(top: 18, bottom: 18),
//                       icon: Image.asset(
//                         "assets/images/ic_search.png",
//                         height: 25,
//                       ),
//                       hintText: "Cari disini",
//                       hintStyle: GoogleFonts.poppins(
//                           color: GreyColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14),
//                       border: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       focusedErrorBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                     ),
//                     onChanged: (value) {
//                       poController.modalData(value);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "PO#",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Tanggal",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Supplier",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 6,
//                     child: Text(
//                       "Barang",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Harga",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Kg",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Kirim",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Text(
//                       "Sisa",
//                       style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: GreyColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: poController.poList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return brgCard(index);
//                 },
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Divider(height: 0, color: GreyColor),
//             Row(children: [
//               Expanded(
//                   child: InkWell(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius:
//                           BorderRadius.only(bottomLeft: Radius.circular(10))),
//                   child: Text("Batal",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16,
//                           color: Colors.black87)),
//                 ),
//               )),
//               Expanded(
//                   child: InkWell(
//                 onTap: () async {
//                   if (index_terpilih != null) {
//                     widget.controller.nopo_Controller.text =
//                         poController.poList[index_terpilih]['NO_PO'];
//                     widget.controller.tanggal_Controller.text =
//                         poController.poList[index_terpilih]['TGL'];
//                     widget.controller.kodes_Controller.text =
//                         poController.poList[index_terpilih]['KODES'];
//                     widget.controller.namas_Controller.text =
//                         poController.poList[index_terpilih]['NAMAS'];
//                     widget.controller.kdbrg_Controller.text =
//                         poController.poList[index_terpilih]['KD_BRG'];
//                     widget.controller.nabrg_Controller.text =
//                         poController.poList[index_terpilih]['NA_BRG'];
//                     widget.controller.harga_Controller.text =
//                         poController.poList[index_terpilih]['HARGA'];
//                     widget.controller.kg_Controller.text =
//                         poController.poList[index_terpilih]['KG'];
//                     widget.controller.kirim_Controller.text =
//                         poController.poList[index_terpilih]['KIRIM'];
//                     widget.controller.sisa_Controller.text =
//                         poController.poList[index_terpilih]['SISA'];

//                     Navigator.pop(context);
//                   } else {
//                     Toast("Peringatan", "Belum ada data terpilih", false);
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: kPrimaryColor,
//                       borderRadius:
//                           BorderRadius.only(bottomRight: Radius.circular(10))),
//                   child: Text(
//                     "Simpan",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16,
//                         color: Colors.white),
//                   ),
//                 ),
//               )),
//             ]),
//           ]),
//         ),
//       );
//     });
//   }

//   Widget brgCard(int index) {
//     bool isActive = index == index_terpilih;
//     var data_po =
//         Provider.of<PoController>(context, listen: false).poList[index];
//     if (widget.po_terpilih != null) {
//       if (data_po['NO_PO'] == widget.po_terpilih) {
//         isActive = true;
//         index_terpilih = index;
//       }
//     }
//     return InkWell(
//       onTap: () {
//         index_terpilih = index;
//         widget.po_terpilih = data_po['NO_PO'];
//         setState(() {});
//       },
//       child: Container(
//         color: isActive ? kPrimaryColor : Colors.white,
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['NO_PO'],
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['TGL'],
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['NAMAS'],
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 6,
//                   child: Text(
//                     data_po['NA_BRG'],
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['HARGA'].toString(),
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['KG'].toString(),
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['KIRIM'].toString(),
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     data_po['SISA'].toString(),
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isActive ? Colors.white : Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Divider(
//               height: 1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
