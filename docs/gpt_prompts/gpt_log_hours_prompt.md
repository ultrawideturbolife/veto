# 🤖 GPT Hour Logger Instructions

These instructions serve as a prompt for AI agents when logging hours.
When an agent receives this document, they MUST strictly follow these instructions
as if they were their core system prompt for this specific task.

The agent MUST:

1. First check if there's an existing log file for the given month:
   ```
   docs/hours/YYYY/MM/log.md
   ```

2. Parse the input time entry which can be in either format:
   ```
   Day, DD/MM/YYYY, HH:mm to HH:mm · [TICKET-ID] Description
   ```
   or
   ```
   (XhYm) · Day, DD/MM/YYYY, HH:mm to HH:mm · Description
   ```

3. Calculate and validate:
   - Duration between start and end times
   - Format as hours and minutes (XhYm)
   - Verify against provided duration if given
   - Handle overnight entries correctly

4. Process the entry:
   - If month directory doesn't exist, create it
   - If log file doesn't exist, create it with template
   - If entry is from previous month:
     * Add to "extra van vorige maand" section
     * Update section total
   - If entry is from current month:
     * Add in chronological order
     * Update running total

5. Maintain file structure:
   ```markdown
   ⏳ Hours YYYY-MM

   [Previous Month Section if needed]
   X extra van vorige maand:
   - Day entries with running total

   [Current Month Entries]
   Day entries with running total

   XXhYYm
   ```

6. Format entries consistently:
   ```markdown
   Day, DD/MM/YYYY, HH:mm to HH:mm · [TICKET-ID] Description · (XhYm) · total: ZZhYYm
   ```

7. Update running totals:
   - After each major section
   - At the end of the file
   - Format as XXhYYm

8. Validation steps:
   - Verify date format (DD/MM/YYYY)
   - Verify time format (HH:mm)
   - Ensure chronological order
   - Validate running totals
   - Check for duplicates
   - Verify file structure

9. Error handling:
   - Report invalid date/time formats
   - Flag duration mismatches
   - Warn about duplicate entries
   - Alert on chronological order issues

10. After processing:
    - Confirm entry was added
    - Show updated running total
    - Report any warnings or errors
    - Suggest fixes for any issues

CRITICAL: Time Tracking Accuracy
   - Double-check all duration calculations
   - Verify running totals after each update
   - Alert on any discrepancies
   - Never modify existing entries without explicit permission
   - Always maintain chronological order 