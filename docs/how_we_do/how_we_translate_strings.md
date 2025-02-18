# 🌐 How We Translate Strings

## 📖 Overview
We use Flutter's built-in internationalization system with ARB (Application Resource Bundle) files. Our app currently supports English (en) and Dutch (nl) languages.

## 📁 File Structure
- `lib/core/strings/intl_en.arb` - English translations
- `lib/core/strings/intl_nl.arb` - Dutch translations

## 🔄 Translation Process

1. ➕ **Adding New Strings**
   - Always add strings to both language files simultaneously
   - Start with English (`intl_en.arb`) as the source of truth
   - Then add the Dutch translation (`intl_nl.arb`)
   - Keep the same key order in both files for easier maintenance

2. 🔑 **String Keys**
   - Use camelCase for key names
   - Make keys descriptive of their content
   - Example: `welcomeMessage` instead of `message1`

3. 📝 **String Values**
   - Keep translations natural to each language
   - Don't do literal translations
   - Consider cultural context

4. 🔄 **Placeholders**
   - Use {variableName} for dynamic content
   - Example: `"welcomeUser": "👋 Welcome, {username}!"`

5. 💻 **Usage in Code**
   - Access translations through `gStrings`
   - Example: `gStrings.welcomeUser`

## 📋 Examples

```json
// English (intl_en.arb)
{
  "welcomeUser": "👋 Welcome, {username}!",
  "itemCreated": "Item created",
  "itemUpdated": "Item updated",
  "itemDeleted": "Item deleted",
  "status": {
    "active": "Active",
    "inactive": "Inactive",
    "pending": "Pending"
  }
}

// Dutch (intl_nl.arb)
{
  "welcomeUser": "👋 Welkom, {username}!",
  "itemCreated": "Item aangemaakt",
  "itemUpdated": "Item bijgewerkt",
  "itemDeleted": "Item verwijderd",
  "status": {
    "active": "Actief",
    "inactive": "Inactief",
    "pending": "In afwachting"
  }
}
```