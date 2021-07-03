import 'package:reactive_forms/reactive_forms.dart';

class DmyDateValidator extends Validator {
  final String separator;

  DmyDateValidator(this.separator);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    try {
      final List<int> dateParts = control.value!.split(separator).map(int.parse).toList();
      DateTime(dateParts[2], dateParts[1], dateParts[0]);
      return null;
    } catch (e) {
      return {ValidationMessage.mustMatch: ''};
    }
  }
}
