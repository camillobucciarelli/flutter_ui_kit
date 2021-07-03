import 'package:reactive_forms/reactive_forms.dart';

class DmyDateValidator extends Validator {
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    try {
      DateTime.parse(control.value!);
      return null;
    } catch (e) {
      return {ValidationMessage.mustMatch: ''};
    }
  }
}
