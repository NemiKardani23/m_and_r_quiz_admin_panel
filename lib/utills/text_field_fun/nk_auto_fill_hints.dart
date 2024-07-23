import 'package:flutter/services.dart';

class NKAutoFillHints {
  static const Iterable<String> generalHints = <String>[
    AutofillHints.name,
    AutofillHints.email,
    AutofillHints.password,
    AutofillHints.newPassword,
  ];

  static const Iterable<String> phoneNumberHints = <String>[
    AutofillHints.telephoneNumber,
    AutofillHints.telephoneNumberDevice,
    AutofillHints.telephoneNumberLocal,
    AutofillHints.telephoneNumberNational
  ];

  static const Iterable<String> emailAddressHints = <String>[
    AutofillHints.email,
  ];

  static const Iterable<String> nameHints = <String>[
    AutofillHints.name,
    AutofillHints.namePrefix,
    AutofillHints.nameSuffix,
    AutofillHints.givenName,
    AutofillHints.familyName,
    AutofillHints.nickname,
    AutofillHints.newUsername,
  ];

  static const Iterable<String> dateOfBirthHints = <String>[
    AutofillHints.birthday,
    AutofillHints.birthdayDay,
    AutofillHints.birthdayMonth,
    AutofillHints.birthdayYear
  ];

  static const Iterable<String> addressHints = <String>[
    AutofillHints.streetAddressLevel1,
    AutofillHints.streetAddressLevel2,
    AutofillHints.streetAddressLevel3,
    AutofillHints.streetAddressLevel4,
    AutofillHints.postalCode,
    AutofillHints.addressCityAndState
  ];

  static const passwordHints = <String>[
    AutofillHints.password,
    AutofillHints.newPassword,
  ];
}
