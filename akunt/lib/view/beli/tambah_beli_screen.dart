// // import 'package:akunt/view/stok/pilih_brg.dart';
// import 'package:akunt/view/beli/pilih_po.dart';
// import 'package:akunt/view/po/pilih_supplier.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:akunt/config/animation_custom_dialog.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:akunt/config/OnHoverButton.dart';
// import 'package:akunt/config/color.dart';
// import 'package:akunt/controller/beli_controller.dart';
// import 'package:akunt/view/beli/pilih_po.dart';
// import 'package:provider/provider.dart';

// class TambahBeliScreen extends StatefulWidget {
//   bool isModeEdit;
//   var data_beli;

//   TambahBeliScreen({this.isModeEdit, this.data_beli});

//   @override
//   _TambahBeliScreenState createState() => _TambahBeliScreenState();
// }

// class _TambahBeliScreenState extends State<TambahBeliScreen> {
//   @override
//   void initState() {
//     var m_beli = Provider.of<BeliController>(context, listen: false);
//     if (widget.isModeEdit) {
//       m_beli.nobukti_Controller.text = widget.data_beli['NO_BUKTI'] ?? "";
//       m_beli.tanggal_Controller.text = widget.data_beli['TGL'] ?? "";
//       m_beli.nopo_Controller.text = widget.data_beli['NO_PO'] ?? "";
//       m_beli.kodes_Controller.text = widget.data_beli['KODES'] ?? "";
//       m_beli.namas_Controller.text = widget.data_beli['NAMAS'] ?? "";
//       m_beli.kdbrg_Controller.text = widget.data_beli['KD_BRG'] ?? "";
//       m_beli.nabrg_Controller.text = widget.data_beli['NA_BRG'] ?? "";
//       m_beli.kg_Controller.text = widget.data_beli['KG'].toString();
//       m_beli.harga_Controller.text = widget.data_beli['HARGA'].toString();
//       m_beli.lain_Controller.text = widget.data_beli['LAIN'] ?? "";
//       m_beli.total_Controller.text = widget.data_beli['TOTAL'].toString();
//       m_beli.notes_Controller.text = widget.data_beli['NOTES'] ?? "";
//       m_beli.rprate_Controller.text = widget.data_beli['RPRATE'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['RPHARGA'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['RPLAIN'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['RPTOTAL'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['AJU'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['BL'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['EMKL'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['JCONT'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['HARGAT'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['ACNOA'].toString();
//       m_beli.rpharga_Controller.text = widget.data_beli['NACNOA'].toString();
//     } else {
//       m_beli.resetField();
//     }
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
//                 (widget.isModeEdit)
//                     ? "Edit Pembelian Barang"
//                     : "Tambah Pembelian Barang",
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
//         ),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 24, right: 23, top: 16),
//                   child: Card(
//                     color: Colors.white,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Bukti#",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           enabled: false,
//                                           controller:
//                                               beliController.nobukti_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 6,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Tanggal",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 45,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.tanggal_Controller,
//                                           readOnly: true,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             icon: Image.asset(
//                                               "assets/images/ic_tanggal.png",
//                                               height: 20,
//                                             ),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                           onTap: () async {
//                                             beliController.chooseDate =
//                                                 await showDatePicker(
//                                                         context: context,
//                                                         initialDate:
//                                                             beliController
//                                                                     .chooseDate ??
//                                                                 DateTime.now(),
//                                                         lastDate:
//                                                             DateTime(2050),
//                                                         firstDate: DateTime(
//                                                             DateTime.now()
//                                                                 .year)) ??
//                                                     beliController.chooseDate;
//                                             beliController
//                                                     .tanggal_Controller.text =
//                                                 beliController.format_tanggal
//                                                     .format(beliController
//                                                         .chooseDate);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 18, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "PO#",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.nopo_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             icon: Image.asset(
//                                               "assets/images/ic_user_warna.png",
//                                               height: 20,
//                                             ),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                           onTap: () {
//                                             showAnimatedDialog(
//                                                 context,
//                                                 PilihPo(
//                                                     beliController
//                                                             .nopo_Controller
//                                                             .text
//                                                             .isEmpty
//                                                         ? null
//                                                         : beliController
//                                                             .kodes_Controller
//                                                             .text,
//                                                     beliController),
//                                                 isFlip: false);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Supplier#",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.kodes_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Nama",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.namas_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             icon: Image.asset(
//                                               "assets/images/ic_user_warna.png",
//                                               height: 20,
//                                             ),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Barang#",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.kdbrg_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "-",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.nabrg_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             icon: Image.asset(
//                                               "assets/images/ic_user_warna.png",
//                                               height: 20,
//                                             ),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "KG",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.kg_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Harga",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           onChanged: (numb) {
//                                             if (numb.isNotEmpty) {
//                                               beliController.hitungTotal();
//                                             }
//                                           },
//                                           controller:
//                                               beliController.harga_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 30, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Lain",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.lain_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             icon: Image.asset(
//                                               "assets/images/ic_user_warna.png",
//                                               height: 20,
//                                             ),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Total",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.total_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Notes",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.notes_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             icon: Image.asset(
//                                               "assets/images/ic_user_warna.png",
//                                               height: 20,
//                                             ),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 5, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Rp-Rate",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           onChanged: (numb) {
//                                             if (numb.isNotEmpty) {
//                                               beliController.hitungTotal();
//                                             }
//                                           },
//                                           controller:
//                                               beliController.rprate_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 30, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Rp-Harga",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           onChanged: (numb) {
//                                             if (numb.isNotEmpty) {
//                                               beliController.hitungTotal();
//                                             }
//                                           },
//                                           controller:
//                                               beliController.rpharga_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 30, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Rp-Lain",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.rplain_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "RP-Total",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           // onChanged: (numb) {
//                                           //   if (numb.isNotEmpty) {
//                                           //     stokController.hitungTotal();
//                                           //   }
//                                           // },
//                                           controller:
//                                               beliController.rptotal_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "AJU",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.aju_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "BL",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.bl_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Emkl",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.emkl_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "J-Container",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.jcont_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Hargat",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.hargat_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Debit-Ac",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.acnoa_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 24, right: 24, top: 5),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Debit-Nm",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(
//                                         height: 8,
//                                       ),
//                                       Container(
//                                         height: 40,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: GreyColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16),
//                                         child: TextFormField(
//                                           controller:
//                                               beliController.nacnoa_Controller,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.only(
//                                                 top: 18, bottom: 18),
//                                             border: InputBorder.none,
//                                             focusedBorder: InputBorder.none,
//                                             focusedErrorBorder:
//                                                 InputBorder.none,
//                                             errorBorder: InputBorder.none,
//                                             enabledBorder: InputBorder.none,
//                                             disabledBorder: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(flex: 15, child: SizedBox()),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             OnHoverButton(
//                               child: InkWell(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: GreyColor),
//                                     color: kBackgroundColor,
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 32, vertical: 8),
//                                   child: Text(
//                                     "Batal",
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.black),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 24,
//                             ),
//                             OnHoverButton(
//                               child: InkWell(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: HijauColor,
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 32, vertical: 8),
//                                   child: Text(
//                                     "Simpan",
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   if (widget.isModeEdit) {
//                                     beliController
//                                         .update_beli(widget.data_beli['NO_ID'])
//                                         .then((value) {
//                                       if (value != null) {
//                                         if (value) {
//                                           Navigator.pop(context);
//                                         }
//                                       }
//                                     });
//                                   } else {
//                                     beliController.insert_beli().then((value) {
//                                       if (value != null) {
//                                         if (value) {
//                                           beliController.resetField();
//                                           beliController.ambil_beli("");
//                                           Navigator.pop(context);
//                                         }
//                                       }
//                                     });
//                                   }
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 24,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 24,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
