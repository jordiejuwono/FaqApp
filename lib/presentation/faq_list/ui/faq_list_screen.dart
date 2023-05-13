import 'package:faq_app/common/constants.dart';
import 'package:faq_app/presentation/faq_list/provider/faq_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaqListScreen extends StatefulWidget {
  const FaqListScreen({super.key});

  @override
  State<FaqListScreen> createState() => _FaqListScreenState();
}

class _FaqListScreenState extends State<FaqListScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<FaqListNotifier>(context, listen: false).fetchFaqList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Consumer<FaqListNotifier>(
          builder: (context, value, child) {
            return ListView.builder(
                itemCount: value.faqList?.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.faqList?.data[index].pertanyaan ?? "",
                                style: kTextMediumBold,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                value.faqList?.data[index].jawaban ?? "",
                                style: kTextSmallNormal.copyWith(
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        )),
                  );
                });
          },
        ),
      ),
    );
  }
}
