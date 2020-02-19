# String Localization

This folder is dedicated to maintaining string localization for the project.

## Tables

Files with the ‘.strings’ extension represent the tables which hold localized string references. The syntax for these files are. “<key> = <value>”;

## Table Enums

Files with the ‘.swift’ extension and ‘Tables’ suffix hold the enumerations that return a String raw value. These files are used for dynamic localized string lookup.

## Localizable

Localizable.swift holds the Localizable protocol and extension that allows the developer to write swifty code for string localization in reference to table names and key/value pairs.

### Programmatic Usage

### Creating the tables and reference

1) To create a new .strings file, create a new file in Xcode and select 'Strings File' from the available templates. Name the file relative to the component in which you will use the localized strings.

2) To create a new table, create a new .swift using the following naming convention:
	a) .strings file name without it's extension
	b) append literal: "Strings" as the suffix of the file name

3) Declare a new enum extending String object and implementing the Localizable protocol.

4) Declare new case values that resemble the keys in the table that this enum will reference.

5) Ensure that you conform to the Localizable protocol by declaring 

```swift 
var tableName
```

6) Ensure that the tableName var returns your .strings file name as a string literal

#### Calling localized strings

Call the enum's case's localized value. This should return your localized string literal value found in the .strings file you created above.

```swift
let string = Strings.localizedString.localized // Localized String
```

## UIKit Components

The folder ‘Localized String Components’ contains IBDesignable UI classes that allow the developer to reference ‘tableNames’ and table ‘keys’ inside the attributes inspector pain when creating and designing in storyboard.

### Storyboard Usage

First, when creating Buttons, Labels, and TextFields, reference the correct ‘UILocalized’ class in the Identity Inspector pane in the ‘Custom Class’ section.

Next, be sure to reference the correct table name in the ‘Localized Label’ section of the attributes inspector pane.

Finally, reference the correct ‘key’ for localized string in the ‘text’ field of the attributes inspector pane

## Reference

[App Localization Tips with Swift](https://medium.com/@marcosantadev/app-localization-tips-with-swift-4e9b2d9672c9)
