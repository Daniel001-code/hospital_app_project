import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habilae_project/model/diagnosis_Model.dart';
import 'package:habilae_project/screens/Login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? userType;
  final String? userName;

  const HomeScreen({super.key, this.userType, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DiagnosisModel> diagnosisList = [
    DiagnosisModel(
        doctor: 'Mr Wolf',
        diagnosis:
            'This field will contain the result obtained from the doctor after proper medical checks have been made.'),
  ];

  TextEditingController inputDiagnosis = TextEditingController();
  TextEditingController doctorsName = TextEditingController();

  void _showDialog() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 229, 240, 249),
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 30,
                          )),
                    ],
                  ),
                  const Text(
                    "Doctor's Diagnosis",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  TextField(
                    controller: inputDiagnosis,
                    decoration: InputDecoration(
                      hintText: 'Input Diagnosis',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextField(
                    controller: doctorsName,
                    decoration: InputDecoration(
                      hintText: "Doctor's name",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addDiagnosis(
                            doctorsName.value.text, inputDiagnosis.value.text);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'upload',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                ],
              ),
            ),
          );
        });
  }

  void deleteDiagnosis(int index) {
    diagnosisList.removeAt(index);
  }

  void addDiagnosis(String doctor, String diagnosis) {
    diagnosisList.add(DiagnosisModel(doctor: doctor, diagnosis: diagnosis));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext) {
                  return const AlertDialog(
                    content: Text(
                        'Contacting Doctor..., you will get a message shortly'),
                  );
                });
            await Future.delayed( const Duration(seconds: 3));
            Navigator.pop(context);
          },
          child: const Icon(Icons.phone),
        ),
        backgroundColor: const Color.fromARGB(255, 219, 234, 247),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome ${widget.userName ?? 'User1'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      size: 30,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Text(
                'Here is your blood anemia diagnosis',
                style: TextStyle(fontSize: 17, color: Colors.red),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Center(
                  child: widget.userType == 'admin'
                      ? ElevatedButton(
                          onPressed: () {
                            _showDialog();
                          },
                          child: const Text(
                            'Add Diagnosis',
                            style: TextStyle(fontSize: 17),
                          ))
                      : Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Color.fromARGB(255, 234, 235, 235)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Text(
                              'Results',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
              Expanded(
                child: ListView.builder(
                    itemCount: diagnosisList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              children: [
                                const Text(
                                  'Diagnosis',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  diagnosisList[index].diagnosis,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Doctor: ${diagnosisList[index].doctor}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (widget.userType == 'admin')
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            deleteDiagnosis(index);
                                          });
                                        },
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.red)),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
