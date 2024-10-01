import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futsal Tactics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClubPage(),
    );
  }
}

class ClubPage extends StatefulWidget {
  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<Offset?> linePoints = [];
  bool isDrawing = false;
  late Rect pistaRect;
  List<Offset> playerPositions = [];
  late List<Offset> initialPlayerPositions;
  final List<String> playerLabels = ['PV', 'AI', 'AD', 'CR', 'PT'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayerPositions();
    });
  }

  void _initializePlayerPositions([String formation = 'Predefinida']) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final pistaWidth = screenWidth * 0.9;
    final pistaHeight = screenHeight * 0.6;
    final pistaLeft = (screenWidth - pistaWidth) / 2;
    final pistaTop = screenHeight * 0.2;
    final fichaSize = pistaWidth * 0.1;

    // Definimos las formaciones
    Map<String, List<Offset>> formaciones = {
      'Predefinida': [
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.4 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.2 - fichaSize / 2, pistaTop + pistaHeight * 0.6 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.8 - fichaSize / 2, pistaTop + pistaHeight * 0.6 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.7 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.9 - fichaSize / 2),
      ],
      'LA Y': [
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.4 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.35 - fichaSize / 2, pistaTop + pistaHeight * 0.6 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.65 - fichaSize / 2, pistaTop + pistaHeight * 0.6 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.7 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.9 - fichaSize / 2),
      ],
      'PIRÁMIDE': [
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.3 - fichaSize / 2), // PV
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.5 - fichaSize / 2), // AI (debajo del PV)
        Offset(pistaLeft + pistaWidth * 0.2 - fichaSize / 2, pistaTop + pistaHeight * 0.7 - fichaSize / 2), // CR (extremo izquierdo)
        Offset(pistaLeft + pistaWidth * 0.8 - fichaSize / 2, pistaTop + pistaHeight * 0.7 - fichaSize / 2), // AD (extremo derecho)
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.9 - fichaSize / 2), // PT
      ],
      'CUADRADO': [
        Offset(pistaLeft + pistaWidth * 0.25 - fichaSize / 2, pistaTop + pistaHeight * 0.5 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.75 - fichaSize / 2, pistaTop + pistaHeight * 0.5 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.25 - fichaSize / 2, pistaTop + pistaHeight * 0.7 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth * 0.75 - fichaSize / 2, pistaTop + pistaHeight * 0.7 - fichaSize / 2),
        Offset(pistaLeft + pistaWidth / 2 - fichaSize / 2, pistaTop + pistaHeight * 0.9 - fichaSize / 2),
      ],
    };

    initialPlayerPositions = formaciones[formation]!;
    setState(() {
      playerPositions = List.from(initialPlayerPositions);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final pistaWidth = screenWidth * 0.9;
    final pistaHeight = screenHeight * 0.6;
    final pistaLeft = (screenWidth - pistaWidth) / 2;
    final pistaTop = screenHeight * 0.2;
    final fichaSize = pistaWidth * 0.1;

    pistaRect = Rect.fromLTWH(pistaLeft, pistaTop, pistaWidth, pistaHeight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF3131),
        title: Text(
          'La pizarra',
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
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              _initializePlayerPositions(value);
            },
            itemBuilder: (BuildContext context) {
              return ['Predefinida', 'LA Y', 'PIRÁMIDE', 'CUADRADO'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'FORMACIÓN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFF05225B),
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: pistaTop,
            left: pistaLeft,
            width: pistaWidth,
            height: pistaHeight,
            child: GestureDetector(
              onPanUpdate: (details) {
                if (isDrawing) {
                  final localPosition = details.localPosition;

                  final clampedPosition = Offset(
                    localPosition.dx.clamp(0.0, pistaRect.width),
                    localPosition.dy.clamp(0.0, pistaRect.height),
                  );

                  setState(() {
                    linePoints.add(clampedPosition);
                  });
                }
              },
              onPanEnd: (details) {
                if (isDrawing) {
                  setState(() {
                    linePoints.add(null); // Finalizar la línea
                  });
                }
              },
              child: Stack(
                children: [
                  Image.asset(
                    'assets/pista azul.png',
                    width: pistaRect.width,
                    height: pistaRect.height,
                    fit: BoxFit.cover,
                  ),
                  CustomPaint(
                    painter: LinePainter(linePoints, pistaRect),
                  ),
                ],
              ),
            ),
          ),
          ...playerPositions.asMap().entries.map((entry) {
            return _buildPlayer(entry.key, fichaSize, pistaLeft, pistaTop, pistaWidth, pistaHeight);
          }).toList(),
          Positioned(
            top: pistaTop - 90,
            left: pistaLeft,
            width: pistaWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircleButton(
                  icon: Icons.edit,
                  onPressed: () {
                    setState(() {
                      isDrawing = !isDrawing;
                    });
                  },
                ),
                _buildCircleButton(
                  icon: Icons.refresh,
                  onPressed: () {
                    setState(() {
                      linePoints.clear();
                      playerPositions = List.from(initialPlayerPositions);
                    });
                  },
                ),
                _buildCircleButton(
                  icon: Icons.save,
                  onPressed: () {
                    print('Guardar cambios');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayer(int index, double fichaSize, double pistaLeft, double pistaTop, double pistaWidth, double pistaHeight) {
    return Positioned(
      left: playerPositions[index].dx,
      top: playerPositions[index].dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (!isDrawing) {
            setState(() {
              final newPosition = Offset(
                playerPositions[index].dx + details.delta.dx,
                playerPositions[index].dy + details.delta.dy,
              );
              _updatePosition(index, newPosition, pistaLeft, pistaTop, pistaWidth, pistaHeight, fichaSize);
            });
          }
        },
        child: Container(
          width: fichaSize,
          height: fichaSize,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              playerLabels[index],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fichaSize * 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFFF3131),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _updatePosition(int index, Offset newPosition, double pistaLeft, double pistaTop, double pistaWidth, double pistaHeight, double fichaSize) {
    double newX = newPosition.dx.clamp(pistaLeft, pistaLeft + pistaWidth - fichaSize);
    double newY = newPosition.dy.clamp(pistaTop, pistaTop + pistaHeight - fichaSize);

    setState(() {
      playerPositions[index] = Offset(newX, newY);
    });
  }
}

class LinePainter extends CustomPainter {
  final List<Offset?> points;
  final Rect pistaRect;

  LinePainter(this.points, this.pistaRect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    Offset? lastPoint;

    for (var point in points) {
      if (point == null) {
        lastPoint = null;
        continue;
      }

      final clampedPoint = Offset(
        point.dx.clamp(0.0, pistaRect.width),
        point.dy.clamp(0.0, pistaRect.height),
      );

      if (lastPoint != null) {
        final clampedLastPoint = Offset(
          lastPoint.dx.clamp(0.0, pistaRect.width),
          lastPoint.dy.clamp(0.0, pistaRect.height),
        );
        canvas.drawLine(clampedLastPoint, clampedPoint, paint);
      }
      lastPoint = clampedPoint;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}