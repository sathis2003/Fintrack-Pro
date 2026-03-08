enum ExpenseCategory {
  food,
  transport,
  shopping,
  bills,
  health,
  entertainment,
  education,
  investment,
  other,
}

extension ExpenseCategoryX on ExpenseCategory {
  String get label => switch (this) {
        ExpenseCategory.food => 'Food',
        ExpenseCategory.transport => 'Transport',
        ExpenseCategory.shopping => 'Shopping',
        ExpenseCategory.bills => 'Bills',
        ExpenseCategory.health => 'Health',
        ExpenseCategory.entertainment => 'Entertainment',
        ExpenseCategory.education => 'Education',
        ExpenseCategory.investment => 'Investment',
        ExpenseCategory.other => 'Other',
      };

  static ExpenseCategory fromString(String s) =>
      ExpenseCategory.values.firstWhere(
        (e) =>
            e.name.toLowerCase() == s.toLowerCase() ||
            e.label.toLowerCase() == s.toLowerCase(),
        orElse: () => ExpenseCategory.other,
      );
}

class AppCategories {
  static const List<String> list = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Health',
    'Entertainment',
    'Education',
    'Investment',
    'Other',
  ];
}
