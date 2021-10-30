import 'package:ponddata/sqlite/repository/med_db.dart';
import 'package:flutter/material.dart';
import 'comp/comp_elevatedbutton.dart';
import 'comp/comp_textformfield.dart';
import 'comp/dropbox.dart';
import 'model/med.dart';

class PageHome extends StatefulWidget {
  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  MedDb medDb = MedDb();
  TextEditingController _contID = TextEditingController();
  TextEditingController _contN = TextEditingController();
  TextEditingController _contO = TextEditingController();
  TextEditingController _contS = TextEditingController();
  TextEditingController _contP = TextEditingController();
  TextEditingController _contT = TextEditingController();
  late String str;

  @override
  void initState() {
    super.initState();
    str = "";
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acompanhamento de Viveiro"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(20), // material design: 16
      child: ListView(
        children: [
          CompTextFormField("Nome", "Digite o nome do viveiro ", _contN,
              inputType: TextInputType.number),
          SizedBox(height: 20),
          CompTextFormField("O2", "Digite o parametro de o2 ", _contO,
              inputType: TextInputType.number),
          SizedBox(height: 20),
          CompTextFormField(
              "Sat", "Digite o  o parametro de saturação ", _contS,
              inputType: TextInputType.number),
          SizedBox(height: 20),
          CompTextFormField("PH", "Digite o parametro de Ph ", _contP,
              inputType: TextInputType.number),
          SizedBox(height: 20),
          CompTextFormField(
              "Temp", "Digite  o parametro de temperatura", _contT,
              inputType: TextInputType.number),
          SizedBox(height: 20),
          CompTextFormField("ID", "Digite  o parametro de temperatura", _contID,
              inputType: TextInputType.number),
          SizedBox(height: 20),
          CompElevatedButton(
              "Adicionar medição de viveiro", _onClickCreateEstado,
              height: 30, fontSize: 16, colorBG: Colors.blue),
          SizedBox(height: 10),
          CompElevatedButton("Atualizar medição", _onClickUpdateEstado,
              height: 30, fontSize: 16, colorBG: Colors.blue),
          SizedBox(height: 10),
          CompElevatedButton("Deletar medição", _onClickDeleteEstado,
              height: 30, fontSize: 16, colorBG: Colors.blue),
          SizedBox(height: 20),
          Text(str),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  // EVENTOS ESTADO
  //----------------------------------------------------------------------------
  Future<void> _onClickCreateEstado() async {
    print("_onClickCreateEstado");

    String name = _contN.text;
    String o2 = _contO.text;
    String sat = _contS.text;
    String temp = _contT.text;
    String ph = _contP.text;

    List<Med> listPais = await medDb.getAll();

    Med estado = Med(nome: name, o2: o2, sat: sat, temp: temp, ph: ph);
    medDb.insert(estado);
    _onClickReadEstado();
  }

  Future<void> _onClickReadEstado() async {
    print("_onClickReadEstado");

    List<Med> list = await medDb.getAll();
    str = "";

    setState(() {
      for (Med obj in list) {
        str = str + obj.toString() + "\n";
      }
    });
  }

  Future<void> _onClickUpdateEstado() async {
    print("_onClickUpdateEstado");

    List<Med> listEstado = await medDb.getAll();
    String idStr = _contID.text;
    int id = int.parse(idStr);
    Med estado = filterEstado(listEstado, id)!;

    if (estado != null) {
      estado.nome = estado.nome + " MODIF!";
      await medDb.update(estado);
    }

    _onClickReadEstado();
  }

  Future<void> _onClickDeleteEstado() async {
    print("_onClickDeleteEstado");

    List<Med> listEstado = await medDb.getAll();
    String idStr = _contID.text;
    int id = int.parse(idStr);
    Med estado = filterEstado(listEstado, id)!;

    if (estado != null) {
      await medDb.delete(estado);
    }

    _onClickReadEstado();
  }

  //----------------------------------------------------------------------------
  // EVENTOS BD
  //----------------------------------------------------------------------------
  Future<void> _onClickDeleteAllRows() async {
    print("_onClickDeleteAllRows");
    medDb.deleteAll();
  }

  //----------------------------------------------------------------------------
  // DADOS INICIAIS
  //----------------------------------------------------------------------------
  initDB() async {
    print("initDB");

    print("criando Mediçoes");
    List<Med> listEstado = [
      Med(nome: 'Med1', o2: '1', sat: '1', temp: '1', ph: '1'),
    ];

    for (Med obj in listEstado) {
      await medDb.insert(obj);
      print(obj.toString());
    }
  }

  //----------------------------------------------------------------------------
  // UTEIS
  //----------------------------------------------------------------------------

  Med? filterEstado(List<Med> list, int id) {
    for (Med obj in list) {
      if (obj.id == id) {
        return obj;
      }
    }
    return null;
  }
}
