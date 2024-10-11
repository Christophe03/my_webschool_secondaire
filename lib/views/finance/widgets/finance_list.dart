import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_webschool_secondaire/models/echeance_model.dart'; // Make sure this model is appropriate for static data
import 'package:my_webschool_secondaire/utils/string_util.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants_util.dart';
import '../../../widgets/circle_avatar.dart';

class FinanceList extends StatefulWidget {
  final List<EcheanceModel> snapshot;

  const FinanceList({super.key, required this.snapshot});

  @override
  State<FinanceList> createState() => _FinanceListState();
}

class _FinanceListState extends State<FinanceList> {
  getStatusColor(EcheanceModel e) {
    return e.est_solde == 'Y'
        ? Colors.green
        : (calculateDifferenceInDays(e.date! as DateTime) >
                0 // Updated to use a static function
            ? kColorPink
            : kColorDark);
  }

  // Replace Firebase date formatting with a static method (if needed)
  String formatDate(EcheanceModel e) {
    return DateFormat('dd/MM/yyyy').format(e.date! as DateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.snapshot.map((EcheanceModel tab) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(
                color: kColorPrimaryDark,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              leading: CircleAvatarWithText(
                text: tab.ordre.toString(),
                backgroundColor: kColorPrimary,
                textColor: Colors.white,
                radius: 20.0,
              ),
              title: RichText(
                text: TextSpan(
                  text: formatDate(
                      tab), // Updated to use the static date formatting
                  style: TextStyle(
                    fontSize: 13,
                    color: getStatusColor(tab),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'reste.a.payer'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: kColorDark,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: "  ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: formatDoubleWithThousandSeparator(
                              tab.net! - tab.montant_paye!),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const TextSpan(
                          text: " CFA",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: InkWell(
                  onTap: () {
                    showDetails(tab);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'voir.details'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: kColorDark,
                            fontWeight: FontWeight.w500,
                          )))),
            ),
          );
        }).toList()
      ],
    );
  }

  void showDetails(EcheanceModel e) async {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: RichText(
                    text: TextSpan(
              text: 'details'.tr(),
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: kColorDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ))),
            const SizedBox(height: 30),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                  text: "num.echeance".tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kColorDark),
                )),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: e.ordre.toString(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                  text: "date.echeance".tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kColorDark),
                )),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: formatDate(
                          e), // Updated to use the static date formatting
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: e.est_solde == 'Y',
              child: Column(children: [
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "date.reglement".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: e.date_reglement != null
                              ? formatDate(e.date_reglement!
                                  as EcheanceModel) // Use static formatting here too
                              : "",
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "nrecu".tr(),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kColorDark),
                    )),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: e.recu != null ? e.recu! : '',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: kColorPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ]),
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                  text: "montant.a.payer".tr(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kColorDark),
                )),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: formatDoubleWithThousandSeparator(e.net!),
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: kColorPrimary),
                      children: const <TextSpan>[
                        TextSpan(
                          text: " CFA",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: kColorPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Add any additional fields you need here
          ],
        ),
      ),
    );
  }

  int calculateDifferenceInDays(DateTime date) {
    // Replace with your static logic for calculating the difference in days
    return DateTime.now().difference(date).inDays;
  }
}
