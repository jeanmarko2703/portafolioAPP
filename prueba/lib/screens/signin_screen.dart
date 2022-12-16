
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../theme/app_theme.dart';
import '../ui/input_decoration.dart';
import '../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const WelcomeBackground(),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text('Registro',
                          style:
                              TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      ChangeNotifierProvider(
                        create: (context) => SigninFormProvider(),
                        child:  SignInForm(),
                      ),
                      
                    ],
                  ),
                ),
                // SizedBox(height: 40,),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, 'logInScreen');
                }, child: Text('Ya tengo una cuenta registrada?', style: TextStyle(color: Colors.black),))
               
                
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

   bool _passwordVisible = false;
  bool _errorMessage=false;
  
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
    final signInForm = Provider.of<SigninFormProvider>(context);
    return  Form(
      key: signInForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:5.0),
        child: Column( children: [
    
           TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'correo',
                      labelText: 'Correo electrónico',
                      prefixIcon: Icons.alternate_email_rounded),
                  onChanged: (value) => signInForm.email = value,
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
                  onChanged: (value) => signInForm.password = value,
                  validator: (value) {
                    return (value != null && value.length >= 5)
                        ? null
                        : 'Ingrese una contraseña con 5 caracteres';
                  },
                  obscureText: !_passwordVisible,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Contraseña',
                      labelText: 'Contraseña',
                      
                      prefixIcon: Icons.lock),
                ),
                const SizedBox(height: 15),
                
                TextFormField(
                  
                  
                  validator: (value) {
                    return (value == signInForm.password )
                        ? null
                        : 'Ingrese la misma contraseña';
                  },
                  obscureText: !_passwordVisible,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Repetir contraseña',
                      labelText: 'Repetir contraseña',
                     
                      prefixIcon: Icons.lock),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Ver contraseña', style: TextStyle(fontWeight: FontWeight.w400),),
                      IconButton(
                              onPressed: () => _toggle(),
                              icon: _passwordVisible == false
                                  ? const Icon(Icons.check_box_outline_blank)
                                  : const Icon(Icons.check_box_outlined),
                              color: AppTheme.primary,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
    
                 
                    onPressed: signInForm.isLoading
                        ? null
                        : () async {
    
                           FocusScope.of(context).unfocus();
                            
                            final authService =
                                Provider.of<AuthService>(context, listen: false);
                            if (!signInForm.isValidForm()) return;
                            signInForm.isLoading = true;
                            // await Future.delayed(const Duration(seconds: 2));
                            final String? token = await authService.createUser(
                                signInForm.email, signInForm.password);
                            signInForm.isLoading = false;
                            if(token!=null){
                              print(token);
                               Navigator.pushReplacementNamed(context, 'logInScreen');
                               
    
    
                             
    
                            }
                            else{ _message(); }
                             
                            
                           
                           
                          },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        signInForm.isLoading ? 'Cargando...' : 'Registrarse',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                   
                _errorMessage?Column(children: [ SizedBox( height: 10, ),Text('Hubo un error, intentelo nuevamente', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)],):SizedBox( ),
                SizedBox( height: 10, )
    
    
        ],),
      ),
    );
   
  }
}

