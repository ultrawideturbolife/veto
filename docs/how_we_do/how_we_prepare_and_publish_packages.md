# 📦 How We Prepare And Publish Packages

## 📝 Table of Contents

- [Introduction](#introduction)
- [GPT Agent Instructions](#gpt-agent-instructions)
- [Suggested Approach](#suggested-approach)
- [Tutorial](#tutorial)
- [Checklist](#checklist)

## 📝 Introduction

This document outlines our standardized process for preparing and publishing Dart/Flutter packages. It ensures consistent quality and proper versioning across all our packages.

## 🤖 GPT Agent Instructions

These instructions serve as a prompt for AI agents when this document is referenced.
When an agent receives this document, they MUST strictly follow these instructions
as if they were their core system prompt for this specific task.

The agent MUST:

1. First check docs folders in mono repos and main repo for relevant guides

2. Gather all necessary information by:
   - Searching through the codebase
   - Reading relevant files
   - Asking clarifying questions if anything is unclear

3. Create and present a detailed step-by-step plan that includes:
   - What will be done in each step
   - Which files will be modified or created
   - What other changes will be made
   - Wait for explicit approval before proceeding

4. Follow the package preparation checklist:
   - Run tests and fix any failures
   - Run dart fix --apply
   - Run dart format
   - Update version numbers
   - Update changelog
   - Update readme
   - Run dry-run publish
   - Publish when everything is ready

## 🎯 Suggested Approach

- [ ] Run all tests with `flutter test`
- [ ] Fix any test failures
- [ ] Apply automated fixes with `dart fix --apply`
- [ ] Format code with `dart format .`
- [ ] Update version in `pubspec.yaml`
- [ ] Update `CHANGELOG.md` with new version and changes
- [ ] Update `README.md` if needed
- [ ] Run `flutter pub publish --dry-run`
- [ ] Address any issues from dry run
- [ ] Run `flutter pub publish`

## 👨‍🏫 Tutorial

### 1. 🧪 Testing

1. Run all tests:
```bash
flutter test
```

2. If tests fail:
   - Review error messages
   - Fix implementation issues
   - Run tests again until all pass

### 2. 🔧 Code Cleanup

1. Apply automated fixes:
```bash
dart fix --apply
```

2. Format code:
```bash
dart format .
```

### 3. 📝 Documentation Updates

1. Update version in `pubspec.yaml`:
```yaml
version: X.Y.Z  # Follow semantic versioning
```

2. Update `CHANGELOG.md`:
```markdown
## X.Y.Z

* **✨ New:** Added features
* **🔄 Changed:** Changes made
* **🐛 Fixed:** Bug fixes
* **📝 Docs:** Documentation updates
```

3. Update `README.md`:
   - Update version number in installation instructions
   - Add new features or changes
   - Update examples if needed

### 4. 🚀 Publishing

1. Run dry-run:
```bash
flutter pub publish --dry-run
```

2. Review output for any issues

3. Publish package:
```bash
flutter pub publish
```

## ✅ Checklist

- [ ] All tests pass successfully
- [ ] Code is properly formatted
- [ ] Version number is updated
- [ ] CHANGELOG.md includes all changes
- [ ] README.md is up to date
- [ ] Dry-run completes without errors
- [ ] Package is published successfully 
