// lib/tools.dart
class StringTools {
  //A method to remove a space in a String
  static String removeSpaceAndRemplace(String s){
    return s.replaceAll(" ", "_");
  }
  static String remove_Remplace(String s){
    return s.replaceAll("_", " ");
  }
  //Get firstWords
  static String getFirstWords(String s,int numberOfWords) {
    List<String> words = s.split(' ');
    List<String> first15Words = words.take(numberOfWords).toList();
    String first15WordsString = first15Words.join(' ');
    return first15WordsString;
  }

  // A method to format dates
  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // A method to validate email addresses
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // A method to capitalize the first letter of a string
  static String capitalize(String s) {
    if (s == null || s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

// Add more utility functions as needed
}
