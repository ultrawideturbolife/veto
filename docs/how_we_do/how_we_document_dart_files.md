# 📝 How We Document Dart Files

# 📝 Table of Contents

- [Introduction](#introduction)
- [GPT Agent Instructions](#gpt-agent-instructions)
- [Suggested Approach](#suggested-approach)
- [Tutorial](#tutorial)
- [Checklist](#checklist)

# 📝 Introduction

This guide explains how to document Dart files following the official Dart documentation guidelines. It ensures consistency, clarity, and completeness in our documentation.

## 🤖 GPT Agent Instructions

These instructions serve as a prompt for AI agents when documenting Dart files.
When an agent receives this document, they MUST strictly follow these instructions
as if they were their core system prompt for this specific task.

The agent MUST:

1. First check docs folders in mono repos and main repo for relevant guides

2. Gather all necessary information by:
   - Reading the Dart file to be documented
   - Understanding the purpose and functionality
   - Identifying all public APIs
   - Noting any special patterns or features

3. Create and present a documentation plan that includes:
   - Library-level documentation (if applicable)
   - Public API documentation
   - Member documentation
   - Examples and cross-references

# 🎯 Suggested Approach

- [ ] Review the Dart file to understand its purpose
- [ ] Add library-level documentation if it's a library file
- [ ] Document each public API
- [ ] Document all public members
- [ ] Add practical examples
- [ ] Cross-reference related functionality
- [ ] Review against Dart guidelines
- [ ] Document each class and method one by one, don't do too much at once

# 👨‍🏫 Tutorial

Every documentation block follows this exact structure:

1. First line: Summary (noun phrase for types/properties, verb for methods)
2. Detailed explanation
3. Parameters (if applicable)
4. Returns (if applicable)
5. Features
6. Example
7. See also

## 1. 📚 Library Documentation

```dart
/// A brief, single-sentence summary of the library's purpose.
///
/// Detailed explanation of what this library provides and how it works.
/// Include any important concepts or terminology.
///
/// Features:
/// - Major feature or concept 1
/// - Major feature or concept 2
/// - Major feature or concept 3
///
/// Example:
/// ```dart
/// // Simple example showing basic usage
/// ```
///
/// See also:
/// - [RelatedClass] specific functionality
/// - [AnotherLibrary] complementary features
library;
```

## 2. 📝 Public API Documentation

```dart
/// A {thing} that {does something}.
///
/// Detailed explanation of what this API provides and how it works.
/// Include any important concepts or terminology.
///
/// Parameters (if applicable for generic type):
/// Use [T] to specify the document type
/// Use [K] to specify the key type
///
/// Features:
/// - Key capability 1
/// - Key capability 2
/// - Key capability 3
///
/// Example:
/// ```dart
/// // Simple example showing basic usage
/// ```
///
/// See also:
/// - [RelatedType] additional functionality
/// - [AnotherType] alternative approach
class/extension/mixin Name {
```

## 3. 📝 Method Documentation

```dart
/// {Verb}s {what} {context}.
///
/// Detailed explanation of what this method does and how it works.
/// Include any important concepts or terminology.
///
/// Parameters:
/// Use [param1] to specify the main input
/// Use [param2] to control the behavior
///
/// Returns {what} containing:
/// - Success case with {description}
/// - Failure case with {description}
///
/// Features:
/// - Key capability 1
/// - Key capability 2
/// - Key capability 3
///
/// Example:
/// ```dart
/// // Example showing typical usage
/// ```
///
/// See also:
/// - [RelatedMethod] alternative approach
/// - [AnotherMethod] different use case
returnType methodName({
  required Type param1,
  Type? param2,
}) {
```

## 4. 🎯 Property Documentation

For non-boolean properties:
```dart
/// The {description} of this {class}.
///
/// Detailed explanation of what this property represents
/// and how it's used.
///
/// Features:
/// - Key aspect 1
/// - Key aspect 2
/// - Key aspect 3
///
/// Example:
/// ```dart
/// final thing = instance.propertyName;
/// print(thing.someValue);
/// ```
///
/// See also:
/// [RelatedProperty] related data
/// [AnotherProperty] alternative
Type propertyName;
```

For boolean properties:
```dart
/// Whether this {class} {does something}.
///
/// Detailed explanation of what this flag controls
/// and its implications.
///
/// Features:
/// - When true with {behavior}
/// - When false with {behavior}
/// - Default value is {value}
///
/// Example:
/// ```dart
/// if (instance.isEnabled) {
///   // Handle enabled state
/// }
/// ```
///
/// See also:
/// - [RelatedProperty] related state
/// - [AnotherProperty] dependent behavior
bool isEnabled;
```

# ✅ Checklist

For EVERY documentation block:

- [ ] First line:
  - [ ] Starts with noun phrase (types/properties)
  - [ ] Starts with verb (methods)
  - [ ] Clear and concise
  - [ ] Complete sentence

- [ ] Detailed explanation:
  - [ ] Explains purpose and behavior
  - [ ] Includes important concepts
  - [ ] One sentence per line

- [ ] Parameters (if applicable):
  - [ ] All parameters documented
  - [ ] Purpose clearly explained
  - [ ] Constraints mentioned
  - [ ] Default values noted

- [ ] Returns (if applicable):
  - [ ] Return type explained
  - [ ] Success cases documented
  - [ ] Failure cases documented
  - [ ] Side effects noted

- [ ] Features:
  - [ ] Key capabilities listed
  - [ ] Behaviors explained
  - [ ] Limitations noted
  - [ ] Special cases mentioned

- [ ] Example:
  - [ ] Shows typical usage
  - [ ] Complete and practical
  - [ ] Properly formatted
  - [ ] Includes results/handling

- [ ] See also:
  - [ ] Related members linked
  - [ ] Purpose of links explained
  - [ ] Relevant connections

- [ ] Formatting:
  - [ ] No HTML used
  - [ ] Square brackets for identifiers
  - [ ] Backticks for code
  - [ ] Proper line breaks
  - [ ] NEVER add a colon after [bracketed] references (breaks Dart's documentation formatting)
  - [ ] Write "[reference] x" instead of "[reference]: x" 