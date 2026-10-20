import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const GelismisHesapMakinesiApp());
}

class GelismisHesapMakinesiApp extends StatelessWidget {
  const GelismisHesapMakinesiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HesapMakinesiEkrani(),
    );
  }
}

class HesapMakinesiEkrani extends StatefulWidget {
  const HesapMakinesiEkrani({super.key});

  @override
  State<HesapMakinesiEkrani> createState() => _HesapMakinesiEkraniState();
}

class _HesapMakinesiEkraniState extends State<HesapMakinesiEkrani> {
  String _gosterge = "0";
  double _sayi1 = 0;
  double _sayi2 = 0;
  String _islem = "";
  bool _yeniSayiGiriliyor = true;

  void _butonaBasildi(String butonMetni) {
    setState(() {
      if (butonMetni == "C") {
        _gosterge = "0";
        _sayi1 = 0;
        _sayi2 = 0;
        _islem = "";
        _yeniSayiGiriliyor = true;
      } else if (butonMetni == "⌫") {
        if (_gosterge.length > 1) {
          _gosterge = _gosterge.substring(0, _gosterge.length - 1);
        } else {
          _gosterge = "0";
          _yeniSayiGiriliyor = true;
        }
      } else if (butonMetni == "+" ||
          butonMetni == "-" ||
          butonMetni == "×" ||
          butonMetni == "÷") {
        _sayi1 = double.parse(_gosterge);
        _islem = butonMetni;
        _yeniSayiGiriliyor = true;
      } else if (butonMetni == "=") {
        _sayi2 = double.parse(_gosterge);
        if (_islem == "+") _gosterge = (_sayi1 + _sayi2).toString();
        if (_islem == "-") _gosterge = (_sayi1 - _sayi2).toString();
        if (_islem == "×") _gosterge = (_sayi1 * _sayi2).toString();
        if (_islem == "÷") {
          _gosterge = _sayi2 != 0 ? (_sayi1 / _sayi2).toString() : "Hata";
        }
        _islem = "";
        _yeniSayiGiriliyor = true;
      } else if (butonMetni == "√") {
        double sayi = double.parse(_gosterge);
        _gosterge = sayi >= 0 ? sqrt(sayi).toString() : "Hata";
        _yeniSayiGiriliyor = true;
      } else if (butonMetni == "x²") {
        double sayi = double.parse(_gosterge);
        _gosterge = (sayi * sayi).toString();
        _yeniSayiGiriliyor = true;
      } else if (butonMetni == "%") {
        double sayi = double.parse(_gosterge);
        _gosterge = (sayi / 100).toString();
        _yeniSayiGiriliyor = true;
      } else {
        if (_gosterge == "0" || _yeniSayiGiriliyor) {
          _gosterge = butonMetni;
          _yeniSayiGiriliyor = false;
        } else {
          _gosterge += butonMetni;
        }
      }

      // Gereksiz .0 uzantılarını temizle
      if (_gosterge.endsWith(".0")) {
        _gosterge = _gosterge.substring(0, _gosterge.length - 2);
      }
    });
  }

  Widget _butonOlustur(String metin, {Color? renk, Color? yaziRengi}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: renk ?? Colors.grey[850],
            foregroundColor: yaziRengi ?? Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => _butonaBasildi(metin),
          child: Text(
            metin,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gelişmiş Hesap Makinesi')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _gosterge,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _butonOlustur("C", renk: Colors.orangeAccent),
                  _butonOlustur("%", renk: Colors.orangeAccent),
                  _butonOlustur("÷", renk: Colors.orangeAccent),
                  _butonOlustur("⌫",renk: Colors.redAccent),
                ],
              ),
              Row(
                children: [
                  _butonOlustur("√", renk: Colors.blueGrey),
                  _butonOlustur("x²", renk: Colors.blueGrey),
                  _butonOlustur("×" , renk: Colors.blueGrey),
                  _butonOlustur("-" , renk: Colors.blueGrey),
                ],
              ),
             Row(
  children: [
    _butonOlustur("9"),
    _butonOlustur("7"),
    _butonOlustur("4"),
    _butonOlustur("5"),
  ],
),
              Row(
                children: [
                  _butonOlustur("6"),
                  _butonOlustur("8", renk: Colors.orange),
                  _butonOlustur("1"),
                  _butonOlustur("2"),
                ],
              ),
              Row(
                children: [
                  _butonOlustur("3"),
                  _butonOlustur("+", renk: Colors.orange),
                  _butonOlustur("0"),
                  _butonOlustur(".", renk: Colors.grey[800]),
                ],
              ),
              Row(
                children: [
                  _butonOlustur("=", renk: Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}