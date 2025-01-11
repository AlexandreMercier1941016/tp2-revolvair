String getFormattedDate(String dateStr) {
    final parsedDate = DateTime.tryParse(dateStr);
    if (parsedDate != null) {
      return "Dernière mesure: ${parsedDate.toLocal()}"; 
    } else {
      return "Date invalide";
    }
  }