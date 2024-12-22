import 'package:flutter/material.dart';

import 'package:mada_unofficial/mada_unofficial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String?> _callbacks = ["mada plugin implementation example"];
  late final MadaUnofficial _madaUnofficialPlugin;
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _madaUnofficialPlugin = MadaUnofficial(_madaCallback);
  
  }

  void _madaCallback(String? callback) {
    setState(() {
      _callbacks.add(callback);
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mada flutter example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: TextField(controller: _amountController)),
                  ElevatedButton(
                      onPressed: () {
                        final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
                        if (amount == 0.0) {
                          return;
                        }
                        _madaUnofficialPlugin.sendPurchaseCommand(amount: amount);
                      },
                      child: const Text("Purchase"))
                ],
              ),
              Expanded(
                child: Center(
                  child: ListView(children: _callbacks.map((e) => Text("$e")).toList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
