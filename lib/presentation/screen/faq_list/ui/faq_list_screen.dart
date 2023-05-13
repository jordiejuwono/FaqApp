import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:faq_app/presentation/components/card/faq_item.dart';
import 'package:faq_app/presentation/screen/detail/ui/detail_page.dart';
import 'package:faq_app/presentation/screen/faq_list/provider/faq_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FaqListScreen extends StatefulWidget {
  const FaqListScreen({super.key});

  @override
  State<FaqListScreen> createState() => _FaqListScreenState();
}

class _FaqListScreenState extends State<FaqListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FaqListNotifier>(context, listen: false).fetchFaqList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Consumer<FaqListNotifier>(
          builder: (context, value, child) {
            if (value.faqListState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: value.faqList?.data.length,
                itemBuilder: (context, index) {
                  final currentFaq = value.faqList?.data[index];
                  final dateTime = DateFormat("dd-MM-yyyy")
                      .format(currentFaq?.updatedAt ?? DateTime.now());

                  return FaqItem(
                    currentFaq: currentFaq,
                    dateTime: dateTime,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailPage.routeName,
                        arguments: currentFaq?.id,
                      ).then((result) {
                        if (result == true) {
                          value.fetchFaqList();
                        }
                      });
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
