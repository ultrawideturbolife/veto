# 📚 How We Create Documentation

## 📁 Documentation Structure

Our documentation is organized in strategic locations:

```
your_project_mono/
  ├── docs/           
  │   ├── how_we_do/           # Step-by-step guides and procedures
  │   ├── wiki/                # Knowledge base and reference materials
  │   ├── feature_examples/    # Detailed documentation of implemented features
  │   ├── templates/           # Template files and boilerplates
  │   ├── gpt_prompts/         # Instructions and prompts for AI agents
  │   ├── requirements/        # Requirements for a feature, task or bug
  │   ├── tickets/             # Tickets for a feature, task or bug
  │   └── logs/                # Daily work logs and reflections
```

## ✍️ Common Style Guidelines

- Use emoticons for all main headers
- Keep explanations concise and clear
- Include practical code examples where relevant
- Use markdown formatting consistently
- One sentence per checklist item
- Document titles should be in Pascal Case with spaces
- Always add a line break after each header for proper parsing in all editors

## 🚀 Common Best Practices

- Place docs in their appropriate directory based on type
- Start filenames with appropriate prefix
- Include relevant code examples
- Keep formatting consistent
- Link to related documentation when helpful
- Document while the information is fresh

## 📖 Document Types and Their MANDATORY File Structures

### 1. How We Do Documents

Step-by-step guides for procedures and implementations.

#### Table of Contents

- Title: "# 📝 Table of Contents"
- Content: List of all sections in the document
- Keep it concise but comprehensive

#### Introduction Section

- Title: "# 📝 File Name In Pascal Case With Spaces"
- Content: Explain what the feature/concept is, how it works, and why we use it
- Keep it concise but comprehensive

#### GPT Agent Instructions Section

- Title: "## 🤖 GPT Agent Instructions"
- Content: Instructions for AI agents to execute the document's content
- Include:

     - Confirm implementation goals
     - State key assumptions
     - Request clarification
     - Progress tracking with status emojis (🔄 In Progress | ✅ Completed | ❌ Failed)
     - Validation steps for changes
     - Error handling procedures
     - Detailed checklist of all required steps
     - Organized by major sections
     - Each step should be trackable
     - Critical instructions for execution
     - Verification requirements
     - Communication guidelines

#### Suggested Approach Section

- Title: "# 🎯 Suggested Approach"
- Format: Checklist style with "- [ ]" prefix
- Each step should be one sentence max
- Steps should outline the implementation process

#### Tutorial Section

- Title: "# 👨‍🏫 Tutorial"
- Important: Sub-sections should match each step from the Suggested Approach
- Include code examples and explanations
- Use numbered sub-headers with emoticons

#### Checklist Section

- Title: "# ✅ Checklist"
- Format: Checklist style with "- [ ]" prefix
- List verification points for correct implementation
- Cover all critical aspects mentioned in tutorial

### 2. Feature Example Documents

Detailed documentation of implemented features.

#### Introduction Section

- Title: "# 📝 File Name In Pascal Case With Spaces"
- Content: Explain what feature was implemented and why
- Include any relevant context or dependencies

#### Table of Contents

- Title: "# 📝 Table of Contents"
- Content: List of all sections in the document
- Keep it concise but comprehensive

#### The Plan Section

- Title: "# 🎯 The Plan"
- Format: Numbered list
- Each step should reflect exactly what was done
- Keep steps concise and clear

#### Implementation Section

- Title: "# 💻 Implementation"
- Sub-sections matching The Plan steps
- Include actual code snippets used
- Explain patterns and important decisions
- Document why certain approaches were chosen

#### GPT Agent Instructions Section

- Title: "## 🤖 GPT Agent Instructions"
- Content: Instructions for AI agents to execute the document's content
- Start with an introduction explaining:

  ```markdown
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
   
   - If not already there, create a markdown file named `gpt_agent_todo.md` with this structure:

     # Goal
     Clear description of what needs to be achieved

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

   - Execute ONLY the first step
   - Present the changes
   - Wait for feedback
   - Address any feedback until step is approved
   - Wait for explicit permission to proceed to next step

5. For each subsequent step:

   - Wait for permission to proceed
   - Execute only that step
   - Present the changes
   - Wait for feedback
   - Address any feedback until step is approved
   - Repeat until all steps are complete
   
6. Only mark task as complete when:
   - All checkboxes in todo file are checked
   - User confirms completion
   - Ask user if they want to delete the todo file

If the agent decides to change approach due to errors, new insights or other reasons:
1. ALWAYS first ask whether the user agrees on the new approach
2. Present a new plan with steps
3. Explain and give arguments regarding why they want to step away from the current approach
4. Explain why the new approach is better (pros and cons)
5. Get feedback and continue based on the feedback
6. Update the progress file with the change in approach and reasons

CRITICAL: Progress Tracking and Context Maintenance
   - Update the progress file CONSISTENTLY, no matter how small
   - Add detailed notes about what was done, any issues encountered, and current status
   - Mark steps as completed [x] as soon as they are done
   - Before each new step, review and summarize the current progress
   - If context is lost (e.g., due to conversation reset):
     1. First thing to do is read the progress file
     2. Understand the current state of the task
     3. Confirm understanding with the user before proceeding
   - Never assume previous context is available; always rely on the progress file
```

- Include the following subsections:

  1. **Initial Confirmation**

     - Confirm implementation goals
     - State key assumptions
     - Request clarification

  2. **Execution Guidelines**

     - Progress tracking with status emojis (🔄 In Progress | ✅ Completed | ❌ Failed)
     - Validation steps for changes
     - Error handling procedures

  3. **Execution Checklist**

     - Detailed checklist of all required steps
     - Organized by major sections
     - Each step should be trackable

  4. **Important Notes**

     - Critical instructions for execution
     - Verification requirements
     - Communication guidelines

### 3. Wiki Documents

Knowledge base and reference materials.

#### Introduction Section

- Title: "# 📝 Topic Name"
- Overview of the topic
- Relevance to the project

#### Table of Contents

- Title: "# 📝 Table of Contents"
- Content: List of all sections in the document
- Keep it concise but comprehensive

#### Reference Content

- Organized by relevant sub-topics
- Include code snippets, diagrams, or examples
- Link to related documentation
- Keep information factual and verifiable

#### Additional Resources

- Links to external documentation
- Related internal documents
- Tools or libraries mentioned
