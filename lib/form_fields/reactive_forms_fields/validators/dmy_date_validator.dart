import 'package:reactive_forms/reactive_forms.dart';

class DmyDateValidator extends Validator {
  final String separator;

  DmyDateValidator(this.separator);

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    try {
      final dateParts = control.value!.split(separator);
      DateTime(dateParts[2], dateParts[1], dateParts[0]);
      return null;
    } catch (e) {
      return {ValidationMessage.mustMatch: ''};
    }
  }
}
