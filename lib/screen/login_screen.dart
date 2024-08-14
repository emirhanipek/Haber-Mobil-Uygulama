// ignore_for_file: unused_field

import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsapp/screen/home_screen.dart';
import 'package:newsapp/screen/register_login.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('https://api.qline.app/api/login');
    final response = await http.post(
      url,
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Başarılı giriş durumu
      final data = json.decode(response.body);
      final success = data['success'];

      if (success) {
        // Başarılı giriş durumunda anasayfaya yönlendirme yapabilirsiniz.
        context.push('/news_screen');
      } else {
        // Giriş başarısız olduğunda hata mesajı alıp gösterebilirsiniz.
        final errorMessage = data['msg'];
        setState(() {
          _errorMessage = errorMessage;
        });
      }
    } else {
      // Sunucuyla ilgili bir hata oluştuğunda hata mesajı gösterebilirsiniz.
      setState(() {
        _errorMessage = 'Sunucuyla iletişim kurulurken bir hata oluştu.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Yap"),
        backgroundColor: Color.fromARGB(255, 185, 0, 0),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => home_screen()));
            },
            child: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment(0, 0.1),
                child: Container(
                  width: size.width * 0.95,
                  height: size.height * 0.75,
                  child: Card(
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Form(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              child: Image(
                                  image: AssetImage(
                                      "asset/images/cnn_logo_home_screen.png")),
                            ),
                            SizedBox(
                              //height: 30,
                              child: TextField(
                                controller: _emailController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700),
                                  labelText: "Kullanıcı Adı veya mail ",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: _passwordController,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w700),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                labelText: "Şifre Giriniz",
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 2),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Şifremi Unuttum",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 175, 0, 0),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: _isLoading ? null : _login,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Color.fromARGB(255, 195, 0, 0),
                                            padding: EdgeInsets.all(10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'GİRİŞ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Diğer Giriş Seçenekleri",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.only(
                                          left: 70,
                                          right: 70,
                                          top: 10,
                                          bottom: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.apple,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Apple İle Giriş Yap",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: EdgeInsets.only(
                                          left: 57,
                                          right: 57,
                                          top: 10,
                                          bottom: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    onPressed: (() {}),
                                    child: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.facebook,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Facebook İle Giriş Yap",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Üye Değil Misin ?",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700),
                                ),
                                TextButton(
                                    onPressed: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  register_screen()));
                                    }),
                                    child: Text(
                                      "Üye Ol",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 175, 0, 0)),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
