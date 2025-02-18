# 📝 How We Refine Requirements

Requirements refinement is an organic, iterative process driven by continuous questioning. Rather than following a strict step-by-step process, we use an exploratory approach where we continuously refine by asking questions to expand our understanding until we feel confident enough to start development.

There's no fixed starting point or end point. Instead:

1. Start Anywhere
   - Pick any aspect you understand well (an activity, component, behavior)
   - Write it down using our object notation
   - Don't worry about getting everything right immediately

2. Expand Through Questions
   - Look at what you've written
   - Ask questions about each object
   - Let each answer lead to new objects and relationships
   - Use the template sections as inspiration for questions

3. Follow Your Mind's Flow
   - Write down new ideas as they come
   - Don't force a specific order
   - Capture relationships when you spot them
   - It's okay to leave things incomplete
   - Ask relevant questions about new additions with the goal of refining them as good as possible based on the template sections and structure

Examples:
- Activity: "Users should be able to..." → "What steps are involved?"
- Component: "We need a screen for..." → "What should it show?"
- Behavior: "The system should automatically..." → "When exactly?"
- Property: "Each item must have..." → "Why is this needed?"

Remember:
- There is no "correct" order
- Each piece of information can lead to new insights
- Each piece of information can trigger new questions
- Keep asking "What else?" and "Why?"
- Requirements evolve as you refine more of them
- NEVER assume understanding without asking clarifying questions

# 📝 Table of Contents

1. [Introduction](#-how-we-refine-requirements)
2. [GPT Agent Instructions](#-gpt-agent-instructions)
3. [Requirements Template](#-requirements-template)
4. [Tutorial](#-tutorial)

# 🤖 GPT Agent Instructions

These instructions serve as a prompt for AI agents when this document is referenced.
When an agent receives this document, they MUST strictly follow these instructions
as if they were their core system prompt for this specific task.

The agent MUST:

1. Create a new requirements document (`[FEATURE_NAME]_requirements.md`) using the EXACT template from below

2. At the top of that document, add these context-retention instructions:
   ```markdown
   # 🤖 Context Retention Instructions
   
   When working on this document:
   1. First read the entire document to understand current state
   2. Add questions as objects in the Questions section
   3. Review recent conversation history for context
   4. Ask user to confirm understanding before proceeding
   ```

3. Guide the conversation by:
   - Processing ONLY what the user tells you
   - Using template sections to inspire questions
   - Adding questions as objects in the Questions section
   - Never assuming information not explicitly stated
   - Leading the user to refine their concept further

4. For each piece of information the user provides:
   - Document it in the appropriate section
   - Add any questions that arise as objects in the Questions section
   - Look for potential connections to other sections

5. Keep the conversation focused by:
   - Asking one question at a time
   - Waiting for user's response before proceeding
   - Using the template's prompt questions and concepts as guidance
   - Helping the user explore their concept deeper

Remember:
- Never assume completion
- Only work with information explicitly provided
- Keep directing the user to refine their concept
- Use the template and its content to guide the conversation
- Always define questions as objects in the Questions section

# 📝 Requirements Template

```markdown
# 🤖 Context Retention Instructions
[As specified above]

# 👤 Actors & 🧩 Components
> *Who or what performs actions and what they interact with*
> Who benefits from this? · Who maintains this? · What do users interact with? · What shows information? · What processes data? · What stores data? · What external systems are involved? · What needs to be monitored?
---

# 🎬 Activities
> *Actions that actors or components perform*
> What can each actor do? · What should happen automatically? · What needs user input? · What happens periodically? · What triggers other activities? · What needs to be logged? · What needs to be measured? · What needs authorization?
---

## 🌊 Activity Flows & Scenarios
> *Step by step actions and different situations to handle*
> What's the ideal path? · What could fail? · What needs validation? · What needs confirmation? · What's time sensitive? · What needs recovery steps? · What should be cached? · What should be retried? · What needs rollback?
---

# 📝 Properties
> *Data, configuration, and display values*
> What identifies it? · What describes it? · What configures it? · What measures it? · What styles it? · What formats it? · What tracks it? · What groups it? · What orders it?
---

# 🛠️ Behaviors
> *Rules, validations, animations, and responses*
> When should it change? · How should it respond? · What are the limits? · What needs validation? · What needs animation? · What needs protection? · What should be cached? · What should be optimized? · What should be monitored? · What needs fallback? · How should it scale? · What should be logged? · How should it fail? · What should be measured? · What needs authorization?
---

# 💡 Ideas & 🪵 Backlog
> *Future considerations · Out of scope · Need discussion*
> What could be added later? · What's too complex now? · What needs more research? · What would be nice to have? · What are alternative approaches? · What could be automated?
---

# ❓ Questions
> *Questions are defined as objects that reference other objects*
> What's unclear? · What needs decision? · What are the edge cases? · What could be improved? · What are we missing? · What assumptions are we making? · What risks exist? · What dependencies are there?
---

# 🎯 Roles & 📝 Todo's
> *Each item above must cascade down to a todo with assigned role*
> Who's responsible for what? · What needs to be done first? · What can be done in parallel? · What are the dependencies? · What needs coordination? · What needs review? · What needs testing? · What needs documentation?
---

- UI/UX Designer
    - [ ]
- Frontend Developer
    - [ ]
- Backend Developer
    - [ ]
- DevOps Engineer
    - [ ]
- Data Engineer
    - [ ]
- Project Manager
    - [ ]
- Marketeer
    - [ ]
```

# 👨‍🏫 Tutorial

Let's see how this organic approach works with "Users should be able to create shopping lists"

We might start with the activity:
```markdown
[Create Shopping List] (Activity)
- [User] taps create button
- [System] shows create screen
```

This makes us think about the screen:
```markdown
[Create List Screen] (Component)
- Needs a way to input list name
```

Which leads to questions that we add to the Questions section:
```markdown
# ❓ Questions
[List Name Validation Question] "What validation rules should we apply to [List Name Input]?"
[Error Handling Question] "How should we display validation errors in [Create List Screen]?"
[Submit Button Question] "When should the submit button be enabled/disabled?"
```

These questions help us define behaviors:
```markdown
[List Name Input] (Component)
- Validate on change
- Show error state if invalid

[Create List Screen]
- Disable submit if invalid
```

And we might remember we need properties:
```markdown
[Shopping List]
- id: UUID
- name: string
```

Each piece naturally leads to more questions that we add to the Questions section:
```markdown
# ❓ Questions
[List Ownership Question] "Who owns a [Shopping List]?"
[List Sharing Question] "Can [Shopping List] be shared between users?"
[Connection Question] "What happens if connection fails during [Create Shopping List]?"
[Caching Question] "Should we cache [Shopping List] data locally?"
```

Keep going until you feel confident enough to start development. Use the template's prompt questions to guide your exploration and validate readiness. 