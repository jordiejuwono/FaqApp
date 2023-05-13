import 'package:faq_app/common/constants.dart';
import 'package:faq_app/data/model/response/faq_list_response.dart';
import 'package:flutter/material.dart';

class FaqItem extends StatelessWidget {
  const FaqItem({
    super.key,
    required this.currentFaq,
    required this.dateTime,
    required this.onTap,
  });

  final DataFaq? currentFaq;
  final String dateTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
                    currentFaq?.pertanyaan ?? "",
                    style: kTextMediumBold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      currentFaq?.jawaban ?? "",
                      style: kTextSmallNormal.copyWith(
                          color: Colors.grey.shade600),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      dateTime,
                      style: kTextSmallNormal.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
