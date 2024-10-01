import 'package:flutter/material.dart';
import 'EntrenamientoListaPage.dart';

class EntrenamientoIndividualPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF3131), 
        elevation: 0, 
        title: Text(
          'Entrenamiento individual',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.italic,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color(0xFF05225B), // Color sólido de fondo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Jugador',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(
                labelText: 'Posición del Jugador',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF3131),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EntrenamientoListaPage(
                      playerName: _nameController.text,
                      playerPosition: _positionController.text,
                    ),
                  ),
                );
              },
              child: Text(
                'Configurar Entrenamiento',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}