# Lightweight-Xcode-Templates
Repository contains some simple templates for creating projects and modules

---

### How to install template:
    swift install.swift
*The second option os to place one of .xctemplate folders into directory ~/Library/Developer/Xcode/Templates/ (it's ok to create manually this folder if it didn't exist)*

---

### How to use template:
* (Project) Simply open project creation window in Xcode (cmd+shift+n) and choose suitable template in Templates folder below
* (Module/File) Simply open file creation window in Xcode (cmd+n) and choose suitable template in Templates folder below

---

### How to run project templates with pods quickly:
1) Create project from the template (default pods will be already at fitting workspace in generated Podfile)
2) Run 'pod install' in project root directory
3) Close project and open automatically created workspace with the same name
