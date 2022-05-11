import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:akunt/model/model_satuan.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:akunt/config/color.dart';

class TambahPeriode extends StatefulWidget {
  @override
  _TambahPeriodeState createState() => _TambahPeriodeState();
}

class _TambahPeriodeState extends State<TambahPeriode> {
  TextEditingController periode_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text("TAMBAH PERIODE",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center),
            ),
            Divider(height: 1, color: GreyColor),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
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
                    decoration: BoxDecoration(
                      border: Border.all(color: GreyColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: periode_controller,
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
                ],
              ),
            ),
            Divider(height: 0, color: GreyColor),
            Row(children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10))),
                  child: Text("Batal",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black)),
                ),
              )),
              Expanded(
                  child: InkWell(
                onTap: () async {
                  if (periode_controller.text.isNotEmpty) {
                    BotToast.showLoading();
                    await model_satuan()
                        .insert_satuan(periode_controller.text.toLowerCase());
                    BotToast.closeAllLoading();
                    Navigator.pop(context, true);
                  } else {
                    Toast("Peringatan", "Nama satuan barang tidak boleh kosong",
                        false);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HijauColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(10))),
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              )),
            ]),
          ],
        ),
      ),
    );
  }
}
