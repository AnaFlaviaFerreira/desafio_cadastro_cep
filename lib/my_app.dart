import 'package:desafio_cadastro_cep/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Desafio cadasto cep',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: GoogleFonts.robotoSlabTextTheme(),
        ),
        home: const MainPage());
  }
}
