import 'package:faq_app/common/constants.dart';
import 'package:faq_app/common/state_enum.dart';
import 'package:faq_app/data/model/request/post_faq_request.dart';
import 'package:faq_app/domain/usecase/update_faq_detail_use_case.dart';
import 'package:faq_app/presentation/components/button/red_background_button.dart';
import 'package:faq_app/presentation/screen/detail/provider/detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail";
  final int faqId;
  const DetailPage({
    super.key,
    required this.faqId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _pertanyaanController = TextEditingController();
  final TextEditingController _jawabanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailNotifier>(context, listen: false)
          .fetchFaqDetail(widget.faqId);
    });
  }

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
        appBar: AppBar(
          title: Text(
            "FAQ Detail",
            style: kHeading6,
          ),
          actions: [_detailAppBar()],
        ),
        body: _detailContent(),
      ),
    );
  }

  Consumer<DetailNotifier> _detailContent() {
    return Consumer<DetailNotifier>(
      builder: (context, value, child) {
        if (value.faqDetailState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pertanyaan:",
                style: kHeading6,
              ),
              value.isEditMode == true
                  ? TextField(
                      controller: _pertanyaanController,
                    )
                  : Text(
                      value.faqDetail?.data.pertanyaan ?? "",
                      style: kTextMediumBold,
                    ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                "Jawaban:",
                style: kHeading6,
              ),
              value.isEditMode == true
                  ? TextField(
                      controller: _jawabanController,
                    )
                  : Text(
                      value.faqDetail?.data.jawaban ?? "",
                      style: kTextSmallNormal.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
              const SizedBox(
                height: 40.0,
              ),
              value.isEditMode == true
                  ? const SizedBox.shrink()
                  : RedBackgroundButton(
                      label: "Delete",
                      onPressed: () {
                        value.deleteFaq(widget.faqId);
                      })
            ],
          ),
        );
      },
    );
  }

  Consumer<DetailNotifier> _detailAppBar() {
    return Consumer<DetailNotifier>(
      builder: (context, value, child) {
        if (value.deleteFaqState == RequestState.loaded) {
          Future.microtask(() {
            Navigator.pop(context, true);
          });
        }
        if (value.editFaqState == RequestState.loaded) {
          Future.microtask(() {
            Navigator.pop(context, true);
          });
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade300)),
              onPressed: () {
                value.changeEditMode(!(value.isEditMode));
                if (value.isEditMode == true) {
                  _pertanyaanController.text =
                      value.faqDetail?.data.pertanyaan ?? "";
                  _jawabanController.text = value.faqDetail?.data.jawaban ?? "";
                } else {
                  value
                      .editFaqDetail(UpdateFaqParams(
                          faqId: widget.faqId,
                          request: PostFaqRequest(
                              pertanyaan: _pertanyaanController.text,
                              jawaban: _jawabanController.text,
                              statusPublish: true)))
                      .then((_) {
                    value.fetchFaqDetail(widget.faqId);
                  });
                }
              },
              child: Row(
                children: [
                  Icon(
                    value.isEditMode == true ? Icons.save : Icons.edit,
                    size: 14.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(value.isEditMode == true ? "Save" : "Edit"),
                ],
              )),
        );
      },
    );
  }
}
