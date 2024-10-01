import 'package:flutter/material.dart';
import 'SecondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futsal Tact',
      theme: ThemeData(
        primaryColor: Colors.transparent, // El color primario será transparente, más que nada porque el fondo es una imagen. Podría haber borrado estas líneas pero ya que no producen ningún efecto contraproducente no afectan al estado de la página
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Esto es la página de inicio, pero no la página principal. La página principal con los submenús será "SecondPage", que contendrá 4 cards y una barra de navegación inferior
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _nameAnimationController;
  late Animation<double> _nameOpacityAnimation;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonOffsetAnimation;

  @override
  void initState() {
    super.initState();

    _nameAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _nameAnimationController.forward();

    _nameOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _nameAnimationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
    _nameAnimationController.repeat(reverse: true);

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _buttonAnimationController.forward();

    _buttonOffsetAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _nameAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/Banner app.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _nameOpacityAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _nameOpacityAnimation.value,
                      child: Column(
                        children: [
                          Text(
                            'FUTSAL TACT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 2.5), // Pequeño espacio entre el título y el texto pequeño
                          Text(
                            'by ARGO Studio',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 40),

                AnimatedBuilder(
                  animation: _buttonOffsetAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _buttonOffsetAnimation.value),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SecondPage()), // Al pulsar iremos a secondPage, donde nos encontraremos con el menú y 4 cards a modo de opciones
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              'Pulsa el botón para iniciar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}