/// A generic class representing an option or item in a form element.
/// This class is used to associate data with a human-readable title, making it suitable for dropdowns, radio buttons, and other selection-based widgets.
class FormElement<T> {
  /// The underlying data associated with the form element. This can be of any type (e.g., String, int, custom objects).
  final T data;

  /// The human-readable title displayed to the user for this form element.
  final String title;

  /// Creates a new instance of `FormElement` with the provided data and title.
  const FormElement({required this.data, required this.title});
}