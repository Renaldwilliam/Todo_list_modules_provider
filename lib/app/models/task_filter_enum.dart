enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return "DE HOJE";
      case TaskFilterEnum.tomorrow:
        return "DE AMANHA";
      case TaskFilterEnum.week:
        return "DA SEMANA";
      default:
      return "";
    }
  }
}
