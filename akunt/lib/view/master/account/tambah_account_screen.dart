import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/account_controller.dart';
import 'package:akunt/view/master/account/widget/keterangan_pemilik.dart';
import 'package:provider/provider.dart';

import 'widget/keterangan_umum.dart';

class TambahAccountScreen extends StatefulWidget {
  bool isModeEdit;
  var data_account;

  TambahAccountScreen({this.isModeEdit, this.data_account});

  @override
  _TambahAccountScreenState createState() => _TambahAccountScreenState();
}

class _TambahAccountScreenState extends State<TambahAccountScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int menu_index = 0;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    var m_account = Provider.of<AccountController>(context, listen: false);
    m_account.init_add_account().then((value) {
      if (widget.isModeEdit) {
        m_account.init_edit_account(widget.data_account);
      } else {
        m_account.resetField();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountController>(
        builder: (context, accountController, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              Container(
                height: 25,
                width: 1,
                color: AbuColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                (widget.isModeEdit) ? "Edit Account" : "Tambah Account",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/ic_back.png",
              height: 30,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  color: Colors.white, // Tab Bar color change
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    controller: _tabController,
                    unselectedLabelColor: kPrimaryColor,
                    labelColor: Colors.black,
                    indicatorWeight: 2,
                    indicatorColor: HijauColor,
                    labelStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    tabs: <Widget>[
                      Tab(
                        text: "Keterangan Umum",
                      ),
                      Tab(
                        text: "Keterangan Tambahan",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    KeteranganUmum(accountController),
                    KeteranganPemilik(context, accountController),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24, right: 23, top: 8, bottom: 10),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  color: GreyColor,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OnHoverButton(
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: GreyColor),
                            color: kBackgroundColor,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                          child: Text(
                            "Batal",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    OnHoverButton(
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HijauColor,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                          child: Text(
                            "Simpan",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (widget.isModeEdit) {
                            accountController
                                .edit_account(widget.data_account['NO_ID'])
                                .then((value) {
                              if (value != null) {
                                if (value) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                          } else {
                            accountController.daftar_account().then((value) {
                              if (value != null) {
                                if (value) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
