import 'package:flutter/material.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../ui/input_decoration.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const WelcomeBackground(),
          ChangeNotifierProvider(
            create: (context) => LoginFormProvider(),
            child: const LoginForm(),
          ),
          Positioned(
              bottom: 30,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: size.width),
                  const Text('"Nombre empresa"',
                      style: TextStyle(color: AppTheme.subtitles)),
                  const Text('Desarrollado por Jean Marko Aguirre',
                      style: TextStyle(color: AppTheme.subtitles)),
                ],
              ))
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _passwordVisible = true;
  bool _errorMessage = false;
  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
   void _message() {
    setState(() {
      _errorMessage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width * 0.85,
            height: size.height * 0.4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Form(
                    key: loginForm.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecorations.authInputDecoration(
                              hintText: 'correo',
                              labelText: 'Correo electrónico',
                              prefixIcon: Icons.alternate_email_rounded),
                          onChanged: (value) => loginForm.email = value,
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);

                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'Ingrese un correo valido';
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          autocorrect: false,
                          obscureText: _passwordVisible,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecorations.authInputDecoration(
                              hintText: '*****',
                              labelText: 'Contraseña',
                              prefixIcon: Icons.lock_outline,
                              suffix: IconButton(
                                onPressed: () => _toggle(),
                                icon: _passwordVisible == true
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.remove_red_eye_outlined),
                                color: AppTheme.primary,
                              )),
                          onChanged: (value) => loginForm.password = value,
                          validator: (value) {
                            return (value != null && value.length >= 5)
                                ? null
                                : 'Ingrese una contraseña correcta';
                          },
                        ),
                        _errorMessage
                            ? Column(
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Correo o contraseña incorrecta',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                              onPressed: loginForm.isLoading
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();

                                      final authService =
                                          Provider.of<AuthService>(context,
                                              listen: false);
                                     final uiProvider= Provider.of<UiProvider>(context, listen: false);

                                     
                                      if (!loginForm.isValidForm()) return;
                                      loginForm.isLoading = true;
                                      // await Future.delayed(const Duration(seconds: 2));
                                      final String? token =
                                          await authService.login(
                                              loginForm.email,
                                              loginForm.password);

                                     
                                      loginForm.isLoading = false;
                                      
                                      if (token != null ) {
                                       
                                        uiProvider.selectedMenuOpt = 0;

                                        Navigator.pushReplacementNamed(
                                            context, 'navigationScreen');
                                      } else {
                                        _message();
                                      }
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  loginForm.isLoading
                                      ? 'Cargando...'
                                      : 'Iniciar Sesión',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'signInScreen');
              },
              child: const Text(
                'Crea una cuenta y sé parte de esta experiencia',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
