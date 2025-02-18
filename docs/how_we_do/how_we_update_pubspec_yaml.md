# 📝 How We Update Pubspec Yaml

# 📝 Table of Contents

- [Introduction](#introduction)
- [Suggested Approach](#suggested-approach)
- [Tutorial](#tutorial)
- [Checklist](#checklist)

# 📝 Introduction

This guide explains how we manage dependencies in our `pubspec.yaml` files. We always use the Flutter CLI to add, remove, or update dependencies to ensure proper version resolution and maintain consistency across our projects.

# 🤖 Suggested Approach

- [ ] Navigate to project directory
- [ ] Check current dependencies with `flutter pub outdated`
- [ ] Add dependencies using `flutter pub add package_name`
- [ ] Remove dependencies using `flutter pub remove package_name`
- [ ] Update dependencies using `flutter pub upgrade`
- [ ] Run `flutter pub get` to ensure everything is in sync
- [ ] Test the application
- [ ] Commit changes with clear message

# 👨‍🏫 Tutorial

## 1. 📦 Adding Dependencies

1. Navigate to your project:
   ```bash
   cd your_project_directory
   ```

2. Add a dependency:
   ```bash
   flutter pub add package_name
   ```
   
   Example:
   ```bash
   flutter pub add provider
   ```

## 2. 🗑️ Removing Dependencies

1. Remove a dependency:
   ```bash
   flutter pub remove package_name
   ```
   
   Example:
   ```bash
   flutter pub remove old_package
   ```

## 3. 🔄 Updating Dependencies

1. Check outdated packages:
   ```bash
   flutter pub outdated
   ```

2. Update all dependencies:
   ```bash
   flutter pub upgrade
   ```

3. Update specific package:
   ```bash
   flutter pub upgrade package_name
   ```

## 4. 🔍 Verifying Changes

1. Check pubspec.yaml for changes
2. Run pub get:
   ```bash
   flutter pub get
   ```
3. Run tests:
   ```bash
   flutter test
   ```

# ✅ Checklist

- [ ] Used correct Flutter CLI command for the task
- [ ] No manual version number edits in pubspec.yaml
- [ ] Dependencies are properly added/removed
- [ ] `flutter pub get` ran successfully
- [ ] No version conflicts reported
- [ ] Application builds successfully
- [ ] All tests pass
- [ ] Changes documented in commit message
- [ ] Version constraints are appropriate
- [ ] No unexpected dependency changes

# ⚠️ Important Notes

- Never specify exact versions unless absolutely necessary
- Let Flutter handle version resolution
- Always run tests after updating dependencies
- Document any required version constraints in comments
- NEVER manually edit version numbers in pubspec.yaml
- Let Flutter resolve version conflicts automatically
``` 
