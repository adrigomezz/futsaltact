import 'dart:async';
import 'package:flutter/material.dart';

class EntrenamientoListaPage extends StatefulWidget {
  final String playerName;
  final String playerPosition;

  EntrenamientoListaPage({required this.playerName, required this.playerPosition});

  @override
  _EntrenamientoListaPageState createState() => _EntrenamientoListaPageState();
}

class _EntrenamientoListaPageState extends State<EntrenamientoListaPage> {
  final List<Map<String, dynamic>> _entrenamientos = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  void _addTask(String task, String duration) {
    if (task.isNotEmpty) {
      setState(() {
        _entrenamientos.add({
          'task': task,
          'duration': duration.isEmpty ? '00:00:00' : duration, // Default duration if empty
          'completed': false,
          'icon': Icons.sports_soccer,
          'timer': null,
        });
      });
      _taskController.clear();
      _durationController.clear();
      // Start timer only if duration is provided and not the default
      if (duration.isNotEmpty) {
        _startTimer(_entrenamientos.length - 1, duration);
      }
    } else {
      // Show error message if task name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, ingrese el nombre del ejercicio.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
  void _startTimer(int index, String duration) {
    List<String> parts = duration.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    _entrenamientos[index]['timer'] = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
          int hours = totalSeconds ~/ 3600;
          int minutes = (totalSeconds % 3600) ~/ 60;
          int seconds = totalSeconds % 60;
          _entrenamientos[index]['duration'] = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _entrenamientos[index]['completed'] = !_entrenamientos[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      if (_entrenamientos[index]['timer'] != null) {
        _entrenamientos[index]['timer'].cancel();
      }
      _entrenamientos.removeAt(index);
    });
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFF3131),
          title: Text(
            "¿Seguro que quieres volver a atrás?",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Se eliminarán los ejercicios asignados.",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo y no hacer nada
              },
              style: TextButton.styleFrom(
                side: BorderSide(color: Colors.white),
              ),
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.of(context).pop(); // Volver a la página anterior
              },
              style: TextButton.styleFrom(
                side: BorderSide(color: Colors.white),
              ),
              child: Text(
                "Aceptar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF3131),
        elevation: 0,
        title: Text(
          'Lista de entrenamientos',
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
            _showExitConfirmationDialog(); // Mostrar diálogo de confirmación
          },
        ),
      ),
      body: SafeArea( // SafeArea added to prevent content from being overlapped by the AppBar
        child: Container(
          color: Color(0xFF05225B), // Color sólido de fondo
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jugador: ${widget.playerName}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'Posición: ${widget.playerPosition}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Ejercicio:',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _durationController,
                decoration: InputDecoration(
                  labelText: 'Duración (opcional):',
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
                  _addTask(_taskController.text, _durationController.text);
                },
                child: Text(
                  'Añadir Ejercicio',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _entrenamientos.length,
                  itemBuilder: (context, index) {
                    final task = _entrenamientos[index];
                    return Card(
                      color: Color(0xFFFF3131),
                      child: ListTile(
                        leading: Icon(task['icon'], color: Colors.white),
                        title: Text(
                          task['task'],
                          style: TextStyle(
                            color: Colors.white,
                            decoration: task['completed'] ? TextDecoration.lineThrough : null,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        subtitle: Text(
                          'Duración: ${task['duration']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: task['completed'],
                              onChanged: (value) {
                                _toggleCompletion(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                _deleteTask(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}