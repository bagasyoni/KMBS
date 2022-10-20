import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/toko_controller.dart';
import 'package:provider/provider.dart';

Widget tokoCard(BuildContext context, int index, TokoController valBar,
    {Function pressEdit, Function pressDelete}) {
  int offset = Provider.of<TokoController>(context, listen: false).offset;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(5), color: Colors.white),
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "${index + offset + 1}.",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    valBar.data_tokoList[index]['KODE'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    valBar.data_tokoList[index]['NAMA'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    valBar.data_tokoList[index]['ALAMAT'],
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: OnHoverButton(
                    child: InkWell(
                      onTap: pressEdit,
                      child: SizedBox(
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
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  border: Border.all(color: GreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
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
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
