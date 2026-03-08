class BadgeDef {
  final String id;
  final String name;
  final String description;
  final String icon; // emoji
  const BadgeDef({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

class AchievementDefinitions {
  static const all = [
    BadgeDef(
      id: 'first_expense',
      name: 'First Step',
      description: 'Tracked your very first expense',
      icon: '🚀',
    ),
    BadgeDef(
      id: 'three_day_streak',
      name: 'Habit Forming',
      description: 'Tracked expenses 3 days in a row',
      icon: '🔥',
    ),
    BadgeDef(
      id: 'seven_day_streak',
      name: 'Week Warrior',
      description: 'Tracked expenses 7 days in a row',
      icon: '⚡',
    ),
    BadgeDef(
      id: 'thirty_day_streak',
      name: 'Iron Discipline',
      description: '30-day tracking streak',
      icon: '💎',
    ),
    BadgeDef(
      id: 'budget_master',
      name: 'Budget Master',
      description: 'Stayed within all budgets for a full month',
      icon: '🎯',
    ),
    BadgeDef(
      id: 'saver',
      name: 'Super Saver',
      description: 'Saved more than 30% of income in a month',
      icon: '💰',
    ),
    BadgeDef(
      id: 'ai_explorer',
      name: 'AI Explorer',
      description: 'Generated your first AI insights report',
      icon: '🤖',
    ),
    BadgeDef(
      id: 'hundred_expenses',
      name: 'Century',
      description: 'Tracked 100 expenses total',
      icon: '💯',
    ),
    BadgeDef(
      id: 'recurring_detective',
      name: 'Pattern Spotter',
      description: 'Had 3 recurring expenses auto-detected',
      icon: '🔍',
    ),
    BadgeDef(
      id: 'zero_overspend',
      name: 'Perfect Month',
      description: 'Zero budget overruns in a month',
      icon: '✨',
    ),
  ];
}
