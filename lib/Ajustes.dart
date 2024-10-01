import 'package:flutter/material.dart';
import 'main.dart';
import 'Perfil.dart';
import 'SecondPage.dart'; // Asegúrate de importar SecondPage

class AjustesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Ajustes',
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
      body: Stack(
        children: [
          Container(
            color: Color(0xFF05225B), // Color de fondo sólido
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black,
                    color: Color(0xFFFF3131), // Color sólido 0xFFFF3131
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 40,
                          ),
                          title: Text(
                            'Ajustes',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                          height: 0,
                          indent: 16,
                          endIndent: 16,
                        ),
                        _buildOptionButton(context, 'Acerca de', 'Sobre Futsal Tact', () {
                          _showDialog(context, 'Acerca de', generateAboutText());
                        }),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                          height: 0,
                          indent: 16,
                          endIndent: 16,
                        ),
                        _buildOptionButton(context, 'Acuerdo de usuario', 'Leer acuerdo de usuario', () {
                          _showDialog(context, 'Acuerdo de usuario', generateUserAgreementText());
                        }),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                          height: 0,
                          indent: 16,
                          endIndent: 16,
                        ),
                        _buildOptionButton(context, 'Política de privacidad', 'Consultar política de privacidad', () {
                          _showDialog(context, 'Política de privacidad', generatePrivacyPolicyText());
                        }),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black,
                    color: Color(0xFFFF3131), // Color sólido 0xFFFF3131
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 40,
                          ),
                          title: Text(
                            'Cerrar sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 2,
                          height: 0,
                          indent: 16,
                          endIndent: 16,
                        ),
                        _buildOptionButton(context, 'Cerrar sesión', '¿Seguro que quieres cerrar sesión?', () {
                          _showLogoutDialog(context);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerfilPage()),
                );
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 36, color: Colors.black),
                    Text(
                      'Perfil',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()), // Cambio a SecondPage
                );
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, size: 36, color: Colors.black),
                    Text(
                      'Inicio',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AjustesPage()),
                );
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, size: 36, color: Colors.black),
                    Text(
                      'Ajustes',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String title, String subtitle, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFF3131),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFF3131),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
            ),
          ),
          content: Text(
            '¿Seguro que quieres cerrar sesión?',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Cerrar sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String generateAboutText() {
    return '¡Bienvenido a FUTSAL TACT, la herramienta esencial para entrenadores de fútbol sala! En FUTSAL TACT, nos dedicamos a proporcionar a los entrenadores las herramientas necesarias para llevar sus equipos al siguiente nivel. Con nuestra aplicación, puedes crear y analizar tácticas detalladas para cada aspecto del juego, desde la defensa hasta la ofensiva. Nuestra interfaz intuitiva te permite diseñar formaciones personalizadas, establecer estrategias específicas y ajustarlas sobre la marcha según las necesidades del partido.';
  }

  String generateUserAgreementText() {
    return 'Acuerdo de Usuario de FUTSAL TACT, Última actualización: 13/05/2024. Bienvenido a FUTSAL TACT. Al usar nuestra aplicación ("la Aplicación"), aceptas estos términos y condiciones: Licencia de Uso: Te otorgamos una licencia limitada, no exclusiva y no transferible para usar la Aplicación. Uso Aceptable: Usarás la Aplicación de manera legal y responsable. No puedes dañar, deshabilitar o comprometer la seguridad de la Aplicación. Datos del Usuario: Recopilamos y utilizamos tu información personal según nuestra Política de Privacidad. Propiedad Intelectual: Todos los derechos de la Aplicación y su contenido son de nuestra propiedad. No puedes copiar ni distribuir la Aplicación sin permiso.';
  }

  String generatePrivacyPolicyText() {
    return 'Política de Privacidad de FUTSAL TACT, Última actualización: 13/05/2024. Información Recopilada: Recopilamos tu nombre, correo electrónico y cualquier otra información que proporciones al usar la Aplicación. Uso de la Información: Utilizamos tu información para ofrecer y mejorar nuestros servicios, y para comunicarnos contigo. Compartir Información: No compartimos tu información personal con terceros, salvo que sea necesario para nuestros servicios o estemos legalmente obligados.';
  }
}