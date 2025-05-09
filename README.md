```markdown
# 🚀 Smart Lib Form Elements
**Pre-built form widgets that you can literally copy-paste into your Flutter project.**

---

## 💡 Why This Exists
Tired of writing 100 lines of code for a single form field?  
**Problem solved.**  
This library contains battle-tested widgets for:
- CheckBox ✅
- Calendar 📅
- Photo Upload 📸
- Radio Buttons 🔘
- Text Inputs 📝
- ...and more

**No need to reinvent the wheel.** Just import and use.

---

## 🧩 Widgets You Can Use TODAY

### 1. CheckBox Widget
```dart
FormElementCheckBox(
  title: "I agree to terms",
  onChanged: (value) => print("Checked: $value"),
  errorText: "You must agree to continue",
)
```  

### 2. Calendar Picker
```dart
FormElementCalendar(
  labelText: "Select birthdate",
  onDateSelected: (date) => print("Date picked: $date"),
  errorText: "Date is required",
)
```  

### 3. Photo Upload
```dart
FormElementPhoto(
  onImageSelected: (file) => print("Image selected: $file"),
  errorText: "Photo upload required",
)
```  

### 4. Radio Group
```dart
FormElementRadio(
  options: [
    FormElement(data: "male", title: "Male"),
    FormElement(data: "female", title: "Female")
  ],
  onDataSelected: (value) => print("Selected: $value"),
)
```  

### 5. Validated Text Input
```dart
SmartFormText(
  labelText: "Email",
  validator: (value) {
    return value.contains("@") ? null : "Invalid email";
  },
)
```  

---

## 🛠️ Installation
```yaml
dependencies:
  smart_lib_form_elements: ^1.0.0
```

---

## 🛡️ Built-in Validation
All widgets have validation logic:
```dart
// Phone number validation
FormElementPhone(
  errorText: "Invalid number format",
  validator: (value) {
    return RegExp(r'^\+[0-9]{9,19}$').hasMatch(value) 
      ? null 
      : "Must include country code";
  },
)
```  

---

## 🚦 How To Use In 2 Minutes
1. **Add dependency** to `pubspec.yaml`
2. **Import** the library:
```dart
import 'package:smart_lib_form_elements/smart_lib_form_elements.dart';
```  
3. **Use widgets** in your form:
```dart
Column(
  children: [
    FormElementCheckBox(...),
    FormElementCalendar(...),
    // Add more widgets here
  ],
)
```

## 🙋 Need Help?
**Vanik Dallakyan**  
[GitHub](https://github.com/Vanik98) | [LinkedIn](https://www.linkedin.com/in/vanik-dallakyan-756b4a1a2/)

---

**Make form development fun again.**  
**Install now and join the community!** 🚀
```