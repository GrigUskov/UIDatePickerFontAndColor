# UIDatePickerFontAndColor

Adjust the UIDatePicker component font and text color application wide with one line of code.

Using method swizzling we add a fucntionality to UIDatePickerContentView (not public class used by Apple to display Date Picker content).

## Usage

1) Add UIDatePickerFontAndColor.h and UIDatePickerFontAndColor.m files tou your project.
2) #import "UIDatePickerFontAndColor.h" 
3) call [UIDatePickerFontAndColor setFont:VALUE textColor:VALUE] somewhere, for instance in UIApplicaiotn.application:didFinishLaunchingWithOptions:

## Result

All the date pickers in your project will user the new folor and/or font.

