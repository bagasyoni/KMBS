import 'package:akunt/controller/master/operasional/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget TransaksiBarangCard(int index, CustomerController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          // Expanded(
          //   flex: 3,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['a'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['b'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['c'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 3,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['d'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 4,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['e'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['f'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['g'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['h'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Text(
          //     controller.data_excel_byCustomer[index]['i'].toString(),
          //     style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
