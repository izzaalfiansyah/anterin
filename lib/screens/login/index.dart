import 'package:anterin/blocs/auth.dart';
import 'package:anterin/blocs/loader.dart';
import 'package:anterin/components/hr.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/utils/dialog.dart';
import 'package:anterin/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_validator/form_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginForm = GlobalKey<FormState>();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: loginForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selamat Datang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text('Masukkan data anda untuk mulai menjelajah!'),
              SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                ),
                validator: ValidationBuilder().email().required().build(),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                validator: ValidationBuilder().required().build(),
              ),
              SizedBox(height: 40),
              BlocBuilder<LoaderBloc, bool>(
                builder: (context, state) {
                  return FilledButton(
                    onPressed: state
                        ? null
                        : () async {
                            if (loginForm.currentState!.validate()) {
                              loaderInstance(context).on();
                              final res =
                                  await BlocProvider.of<AuthBloc>(context)
                                      .login(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              showNotification(
                                context,
                                message: res.message,
                                error: res.isError,
                              );

                              loaderInstance(context).off();
                            }
                          },
                    style: FilledButton.styleFrom(
                      backgroundColor: cPrimary,
                      fixedSize: Size.fromWidth(size.width),
                    ),
                    child: Text('LOGIN'),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Hr(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'ATAU',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Expanded(
                      child: Hr(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {
                  Modular.to.pushNamed('/register');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: cPrimary),
                  ),
                  fixedSize: Size.fromWidth(size.width),
                ),
                child: Text(
                  'DAFTAR AKUN',
                  style: TextStyle(
                    color: cPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
