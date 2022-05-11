// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:akunt/config/OnHoverButton.dart';
// import 'package:akunt/config/animation_custom_dialog.dart';
// import 'package:akunt/config/color.dart';
// import 'package:akunt/controller/beli_controller.dart';
// import 'package:akunt/controller/db_controller.dart';
// import 'package:akunt/view/beli/beli_card.dart';
// import 'package:akunt/view/beli/tambah_beli_screen.dart';
// import 'package:akunt/view/base_widget/notif_hapus.dart';
// import 'package:provider/provider.dart';

// class DataBeliScreen extends StatefulWidget {
//   @override
//   _DataBeliScreenState createState() => _DataBeliScreenState();
// }

// class _DataBeliScreenState extends State<DataBeliScreen> {
//   @override
//   void initState() {
//     Provider.of<BeliController>(context, listen: false).setProsesss(true);
//     Provider.of<BeliController>(context, listen: false).ambil_beli("");
//     Provider.of<BeliController>(context, listen: false).initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BeliController>(builder: (context, beliController, child) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 1,
//           title: Row(
//             children: [
//               Container(
//                 height: 25,
//                 width: 1,
//                 color: AbuColor,
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "Pembelian Barang",
//                 style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black),
//               ),
//             ],
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             iconSize: 20,
//             padding: EdgeInsets.all(0),
//             icon: Image.asset(
//               "assets/images/ic_back.png",
//               height: 30,
//             ),
//           ),
//           actions: [
//             OnHoverButton(
//               child: InkWell(
//                 hoverColor: Colors.transparent,
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => TambahBeliScreen(
//                                 isModeEdit: false,
//                               )));
//                 },
//                 child: Container(
//                   height: 30,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.asset(
//                         "assets/images/ic_add.png",
//                         height: 30,
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Text(
//                         "Tambah Baru",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 16,
//             ),
//           ],
//         ),
//         backgroundColor: kBackgroundColor,
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 32, right: 32, top: 16, bottom: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: GreyColor,
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset:
//                                   Offset(1, 2), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               "assets/images/ic_search.png",
//                               height: 25,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8),
//                               child: Container(
//                                 width: 1,
//                                 height: 25,
//                                 color: GreyColor,
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height: 30,
//                                 child: TextField(
//                                   onChanged: (value) {
//                                     Provider.of<BeliController>(context,
//                                             listen: false)
//                                         .setProsesss(true);
//                                     Provider.of<BeliController>(context,
//                                             listen: false)
//                                         .search(value);
//                                   },
//                                   decoration: InputDecoration(
//                                     hintText: "Cari Disini",
//                                     hintStyle: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         color: GreyColor),
//                                     contentPadding: EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 14),
//                                     border: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     errorBorder: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     focusedErrorBorder: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding:
//                     EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 4),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Text(
//                         "No.",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "No. Bukti",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "Tanggal",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         "No Po",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "Kode Supplier",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         "Nama Supplier",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "Kode Barang",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "Total",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black87),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: (beliController.beliList.length > 0)
//                     ? ListView.builder(
//                         itemCount: beliController.beliList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return BeliCard(context, index, beliController,
//                               pressEdit: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => TambahBeliScreen(
//                                           isModeEdit: true,
//                                           data_beli:
//                                               beliController.beliList[index],
//                                         )));
//                           }, pressDelete: () {
//                             showAnimatedDialog_withCallBack(
//                                 context, NotifHapus(), isFlip: true,
//                                 callback: (value) {
//                               if (value != null) {
//                                 if (value) {
//                                   beliController.hapus_akun(
//                                       beliController.beliList[index]);
//                                 }
//                               }
//                             });
//                           });
//                         },
//                       )
//                     : Container(
//                         child: Center(
//                           child: Text(
//                             "Tidak ada data",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: GreyColor),
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
