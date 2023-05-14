import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/presentation/components/card/faq_item.dart';
import 'package:faq_app/presentation/screen/add_faq/ui/add_faq_page.dart';
import 'package:faq_app/presentation/screen/detail/ui/detail_page.dart';
import 'package:faq_app/presentation/screen/faq_list/provider/faq_list_notifier.dart';
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
    super.initState();
    Future.microtask(() {
      Provider.of<FaqListNotifier>(context, listen: false).fetchFaqList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade200,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddFaqPage.routeName).then((result) {
              if (result == true) {
                Provider.of<FaqListNotifier>(context, listen: false)
                    .fetchFaqList();
              }
            });
          },
          child: const Icon(
            Icons.add,
            size: 26.0,
          ),
        ),
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Row(
            children: [
              const Icon(
                Icons.question_answer,
                size: 26.0,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                "FAQ List",
                style: kHeading6.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Consumer<FaqListNotifier>(
          builder: (context, value, child) {
            if (value.faqListState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () {
                return value.fetchFaqList();
              },
              child: ListView.builder(
                  itemCount: value.faqList?.data.length,
                  itemBuilder: (context, index) {
                    final currentFaq = value.faqList?.data[index];
                    final updatedAt = currentFaq?.updatedAt.toString() ?? "";

                    return FaqItem(
                      currentFaq: currentFaq,
                      dateTime: updatedAt.substring(0, updatedAt.indexOf(".")),
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
                  }),
            );
          },
        ),
      ),
    );
  }
}
