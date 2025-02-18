# 📝 How We Log Hours

## 📁 Structure

Hours are logged in the following directory structure:
```
/Users/codaveto/Documents/ultrawideturbodev/hours/
└── <repository_name>/ # Repository folder (e.g., ultrawideturbodev, flutter_packages_mono, turbo_template, turbo_response)
    └── YYYY/          # Year folder
         └── MM.md # Monthly log file
```

## 📊 Log Format

Each monthly log file follows this format:

```markdown
⏳ Hours YYYY-MM

[Previous Month Extra Hours Section - Optional]
X extra van vorige maand:
- Day entries with running total

[Current Month Entries]
Day entries with running total

[Running Total Sections]
Running total after each major section
```

### 📅 Day Entry Format
```markdown
Day, DD/MM/YYYY, HH:mm to HH:mm · [TICKET-ID] Description · (XhYm) · total: ZZhYYm
```

Example:
```markdown
Mon, 02/12/2024, 14:00 to 15:00 · [RMY-#6] Fix settings view · (1h) · total: 14h45m
```

### 🔢 Running Total Format
At the end of each major section:
```markdown
XXhYYm

```

## 🤖 GPT Agent Instructions

These instructions serve as a prompt for AI agents when logging hours.

The agent MUST:

1. Parse Input Format
   - Accept time entries in the format: `Day, DD/MM/YYYY, HH:mm to HH:mm · [TICKET-ID] Description`
   - Or simplified format: `(XhYm) · Day, DD/MM/YYYY, HH:mm to HH:mm · Description`

2. Calculate Duration
   - Calculate time difference between start and end times
   - Format duration as hours and minutes (XhYm)
   - Handle overnight entries correctly

3. Maintain Running Total
   - Keep track of running total for the month
   - Add new entry duration to previous total
   - Format total as hours and minutes

4. Update Log File
   - Create year/month directories if needed
   - Create or update monthly log file
   - Add new entries in chronological order
   - Update running totals after each section
   - Preserve existing content and formatting

5. Handle Previous Month Hours
   - If entry is from previous month, add to "extra van vorige maand" section
   - Update running total accordingly

6. Validation
   - Verify date and time formats
   - Ensure chronological order
   - Validate running totals
   - Check for duplicate entries

## 🎯 Example Usage

Input:
```
(1h) · Mon, 02/12/2024, 14:00 to 15:00 · Refine ticket
```

Agent will:
1. Parse the entry
2. Calculate duration (1h)
3. Find or create 2024/12/log.md
4. Add entry in chronological order
5. Update running total
6. Format output according to template

## ✅ Validation Checklist

- [ ] Date format is correct (DD/MM/YYYY)
- [ ] Time format is correct (HH:mm)
- [ ] Duration calculation matches time difference
- [ ] Running total is accurate
- [ ] Entry is in chronological order
- [ ] File structure is maintained
- [ ] Previous month entries are handled correctly 
