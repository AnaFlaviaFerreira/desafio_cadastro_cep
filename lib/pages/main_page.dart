import 'package:desafio_cadastro_cep/pages/listagem_page.dart';
import 'package:desafio_cadastro_cep/pages/viacep_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int posicaoPagina = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: PageView(
              controller: controller,
              onPageChanged: (value) => setState(() {
                posicaoPagina = value;
              }),
              children: const [ViaCepPage(), ListagemPage()],
            )),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: posicaoPagina,
              onTap: (value) => controller.jumpToPage(value),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Consulta"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "Listagem"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
