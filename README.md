# FlutterCrew Code Reglament

## Everything is a widget
In every flutter app we use widgets. Everything in the app is made from widgets.

To create a widget we should use following recommendations:

### Widget...
* should be placed in the `/widgets` folder.
* should be named accordingly to its content.
* should be easialy exported.
* should only export itself.

---
## File Structure
There are two simple rules to file structure. 
1. All content should be exported in one file.
2. All content should be containted inside `src` folder.

The root folder is named after the widget and contains only the exporting file and `src` folder. 

Inside `src` folder there can be such folders:

| Folder    | Filename                   | Description
| --------- | ----------- |--------------------------- | ------------------
| constants | `widget_name`_const.dart   | widget settings
| styles    | `widget_name`_style.dart   | widget ui settings and functions
| models    | `model_name`_model.dart    | models that this widget or its children will need
| utils     | `util_name`.dart           | logic functions for the desired widget to work
| widgets   | `widget_name`.dart         | other widgets that will this widget use
| sources   | `source_name`_source.dart  | possibility to import files from other libraries and change something if needed
| `other`   | `widget_name`_`other`.dart | Bloc, cubit, singletons, services and other logic

---
### Tips
#### 1. Single File
Though it is recommended to split your widget into folders, but as long as your widget is really small, you can have it all in one file. This is also usable with other folders. For example if you want to split your widget, but do not want to split it's style, you may leave it as is (but you still need to create a folder for that style).

+ Even if `models` / `utils` / `widgets` folder has one file, it still should be named plural.
+ But `other` folder should be named in respect to its plurality.

---
## Splitting Files 
If your file is too big and you want to effectively split it you should use part / part of expressions. In your style folder create all the folders where you want to have your file splitted and name them accordingly to their content. You can also leave some content in main file if you want to.

When splitting using part, set the `library` following style `project_name`.`widget_name`.`type`
- For example you can use `text` folder in style to define text styles for your widget with `library app.widget.style`

---
### Style Splitting
| Folder  | File               | Description
| ------- | ------------------ | ------------------
| text    | `widget_name`.dart | text styles
| theme   | `theme_name`.dart  | ui settings
| utils   | `util_name`.dart   | ui functions
| `other` | `other_name`.dart  | custom ui

---
### Const Splitting
| Folder   | File                | Description
| -------- | ------------------- | ------------------
| settings | `setting_name`.dart | constant settings
| `other`  | `other_name`.dart   | custom constants

---
## Classification
In purposes of clean code and easy import we set 2 requirements:

1. Widget class name should be identical to it's filename. For example, class named `HomeScreen` should be placed in a file `home_screen.dart`.
2. Folder name should be identical to file in it's root. For example, file named `home_screen.dart` should be placed in a folder `home_screen`.

---
### Import
For means of easy code and avoiding overcomplicating imports, we should import only the main folder file in the file type folders. 

---
### Export
By default widget should export everything that can be needed when importing it. That means styles, constants, models, other widgets, logic, etc. For example if widget has custom models and/or utils, that can be used for creating that widget, or managing it's content from outside, they should be exported.

If you want to have more than one widget in the widget root and your widgets share the same suffix, you should create a folder named with this suffix and place your widgets there. For example, for files `home_screen.dart` and `home2_screen.dart` you should create a folder named `screens` and put files `home.dart` and `home2.dart` there. This also requires renaming widget folder name from `home_screen` to `home` and exporting widget content including all widgets in the file `home.dart`. This concept can also be used with group of widgets in the `widgets` folder.

---
#### Quick Note on Export
If you have the same type of files from outside the current widget, that will this widget use, you should put them in this widget type file. For example, if you have main style file in the root of the app that you want to use in current widget, you should export it from the current widget's local style file and not import it in the widgets underneath this widget. 

---
### Project Structure
0. File Structure
1. Flutter Bloc (Cubit)
2. MWWM
3. Flutter Modular

---
### Analisys Options
- It is a good idea to have your code sorted and unified. You can use our predefined analysis options just for that.

---
### Bad Practicies
- You should not export other libraries from your own.
---
