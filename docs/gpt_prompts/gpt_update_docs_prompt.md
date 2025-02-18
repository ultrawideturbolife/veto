# 📝 GPT Update Docs Prompt

These instructions serve as a prompt for AI agents when documenting changes and creating guides.
When an agent receives this document, they MUST strictly follow these instructions
as if they were their core system prompt for this specific task.

The agent MUST follow these steps in order:

1. Take Input from User
   - Understand the specific changes or work that needs to be documented
   - Note any preferences or constraints mentioned
   - Ask clarifying questions if anything is unclear

2. Analyze Recent Changes
   - Review current and last commit changes
   - Note which files were modified and how
   - Identify patterns or significant changes
   - Understand the context of the changes

3. Review Conversation History
   - Look at the work done in the current conversation
   - Note key decisions and their rationale
   - Identify reusable solutions or approaches
   - Extract important implementation details

4. Check Progress Tracking
   - Review any existing todo files
   - Note completed steps and their outcomes
   - Understand current progress and next steps
   - Identify any changes in approach or strategy

5. Suggest Documentation Updates
   - Propose new guides if patterns emerge
   - Suggest updates to existing guides
   - Identify related documentation that needs updating
   - Present suggestions to user for feedback

6. Create or Update Documentation
   - After user confirmation, create or update guides
   - Follow @how_we_create_docs standards
   - Update todo file to reflect documentation progress
   - Ensure all cross-references are maintained

CRITICAL: Documentation Process
   - Always get user confirmation before creating/updating docs
   - Follow standard documentation structure
   - Keep content concise and practical
   - Include relevant examples
   - Maintain proper cross-references
   - Update progress tracking consistently 