// // import 'package:akunt/view/stok/pilih_brg.dart';
// import 'package:akunt/view/po/pilih_supplier.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:akunt/config/animation_custom_dialog.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:akunt/config/OnHoverButton.dart';
// import 'package:akunt/config/color.dart';
// import 'package:akunt/controller/po_controller.dart';
// import 'package:akunt/view/po/pilih_brg.dart';
// import 'package:provider/provider.dart';

// class TambahPoScreen extends StatefulWidget {
//   bool isModeEdit;
//   var data_po;

//   TambahPoScreen({this.isModeEdit, this.data_po});

//   @override
//   _TambahPoScreenState createState() => _TambahPoScreenState();
// }

// class _TambahPoScreenState extends State<TambahPoScreen> {
//   @override
//   void initState() {
//     var m_po = Provider.of<PoController>(context, listen: false);
//     if (widget.isModeEdit) {
//       m_po.nopo_Controller.text = widget.data_po['NO_PO'] ?? "";
//       m_po.tanggal_Controller.text = widget.data_po['TGL'] ?? "";
//       m_po.jtempo_Controller.text = widget.data_po['JTEMPO'] ?? "";
//       m_po.kodes_Controller.text = widget.data_po['KODES'] ?? "";
//       m_po.namas_Controller.text = widget.data_po['NAMAS'] ?? "";
//       m_po.kdbrg_Controller.text = widget.data_po['KD_BRG'] ?? "";
//       m_po.nabrg_Controller.text = widget.data_po['NA_BRG'] ?? "";
//       m_po.kg_Controller.text = widget.data_po['KG'].toString();
//       m_po.harga_Controller.text = widget.data_po['HARGA'].toString();
//       m_po.total_Controller.text = widget.data_po['TOTAL'].toString();
//       m_po.notes_Controller.text = widget.data_po['NOTES'] ?? "";
//       m_po.rprate_Controller.text = widget.data_po['RPRATE'].toString();
//       m_po.rpharga_Controller.text = widget.data_po['RPHARGA'].toString();
//       m_po.rptotal_Controller.text = widget.data_po['RPTOTAL'].toString();
//     } else {
//       m_po.resetField();
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PoController>(builder: (context, poController, child) {
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
//                     ? "Edit Purchase Order"
//                     : "Tambah Purchase Order",
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
//                                         "Po#",
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
//                                               poController.nopo_Controller,
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
//                                               poController.tanggal_Controller,
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
//                                             poController.chooseDate =
//                                                 await showDatePicker(
//                                                         context: context,
//                                                         initialDate: poController
//                                                                 .chooseDate ??
//                                                             DateTime.now(),
//                                                         lastDate:
//                                                             DateTime(2050),
//                                                         firstDate: DateTime(
//                                                             DateTime.now()
//                                                                 .year)) ??
//                                                     poController.chooseDate;
//                                             poController
//                                                     .tanggal_Controller.text =
//                                                 poController.format_tanggal
//                                                     .format(poController
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
//                                 flex: 6,
//                                 child: Container(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Jtempo",
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
//                                               poController.jtempo_Controller,
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
//                                             poController.chooseDate =
//                                                 await showDatePicker(
//                                                         context: context,
//                                                         initialDate: poController
//                                                                 .chooseDate ??
//                                                             DateTime.now(),
//                                                         lastDate:
//                                                             DateTime(2050),
//                                                         firstDate: DateTime(
//                                                             DateTime.now()
//                                                                 .year)) ??
//                                                     poController.chooseDate;
//                                             poController
//                                                     .jtempo_Controller.text =
//                                                 poController.format_tanggal
//                                                     .format(poController
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
//                                         "Supplier",
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
//                                               poController.kodes_Controller,
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
//                                                 PilihSupplier(
//                                                     poController
//                                                             .kodes_Controller
//                                                             .text
//                                                             .isEmpty
//                                                         ? null
//                                                         : poController
//                                                             .namas_Controller
//                                                             .text,
//                                                     poController),
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
//                                         "Nama Supplier",
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
//                                               poController.namas_Controller,
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
//                                               poController.kdbrg_Controller,
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
//                                                 PilihBrg(
//                                                     poController
//                                                             .kdbrg_Controller
//                                                             .text
//                                                             .isEmpty
//                                                         ? null
//                                                         : poController
//                                                             .nabrg_Controller
//                                                             .text,
//                                                     poController),
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
//                                         "Nama Barang",
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
//                                               poController.nabrg_Controller,
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
//                                           onChanged: (numb) {
//                                             if (numb.isNotEmpty) {
//                                               poController.hitungTotal();
//                                             }
//                                           },
//                                           controller:
//                                               poController.kg_Controller,
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
//                                               poController.hitungTotal();
//                                             }
//                                           },
//                                           controller:
//                                               poController.harga_Controller,
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
//                                           onChanged: (numb) {
//                                             if (numb.isNotEmpty) {
//                                               poController.hitungTotal();
//                                             }
//                                           },
//                                           controller:
//                                               poController.total_Controller,
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
//                                               poController.notes_Controller,
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
//                                         "RP-Rate",
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
//                                               poController.rprate_Controller,
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
//                                           controller:
//                                               poController.rpharga_Controller,
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
//                                         "Rp-Total",
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
//                                               poController.rptotal_Controller,
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
//                                     poController
//                                         .update_po(widget.data_po['NO_ID'])
//                                         .then((value) {
//                                       if (value != null) {
//                                         if (value) {
//                                           Navigator.pop(context);
//                                         }
//                                       }
//                                     });
//                                   } else {
//                                     poController.insert_po().then((value) {
//                                       if (value != null) {
//                                         if (value) {
//                                           poController.resetField();
//                                           poController.ambil_po("");
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
