import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get custom_MMMM => DateFormat('MMMM').format(this.toLocal());
  String get custom_MMM => DateFormat('MMM').format(this.toLocal());
  String get custom_MMMM_yy => DateFormat('MMMM yy').format(this.toLocal());
  String get custom_hh_mm_a => DateFormat('hh:mm a').format(this.toLocal());
  String get custom_hh_mm => DateFormat('hh:mm ss').format(this.toLocal());

  String get custom_d_MMM_EEE =>
      DateFormat('d MMM : EEE').format(this.toLocal());
  String get custom_MM_DD_yyyy =>
      DateFormat('MMM d yyyy hh:mm a').format(this.toLocal());
  String get custom_d_MMM => DateFormat('d MMM').format(this.toLocal());
  String get customConvertToDateTimeDateString =>
      DateFormat('dd-MMM-yy').format(this.toLocal());
}
