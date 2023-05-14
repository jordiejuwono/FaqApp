import 'package:faq_app/common/constants.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/presentation/screen/add_faq/provider/add_faq_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFaqPage extends StatefulWidget {
  static const routeName = "/add-faq";
  const AddFaqPage({super.key});

  @override
  State<AddFaqPage> createState() => _AddFaqPageState();
}

class _AddFaqPageState extends State<AddFaqPage> {
  final TextEditingController _pertanyaanController = TextEditingController();
  final TextEditingController _jawabanController = TextEditingController();

  @override
  void dispose() {
    _pertanyaanController.dispose();
    _jawabanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          title: Text(
            "Add FAQ",
            style: kHeading6,
          ),
        ),
        body: _addFaqContent(),
      ),
    );
  }

  Consumer<AddFaqNotifier> _addFaqContent() {
    return Consumer<AddFaqNotifier>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pertanyaan:",
                          style: kHeading6,
                        ),
                        TextField(
                          controller: _pertanyaanController,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Jawaban:",
                          style: kHeading6,
                        ),
                        TextField(
                          controller: _jawabanController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 120.0,
                  child: ElevatedButton(
                      onPressed: () {
                        value.postFaq(PostFaqRequest(
                          pertanyaan: _pertanyaanController.text,
                          jawaban: _jawabanController.text,
                          statusPublish: true,
                        ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade400)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.delete),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Add FAQ",
                              style: kTextMediumNormal,
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
