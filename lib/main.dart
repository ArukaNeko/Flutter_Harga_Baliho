import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hitung Biaya Produksi Baliho'),
          backgroundColor: Colors.blueAccent,
        ),
        body: BiayaProduksiForm(),
      ),
    );
  }
}

class BiayaProduksiForm extends StatefulWidget {
  @override
  _BiayaProduksiFormState createState() => _BiayaProduksiFormState();
}

class _BiayaProduksiFormState extends State<BiayaProduksiForm> {
  final _formKey = GlobalKey<FormState>();
  final _panjangController = TextEditingController();
  final _lebarController = TextEditingController();

  double _totalBiaya = 0.0;
  final double hargaBahanPerM2 = 27500.0; // Harga bahan baku per meter persegi

  void _hitungBiaya() {
    if (_formKey.currentState?.validate() ?? false) {
      double panjang = double.tryParse(_panjangController.text) ?? 0.0;
      double lebar = double.tryParse(_lebarController.text) ?? 0.0;
      setState(() {
        _totalBiaya = panjang * lebar * hargaBahanPerM2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _panjangController,
                  decoration: InputDecoration(
                    labelText: 'Panjang Baliho (meter)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
                      return 'Masukkan panjang baliho';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _lebarController,
                  decoration: InputDecoration(
                    labelText: 'Lebar Baliho (meter)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
                      return 'Masukkan lebar baliho';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _hitungBiaya,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 12)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    'Hitung Biaya',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Total Biaya Produksi: Rp $_totalBiaya',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
