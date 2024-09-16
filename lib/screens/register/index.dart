import 'package:anterin/blocs/auth.dart';
import 'package:anterin/blocs/loader.dart';
import 'package:anterin/constants/app.dart';
import 'package:anterin/utils/dialog.dart';
import 'package:anterin/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  final registerForm = GlobalKey<FormState>();

  bool showPassword = false;
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.user != null) {
            showNotification(context, message: 'Berhasil register');
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: EdgeInsets.all(20),
            child: Form(
              key: registerForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Buat Akun Baru',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text('Mari bergabung dan mulai pengalaman anda!'),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Nama',
                      labelText: 'Nama',
                    ),
                    validator:
                        ValidationBuilder().minLength(5).required().build(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: 'Nomor Telepon',
                      labelText: 'Nomor Telepon',
                    ),
                    validator: ValidationBuilder().phone().required().build(),
                  ),
                  SizedBox(height: 20),
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
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    validator:
                        ValidationBuilder().minLength(8).required().build(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordConfirmationController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      hintText: 'Konfirmasi Password',
                      labelText: 'Konfirmasi Password',
                    ),
                    validator:
                        ValidationBuilder().minLength(8).required().add((val) {
                      if (val != passwordController.text) {
                        return 'Password missmatch';
                      }

                      return null;
                    }).build(),
                  ),
                  SizedBox(height: 20),
                  FormField(
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isAgree,
                                onChanged: (val) {
                                  setState(() {
                                    isAgree = val ?? false;
                                  });
                                },
                                side: BorderSide(
                                  width: 1.5,
                                  color: field.hasError
                                      ? Colors.red.shade800
                                      : Colors.grey.shade800,
                                ),
                                activeColor: cPrimary,
                              ),
                              Expanded(
                                child: Text(
                                  'Saya menyetujui kebijakan dan privasi.',
                                  style: TextStyle(
                                    color: field.hasError
                                        ? Colors.red.shade800
                                        : null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                    validator: (value) {
                      final validate = ValidationBuilder().required().build();

                      return validate(isAgree ? 'agree' : null);
                    },
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<LoaderBloc, bool>(
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: state
                            ? null
                            : () async {
                                if (registerForm.currentState!.validate()) {
                                  loaderInstance(context).on();
                                  final res =
                                      await BlocProvider.of<AuthBloc>(context)
                                          .register(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    passwordConfirmation:
                                        passwordConfirmationController.text,
                                  );
                                  loaderInstance(context).off();

                                  showNotification(
                                    context,
                                    message: res.message,
                                    error: res.isError,
                                  );
                                }
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: cPrimary,
                          fixedSize: Size.fromWidth(size.width),
                        ),
                        child: Text('DAFTAR SEKARANG'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
