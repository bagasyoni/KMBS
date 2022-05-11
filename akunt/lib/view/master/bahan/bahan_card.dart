import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/bahan_controller.dart';
import 'package:provider/provider.dart';

Widget BahanCard(BuildContext context, int index, BahanController val_bar,
    {Function pressEdit, Function pressDelete}) {
  int offset = Provider.of<BahanController>(context, listen: false).offset;
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
          Expanded(
            flex: 1,
            child: Text(
              "${index + offset + 1}.",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              val_bar.data_bahanList[index]['KD_BHN'],
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              val_bar.data_bahanList[index]['NA_BHN'],
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              val_bar.data_bahanList[index]['SATUAN'].toString(),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: OnHoverButton(
              child: InkWell(
                onTap: pressEdit,
                child: Container(
                  height: 25,
                  child: Center(
                    child: Image.asset(
                      "assets/images/ic_edit.png",
                      height: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: AbuColor,
          ),
          Expanded(
            flex: 1,
            child: OnHoverButton(
              child: InkWell(
                onTap: pressDelete,
                child: Container(
                  height: 25,
                  child: Center(
                    child: Image.asset(
                      "assets/images/ic_hapus.png",
                      height: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
