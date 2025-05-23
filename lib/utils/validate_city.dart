String? validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a city name';
  }
  if (value.length < 2) {
    return 'City name must be at least 2 characters';
  }
  if (value.length > 50) {
    return 'City name is too long';
  }
  if (!RegExp(r'^[a-zA-Z\s\-]+$').hasMatch(value)) {
    return 'Please enter a valid city name';
  }
  return null;
}
