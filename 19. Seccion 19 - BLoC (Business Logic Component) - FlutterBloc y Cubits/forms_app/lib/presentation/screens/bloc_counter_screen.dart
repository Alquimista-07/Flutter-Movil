import 'package:flutter/material.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Counter'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: const Center(
        child: Text('Counter value: 000'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            // NOTA: Este heroTag es para cuando tenemos más de un FloatingActionButton, ocupamos decirle a Flutter cual es el
            //       FloatingActionButton que se anima por defecto entre Scaffolds
            heroTag: '1',
            child: const Text('+3'),
            onPressed: () => {},
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => {},
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
