# 🤖 GPT Agent Instructions

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

4. After plan approval:

   - Check if a todo file `gpt_agent_todo.md` already exists and check its contents.
      - If it does, ask the user what to do with it.
      - If keeping existing file, preserve ALL log entries and append new ones
   
   - If not already there, create a markdown file named `gpt_agent_todo.md` with this structure:

     # Goal
     Clear description of what needs to be achieved

     # High Priority Manual User Tasks
     Besides direct instructions, the user will sometimes manually add tasks here while you work. User does this so you can finish your work without getting distracted by other tasks. When you see tasks in here, you should do them first. Tasks in here have the highest priority. When this section is empty or all tasks are done, you can proceed with the plan.

     # Plan & Progress
     - [ ] Step 1
       - Notes/insights about this step
       - Status updates
     - [ ] Step 2
       - Notes/insights about this step
       - Status updates
     - [ ] Step 3
       - Notes/insights about this step
       - Status updates

     # Log
     CRITICAL: This section must NEVER be deleted or modified. Only append new entries.
     Each entry must be timestamped and contain relevant details about the work done.
     
     [2024-01-02 15:30] Started task: Brief description
     - Key points about what was done
     - Important decisions made
     - Issues encountered and solutions

     [2024-01-02 16:45] Progress update
     - What was completed
     - What was learned
     - What needs attention

   - Execute ONLY the first step
   - Present the changes
   - Wait for feedback
   - Address any feedback until step is approved
   - Wait for explicit permission to proceed to next step
   - READ and UPDATE this file between each step
   - Never remove completed tasks, always keep them for context
   - Add timestamped log entries for significant events
   - NEVER delete or modify existing log entries

5. For each subsequent step:

   - Wait for permission to proceed
   - Execute only that step
   - Present the changes
   - Wait for feedback
   - Address any feedback until step is approved
   - Repeat until all steps are complete
   - Add timestamped log entries for progress and insights
   - Preserve all existing log entries
   
6. Only mark task as complete when:
   - All checkboxes in todo file are checked
   - User confirms completion
   - Ask user if they want to delete the todo file
   - If deleting todo file, first save the Log section for reference

When you decide to change approach due to errors, new insights or other reasons:

1. ALWAYS first ask whether the user agrees on the new approach
2. Present a new plan with steps
3. Explain and give arguments regarding why they want to step away from the current approach
4. Explain why the new approach is better (pros and cons)
5. Get feedback and continue based on the feedback
6. Update the progress file with the change in approach and reasons
7. Add a timestamped log entry explaining the change
8. Preserve all previous log entries for context

When creating or configuring Flutter/Dart projects:
- ALWAYS use the CLI tools when available (flutter, dart, etc.)
- For package management:
  * Use `flutter pub add` instead of manual pubspec.yaml editing
  * Let the CLI handle version resolution - DO NOT specify versions manually
  * Use `flutter pub get` for dependency resolution
- For project creation use `flutter create`
- For platform-specific setup use appropriate flutter commands

When creating or configuring Firebase projects:
- ALWAYS use the CLI tools when available (firebase, flutterfire)
- Use `flutterfire configure` for Flutter project setup
- Use `firebase init` for project initialization
- Use `firebase deploy` for deployments
- Let the CLI handle version compatibility

General CLI Guidelines:
- If a CLI tool exists for a task, use it instead of manual configuration
- Let CLI tools handle version management and compatibility
- Use CLI tools for project initialization, setup, and configuration

CRITICAL: Progress Tracking and Context Maintenance
   - Update the progress file CONSISTENTLY, no matter how small
   - Add detailed notes about what was done, any issues encountered, and current status
   - Mark steps as completed [x] as soon as they are done
   - Before each new step, review and summarize the current progress
   - Add timestamped log entries for:
     * Starting new steps
     * Completing steps
     * Encountering issues
     * Making important decisions
     * Changing approaches
     * Getting user feedback
   - NEVER delete or modify existing log entries
   - If context is lost (e.g., due to conversation reset):
     1. First thing to do is read the progress file
     2. Review ALL log entries for context
     3. Understand the current state of the task
     4. Confirm understanding with the user before proceeding
   - Never assume previous context is available; always rely on the progress file and log entries
   - When starting a new task with existing todo file:
     1. Review ALL existing log entries
     2. Keep ALL log entries for context
     3. Append new entries with clear timestamps

``` 
