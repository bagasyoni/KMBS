import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/db_controller.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/register_controller.dart';
import 'package:akunt/view/home/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Provider.of<db_controller>(context, listen: false).create_tabel();
    Provider.of<LoginController>(context, listen: false).initData();
    Provider.of<RegisterController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
        builder: (context, loginController, child) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              // Expanded(flex: 5, child: bannerView()),
              Expanded(child: loginView()),
            ],
          ),
        ),
      );
    });
  }

  Widget bannerView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Selamat Datang Di",
            style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.w600, color: HijauColor),
          ),
          Text(
            "Program Pembelian",
            style: GoogleFonts.poppins(
                fontSize: 32, fontWeight: FontWeight.w700, color: HijauColor),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: AspectRatio(
              aspectRatio: 2.5,
              child: Image.asset("assets/images/banner.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginView() {
    var loginController = Provider.of<LoginController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withAlpha(0),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(5, 5),
                ),
              ]),
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                  child: LottieBuilder.network(
                'https://assets3.lottiefiles.com/packages/lf20_tb8ugi81.json',
                height: 190,
              )
                  //     // child: Image.asset(
                  //     //   "assets/images/ic_logo_3.png",
                  //     //   height: 90,
                  //     // ),
                  ),
              Center(
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'PT. KARYAMITRA BUDISENTOSA',
                      // 'CV SATRIA DHARMA GUNA',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.white,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'PROGRAM PEMBELIAN DEMO',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withAlpha(0),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    controller: loginController.usernameLogin,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 18, bottom: 15),
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    controller: loginController.passwordLogin,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 18, bottom: 15),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 120,
                  child: InkWell(
                    onTap: () {
                      loginController.getLogin().then((value) {
                        if (value != null) {
                          if (value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen()));
                          }
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF070C35)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
