import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void validateCredentials() {
      String username = usernameController.text;
      String password = passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Por favor, complete todos los campos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (username == "desarrollo" && password == "2024") {
        Fluttertoast.showToast(
          msg: "Acceso concedido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Fluttertoast.showToast(
          msg: "Credenciales incorrectas",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/fondo-login.jpg",
                fit: BoxFit.cover,
              ),
              Center(
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/banner-baculo.png'),
                        const Text(
                          'Ingresa Credenciales',
                          style: TextStyle(
                            fontFamily: 'Saiyan-Sans',
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_pin_circle,
                              size: 20,
                            ),
                            labelText: 'Usuario',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              size: 20,
                            ),
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            onPressed: validateCredentials,
                            label: const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Saiyan-Sans',
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.black87),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(vertical: 13.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
