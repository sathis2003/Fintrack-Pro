enum AITask {
  extractExpenseFromText,
  scanReceipt,
  generateMonthlyReport,
  analyzeSpendingPattern,
  suggestCategoryWhileTyping,
  narrateAnomaly,
  weeklyDigestSummary,
  generateDbInsight,
}

enum AIEngine { groq, gemma }

class AIRouter {
  static AIEngine routeForTask(AITask task) {
    switch (task) {
      case AITask.extractExpenseFromText:
      case AITask.scanReceipt:
      case AITask.generateMonthlyReport:
        return AIEngine.groq;
      case AITask.analyzeSpendingPattern:
      case AITask.suggestCategoryWhileTyping:
      case AITask.narrateAnomaly:
      case AITask.weeklyDigestSummary:
      case AITask.generateDbInsight:
        return AIEngine.gemma;
    }
  }
}
