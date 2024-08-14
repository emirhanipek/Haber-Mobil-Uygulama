// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/screen/login_screen.dart';
import 'home_screen.dart';

class register_screen extends StatefulWidget {
  const register_screen({super.key});

  @override
  State<register_screen> createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse('https://api.qline.app/api/register');
    var passwd = _passwordController.text;

    final response = await http.post(
      url,
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': passwd,
        'confirm_password': passwd,
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Başarılı kayıt durumu
      final data = json.decode(response.body);
      final success = data['success'];

      if (success) {
        // Başarılı kayıt durumunda anasayfaya yönlendirme yapabilirsiniz.
        context.push('/login_screen');
      } else {
        // Kayıt başarısız olduğunda hata mesajı alıp gösterebilirsiniz.
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
        title: Text("Kayıt Ol Yap"),
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
                alignment: Alignment(0, 0.4),
                child: Container(
                  width: size.width * 0.95,
                  height: size.height * 0.80,
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Form(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Form(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 250,
                                    height: 200,
                                    child: Image(
                                        image: AssetImage(
                                            "asset/images/cnn_logo_home_screen.png")),
                                  ),
                                  SizedBox(
                                    //height: 30,
                                    child: TextField(
                                      controller: _nameController,
                                      style: TextStyle(),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.w900),
                                        labelText:
                                            "Lütfen Kullanıcı adı giriniz",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    child: TextField(
                                      controller: _emailController,
                                      style: TextStyle(),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.w600),
                                        labelText: "Lütfen E-mail giriniz. ",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextField(
                                    controller: _passwordController,
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.w600),
                                      labelText: "Lütfen Şifre Giriniz",
                                      prefixIcon: Icon(
                                        Icons.password,
                                      ),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              login_screen()));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  padding: EdgeInsets.all(10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  'Giriş Yap',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 120,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              login_screen()));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 175, 0, 0),
                                                  padding: EdgeInsets.all(10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                ),
                                                child: InkWell(
                                                    onTap: _isLoading
                                                        ? null
                                                        : _register,
                                                    child: Text('Kayıt Ol')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
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
