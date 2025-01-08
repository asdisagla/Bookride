import 'package:flutter/material.dart';
import 'package:flutter_finance_app/pages/login_page.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController _email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController Lastname = TextEditingController();
  TextEditingController biodata = TextEditingController();
  // signUp(
  //     BuildContext context, String name, String email, String password) async {
  //   try {
  //     UserCredential userCredential =
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final firestore = FirebaseFirestore.instance;
  //
  //     // Create a reference to the document
  //     final documentReference =
  //     firestore.doc('users/${userCredential.user!.uid}');
  //
  //     // Write data to the document
  //     await documentReference.set({
  //       'name': name,
  //       'email': email,
  //       // Other fields
  //     });
  //     Fluttertoast.showToast(
  //         msg: "User sign up successful",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.pop(context);
  //   } catch (e) {
  //     if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
  //       Fluttertoast.showToast(
  //           msg: "Email is already in use",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print('Error: Email is already in use.');
  //       // Display error message to the user, e.g., using a Flutter SnackBar
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Error signing up user: $e",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print('Error signing up user: $e');
  //       // Display a generic error message to the user
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.orangeAccent,
              Colors.black,
              Colors.orangeAccent,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Register Account",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          Expanded(flex:5,
                            child: TextFormField(
                            controller: firstname,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),),
                          const SizedBox(width: 10),
                          Expanded(flex:5,
                            child: TextFormField(
                              controller: Lastname,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),)
                        ],),

                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: biodata,
                          decoration: InputDecoration(
                            hintText: 'Enter your Biodata',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          maxLines: 2,  // maximum number of lines allowed
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        isLoading == true
                            ? Center(
                          child: Container(
                            child: CircularProgressIndicator(
                              color: Colors.orange.shade800,
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                                 // setState(() {
                                 //  isLoading = true;
                                 // });
                                 // signUp(
                                 //     this.context,
                                 //     '${firstname.text.toString()}${Lastname.text.toString()}',
                                 //     '${_email.text.toString()}',
                                 //     '${password.text.toString()}');
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent, borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                "Sign UP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',style: TextStyle(color: Colors.white,),),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
