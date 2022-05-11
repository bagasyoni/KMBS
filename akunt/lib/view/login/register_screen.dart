import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/register_controller.dart';
import 'package:provider/provider.dart';

Widget registerView(BuildContext context) {
  var loginController = Provider.of<LoginController>(context, listen: false);
  return Consumer<RegisterController>(
      builder: (context, registerController, child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Container(
        decoration: BoxDecoration(
            color: kBackgroundColor,
            border: Border.all(color: HijauColor),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: GreyColor,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: const Offset(5, 5),
              ),
            ]),
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Text(
                "Register Akun",
                style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: HijauColor),
              ),
            ),
            Spacer(),
            Text(
              "Username",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: registerController.usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Password",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                obscureText: true,
                controller: registerController.passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Nama Lengkap",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: registerController.namaController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "No HP",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: GreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: registerController.hpController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18, bottom: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Jabatan",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, style: BorderStyle.solid, color: HijauColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    iconEnabledColor: HijauColor,
                    value: registerController.jenis_jabatan,
                    items: registerController.dropdownList_jabatan,
                    onChanged: (value) {
                      if (value != null) {
                        registerController.jenis_jabatan = value.toString();
                        registerController.notifyListeners();
                      }
                    },
                  ),
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                registerController.daftar_akun().then((value) {
                  if (value != null) {
                    if (value) {
                      loginController.mode_login = true;
                      registerController.resetField();
                      loginController.notifyListeners();
                    }
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                decoration: BoxDecoration(
                    color: OrangeColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Daftar",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah Punya Akun ?",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                InkWell(
                    onTap: () {
                      loginController.mode_login = true;
                      loginController.notifyListeners();
                    },
                    child: Text(
                      " Masuk disini.",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HijauColor),
                    )),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  });
}
