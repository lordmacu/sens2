import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sens2/core/components/modals/options_dialog.dart';
import 'package:sens2/apps/apliplast/views/reprocesos/reprocessing_page.dart';

class ReportFormWidget extends StatelessWidget {
  final TextEditingController report1Controller = TextEditingController();
  final TextEditingController report2Controller = TextEditingController();
  final TextEditingController report3Controller = TextEditingController();
  final Function(String, String, String) onSubmit;

  ReportFormWidget({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(234, 255, 255, 255),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Nuevo Reporte'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report1Controller,
              decoration: const InputDecoration(labelText: 'Reporte 1'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report2Controller,
              decoration: const InputDecoration(labelText: 'Reporte 2'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: report3Controller,
              decoration: const InputDecoration(labelText: 'Reporte 3'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  onSubmit(
                    report1Controller.text,
                    report2Controller.text,
                    report3Controller.text,
                  );
                  report1Controller.clear();
                  report2Controller.clear();
                  report3Controller.clear();
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImpresionPage extends StatefulWidget {
  const ImpresionPage({super.key});

  @override
  _ImpresionPageState createState() => _ImpresionPageState();
}

class _ImpresionPageState extends State<ImpresionPage> {
  final List<List<Widget>> _reports = [
    [], // Reports for ReprocessingPage
    [], // Reports for FirstPage
    [], // Reports for SecondPage
    [], // Reports for ThirdPage
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _pageTitles = ['Reprocesos', 'Extrusión', 'Impresión', 'Sellado'];

  void _addReport(String report1, String report2, String report3, int pageIndex) async {
    int newIndex = _reports[pageIndex].length + 1;

    setState(() {
      _reports[pageIndex].insert(
        0,
        _buildReportWidget(
          report1,
          report2,
          report3,
          newIndex,
          _pageTitles[pageIndex],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // Añadiendo tres reportes por cada página
    for (int pageIndex = 0; pageIndex < _reports.length; pageIndex++) {
      for (int i = 0; i < 3; i++) {
        _addReport('Reporte 1', 'Reporte 2', 'Reporte 3', pageIndex);
      }
    }
  }

  Widget _buildReportWidget(String report1, String report2, String report3,
      int index, String pageTitle) {
    return GestureDetector(
      onTap: () {
        _showOptionsDialog(index);
      },
      child: Card(
        color: const Color.fromARGB(127, 151, 235, 228),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListTile(
          title: Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              '#$index - $pageTitle',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reporte 1: $report1'),
              Text('Reporte 2: $report2'),
              Text('Reporte 3: $report3'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteReport(index - 1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(int index) {
    Get.dialog(
      OptionsDialog(
        title: 'Opciones de Reporte',
        options: [
         {
              'text': 'Imprimir Ticket',
              'onPressed': () async {
                if (_currentPage == 0) {
                  await Get.toNamed('/printExtrusionTicket');
                } else if (_currentPage == 1) {
                  await Get.toNamed('/printTicket');
                } else if (_currentPage == 2) {
                  await Get.toNamed('/sealedPrintTicket');
                }
                Get.back();
              },
            },
          {
              'text': 'Fin de Turno',
              'onPressed': () async {
                if (_currentPage == 0) {
                  await Get.toNamed('/extrusionEndWork');
                } else if (_currentPage == 1) {
                  await Get.toNamed('/endWork');
                } else if (_currentPage == 2) {
                  await Get.toNamed('/sealedEndWork');
                }
                Get.back();
              },
            },
        ],
      ),
    );
  }

  void _deleteReport(int index) {
    setState(() {
      _reports[_currentPage].removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 38, 83),
        title: const Text(
          'Pagina Reporte',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 206, 207, 209)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: const Color.fromARGB(255, 241, 242, 245),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Nuevo botón "Reprocesos"
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.loop),
                    onPressed: () {
                      _changePage(3);
                    },
                    color: const Color.fromARGB(255, 25, 38, 83),
                  ),
                  const SizedBox(height: 0),
                  const Text(
                    'Reprocesos',
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 38, 83),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_down),
                    onPressed: () {
                      _changePage(0);
                    },
                    color: _currentPage == 0
                        ? const Color.fromARGB(255, 25, 38, 83)
                        : const Color.fromARGB(255, 177, 177, 177),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    'Extrusión',
                    style: TextStyle(
                      color: _currentPage == 0
                          ? const Color.fromARGB(255, 25, 38, 83)
                          : const Color.fromARGB(255, 177, 177, 177),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.print),
                    onPressed: () {
                      _changePage(1);
                    },
                    color: _currentPage == 1
                        ? const Color.fromARGB(255, 25, 38, 83)
                        : const Color.fromARGB(255, 177, 177, 177),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    'Impresión',
                    style: TextStyle(
                      color: _currentPage == 1
                          ? const Color.fromARGB(255, 25, 38, 83)
                          : const Color.fromARGB(255, 151, 151, 151),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.send_and_archive),
                    onPressed: () {
                      _changePage(2);
                    },
                    color: _currentPage == 2
                        ? const Color.fromARGB(255, 25, 38, 83)
                        : const Color.fromARGB(255, 151, 151, 151),
                  ),
                  Text(
                    'Sellado',
                    style: TextStyle(
                      color: _currentPage == 2
                          ? const Color.fromARGB(255, 25, 38, 83)
                          : const Color.fromARGB(255, 151, 151, 151),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                ListView(
                  children: [
                    ..._reports[0],
                  ],
                ),
                ListView(
                  children: [
                    ..._reports[1],
                  ],
                ),
                ListView(
                  children: [
                    ..._reports[2],
                  ],
                ),
                // Página de "Reprocesos" con la vista ReprocessingPage
                const ReprocessingPage(), // Aquí se muestra la vista ReprocessingPage
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _currentPage == 3
          ? null // Oculta el botón flotante cuando está en la página "Reprocesos"
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 13, 139, 128),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (_currentPage == 0) {
                      _showExtrusionDialog();
                    } else if (_currentPage == 1) {
                      _showPrintDialog();
                    } else if (_currentPage == 2) {
                      _showSealedDialog();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }

  void _changePage(int index) {
    setState(() {
      _currentPage = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  void _showPrintDialog() {
    _addReport('Reporte 1', 'Reporte 2', 'Reporte 3', _currentPage);
    Get.toNamed('/printTicket');
  }

  void _showSealedDialog() {
    _addReport('Reporte 1', 'Reporte 2', 'Reporte 3', _currentPage);
    Get.toNamed('/sealedPrintTicket');
  }

  void _showExtrusionDialog() {
    Get.dialog(
      OptionsDialog(
        title: 'Bobina:--',
        optionalValue: 10,
        options: [
          {
            'text': 'Calcular peso',
            'onPressed': () async {
              _addReport('Reporte 1', 'Reporte 2', 'Reporte 3', _currentPage);
              //Get.toNamed('/printExtrusionTicket');
              Get.offNamed('/printExtrusionTicket');

            },
          },
        ],
      ),
    );
  }
}