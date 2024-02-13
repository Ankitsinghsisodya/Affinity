import 'package:affinity/services/user_repsoitory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affinity/genderdropdown.dart';
import 'package:affinity/models/crushlist_model.dart';
import 'package:affinity/util/show_snackbar.dart';
import 'package:affinity/crushscreenmobile.dart';

class CrushScreen extends StatelessWidget {
  const CrushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Widget currentPage;
    if (screenSize.width < 1120) {
      currentPage = const CrushMobileForm();
    } else {
      currentPage = const CrushForm();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [currentPage],
    );
  }
}

class CrushForm extends StatefulWidget {
  const CrushForm({
    super.key,
  });

  @override
  State<CrushForm> createState() => _CrushFormState();
}

class _CrushFormState extends State<CrushForm> {
  final TextEditingController name = TextEditingController();
  final TextEditingController branch = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController sec = TextEditingController();
  final TextEditingController password = TextEditingController();

  final List<String> names = ["", "", "", "", ""];
  int index = 0;

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    branch.dispose();
    year.dispose();
    sec.dispose();
    sec.dispose();
  }

  final userRepo = Get.put(UserRepository());

  void save() {
    if (name.text.isEmpty || branch.text.isEmpty || year.text.isEmpty) {
      return;
    }
    final String sname = "${name.text} ${branch.text} ${year.text}";
    names[index % 5] = sname;
    submit();
    setState(() {
      index++;
    });
  }

  void submit() async {
    final crushList = CrushListModel(
        name1: names[0],
        name2: names[1],
        name3: names[2],
        name4: names[3],
        name5: names[4]);
    await userRepo.createCrushList(crushList);
    showSnackBar(context, "Saved!");
  }

  _fetch() async {
    final db = FirebaseFirestore.instance;
    final email = FirebaseAuth.instance.currentUser!.email;
    final docRef = db.collection("users").doc(email);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final nList = [
          data['name1'],
          data['name2'],
          data['name3'],
          data['name4'],
          data['name5']
        ];
        setState(() {
          for (int i = 0; i < nList.length; i++) {
            if (nList[i] != null && nList[i] != "") {
              names[i] = nList[i];
            } else {
              index = i;
              break;
            }
          }
        });
        // ...
      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    _fetch();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 500,
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Crush Name',
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextField(
                controller: branch,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Crush Branch',
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextField(
                controller: year,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Crush Batch',
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextField(
                controller: sec,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Crush Section (Optional)',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const GenderDropDown(),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //minimumSize: const Size(100, 40),
                backgroundColor: Colors.red,
              ),
              onPressed: save,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: Text(
                  "Save",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 250,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromARGB(111, 228, 151, 151),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < names.length; i++)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${i + 1}) ${names[i]}",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //minimumSize: const Size(100, 40),
                  backgroundColor: Colors.red,
                ),
                onPressed: submit,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "There is a limit of 5 names, \nIf you want to edit your list,\nthen start filling again to override\nand to delete just fill this '__' in every section",
                style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "The Matches will be declared after 14th Feb\n.Portal will close on 14th Feb",
                style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
