# 🎯 Strategy Guide
> *How to fill this template*
---
Start anywhere that makes sense: user-focused (Actors), feature-focused (Activities), data-focused (Properties), or rules-focused (Behaviors). For each item you add, link it to related items using [square brackets], add its properties and behaviors, and create todos for implementation.

Every item in this template has a checkbox. Checking off an item means:
- The item itself is fully implemented
- All its children (sub-items) are fully implemented
- All its relationships are properly connected
- All its required tests are passing

Only check off a parent item when ALL its children are complete.

IMPORTANT: COPY THE ENTIRE TEMPLATE (WITH ALL HEADERS AND DESCRIPTIONS, EXCEPT THE EXAMPLES) TO THE REQUIREMENTS FILE.

# 🔗 Relationship Guide (How to connect items)
> *Every item in the requirements should be connected to other items. This creates a complete, traceable network of requirements.*
---

## Common Relationships
- Actor → performs → Activity
- Component → supports → Activity
- Activity → uses → Component
- Activity → has → Properties
- Activity → follows → Behavior
- Component → has → Properties
- Component → follows → Behavior
- Property → has → Behavior

## How to Map
Start with any item and ask:
- What uses this?
- What does this use?
- What properties does it have?
- What behaviors does it follow?
- What activities is it involved in?

## Examples
[User] performs [Create Post]
[Create Post] uses [Post Editor]
[Post Editor] has [character limit]
[character limit] follows [Show warning when exceeded]

## Validation
After completing each section, verify:
1. All items use [square brackets] to indicate relationships
2. All items have relationships
3. All items have todos
4. No orphaned items exist

# 👤 Actors & 🧩 Components (Who or what)
> *Someone or something that can perform actions or be interacted with (examples include User, Button, Screen, Input Field, Message, System, API, Database, and they can be a person, service, visual or non-visual).*
> What benefits from this? · Who maintains this? · What do users interact with? · What shows information? · What processes data? · What stores data? · What external systems are involved? · What needs to be monitored?
> Possible Parents: Actor, Component
> GPT Instructions: Start by listing all nouns from your feature description - these are your potential actors and components. Then expand this list by asking: who uses it, what do they interact with, what shows information, what stores data, and what processes data? For each item, decide if it's an Actor (can perform actions) or Component (is acted upon). Finally, break down any complex components into smaller, more manageable pieces.
---

- [ ] Example Actor
- [ ] Example Component

# 🎬 Activities (Who or what does what?)
> *Actions that an Actor or Component performs (examples include Create List, Delete Item, Sync Data, and they must always contain a verb + action).*
> What can each actor do? · What should happen automatically? · What needs user input? · What happens periodically? · What triggers other activities? · What needs to be logged? · What needs to be measured? · What needs authorization?
> Possible Parents: Actor, Component
> GPT Instructions: Take each Actor and Component and list everything they can do, must do, or should do automatically. Start each activity with a verb (create, update, delete, etc.) and make it specific. Think about: user interactions, system automations, periodic tasks, and data operations. Don't worry about the "how" yet - focus on what needs to happen.
---

- [ ] Example Actor
    - [ ] Create an example
    - [ ] Delete an example
- [ ] Example Component
    - [ ] Sync examples

## 🌊 Activity Flows & Scenarios (What in which order?)
> *Sequences of Atomic Actions (like "Tap button") that map out the steps to complete an Activity. May have optional paths for both successful completion (Happy Flow), errors (Error Flow), and scenarios like no connection, empty states, loading states, etc.*
> What's the ideal path? · What could fail? · What needs validation? · What needs confirmation? · What's time sensitive? · What needs recovery steps? · What should be cached? · What should be retried? · What needs rollback?
> Possible Parents: Activity
> GPT Instructions: For each Activity think of the perfect scenario (Happy Flow) - what happens when everything works? Then optionally add Error Flows by asking "what could go wrong?" at each step. Finally, consider edge cases like no connection, empty states, or loading states. Break each flow into atomic (indivisible) actions that can be clearly implemented and tested.
---

- [ ] Example Actor
    - [ ] Create an example
        - [ ] Happy flow
            - [ ] Tap create button
            - [ ] Enter name
            - [ ] Tap save
        - [ ] Error flow
            - [ ] Tap create button
            - [ ] Enter name
            - [ ] Tap save
            - [ ] Show error message
    - [ ] Delete an example
        - [ ] Tap delete button
        - [ ] Tap confirm

- [ ] Example Component
    - [ ] Sync examples
        - [ ] Happy flow
            - [ ] Trigger sync
            - [ ] Show loading indicator
            - [ ] Show success message
        - [ ] Error flow
            - [ ] Trigger sync
            - [ ] Show loading indicator
            - [ ] Show error message

# 📝 Properties (Which values?)
> *Describes a value or configuration that belongs to an object (examples include width, color, id, name).*
> What identifies it? · What describes it? · What configures it? · What measures it? · What styles it? · What formats it? · What tracks it? · What groups it? · What orders it?
> Possible Parents: Actor, Component, Activity, Activity Flow, Scenario, Atomic Action, Scenario, Behavior
> GPT Instructions: For each object in your system, think about its data needs in three categories: identity (what makes it unique), configuration (what can be changed), and state (what can vary). Consider what needs to be stored, displayed, measured, or tracked. Make sure each property has a clear type and purpose.
---

- [ ] Show loading indicator
    - [ ] message : "Loading..."

- [ ] Sends create analytic
    - [ ] name: "create"
    - [ ] properties: { example: "example" }

# 🛠️ Behaviors (How does it act when.. in terms of.. ?)
> *Defines how something looks, works and performs Examples include ui/ux, rules & limits, data & analytics, security, performance and scalability.*
> When should it change? · How should it respond? · What are the limits? · What needs validation? · What needs animation? · What needs protection? · What should be cached? · What should be optimized? · What should be monitored? · What needs fallback? · How should it scale? · What should be logged? · How should it fail? · What should be measured? · What needs authorization?
> Possible Parents: Actor, Component, Activity, Activity Flow, Scenario, Atomic Action, Scenario, Property
> GPT Instructions: Think about each object's rules and constraints in terms of: limits (max/min values, allowed inputs), timing (when, how often), security (who can access), and performance (what needs to be fast). Focus on behaviors that can be clearly tested - if you can't write a test for it, make it more specific.
---

- [ ] Trigger sync
    - [ ] Happens when user creates a new example
    - [ ] Max 1000 items

- [ ] Tap create button
    - [ ] Sends create analytic

- [ ] Create an example
    - [ ] Only by admins

# 🧪 Unit Tests
> *Define unit tests that verify the implementation meets the requirements. Focus only on requirements that can be meaningfully tested through unit tests - not everything needs one.*
> What behaviors can be verified? · What rules can be tested? · What calculations need validation? · What transformations should be checked? · What edge cases need testing?
> Possible Parents: Activity, Property, Behavior, Activity Flow, Scenario, Atomic Action
> GPT Instructions: For each testable requirement, define test cases following the AAA (Arrange, Act, Assert) pattern. Focus on behaviors, rules, and calculations that can be programmatically verified. Each test should be focused and test one thing at a time. Don't force tests for UI interactions or complex integrations.
---

- [ ] Create an example
    - [ ] Arrange:
        - [ ] Create non-admin user
        - [ ] Set up example service with mocked auth
    - [ ] Act:
        - [ ] Call createExample() method
    - [ ] Assert:
        - [ ] Verify unauthorized exception is thrown
        - [ ] Verify example was not created
        - [ ] Verify auth check was called once

- [ ] Trigger sync
    - [ ] Arrange:
        - [ ] Create list with 1000 items
        - [ ] Set up sync service with mocked storage
    - [ ] Act:
        - [ ] Call triggerSync() with new item
    - [ ] Assert:
        - [ ] Verify max items exceeded error is thrown
        - [ ] Verify sync was not performed
        - [ ] Verify item count remains 1000

- [ ] Example Component Properties
    - [ ] Arrange:
        - [ ] Create example with invalid properties
        - [ ] Set up validation service
    - [ ] Act:
        - [ ] Call validate() method
    - [ ] Assert:
        - [ ] Verify validation fails
        - [ ] Verify specific error messages
        - [ ] Verify invalid fields are identified

# 💡 Ideas & 🪵 Backlog
> *Anything that could be added later, too complex now, needs more research, would be nice to have, or alternative approaches.*
> What could be added later? · What's too complex now? · What needs more research? · What would be nice to have? · What are alternative approaches? · What could be automated?
> GPT Instructions: While working through the requirements, note down any ideas that come up but don't fit the current scope. Think about: future enhancements, alternative approaches, performance improvements, and nice-to-have features. Don't discard ideas just because they're complex - they might be valuable later.
---

- [ ] Delete example

# ❓ Questions
> *Questions that need to be answered to clarify requirements.*
> What's unclear? · What needs decision? · What are the edge cases? · What could be improved? · What are we missing? · What assumptions are we making? · What risks exist? · What dependencies are there?
> GPT Instructions: Throughout the process, note any uncertainties or assumptions you make. Focus on questions that could impact implementation or user experience. Each question should be linked to specific items using [square brackets].
---

- [ ] Sends create analytic
    - [ ] Do we use firebase analytics?

# 🎯 Roles & 📝 Todo's
> *Each behaviour, property, activity (flow), scenario, atomic action, actor, component must directly or indirectly (by parents) cascade down to a todo with assigned role*
> Who's responsible for what?
> GPT Instructions: Review all items in the requirements and create todos for implementation. Every item should have at least one todo. Group todos by role (UI/UX, Frontend, Backend, etc.) and ensure they're specific enough to be actionable. Link each todo to its requirement using [square brackets].
---

- [ ] UI/UX Designer
    - [ ] Design UI for [Create an example]
- [ ] Frontend Developer
    - [ ] Implement [Create an example]
    - [ ] Implement [Delete an example]
    - [ ] Create unit tests for [Create an example]
    - [ ] Create unit tests for [Delete an example]
- [ ] Backend Developer
    - [ ] Implement [Sync examples]
    - [ ] Make API for [Create example]
    - [ ] Make API for [Delete example]
    - [ ] Update security rules for [Create example]
- [ ] Data Engineer
    - [ ] Answer [Do we use firebase analytics?]
    - [ ] Implement [Sends create analytic]
- [ ] DevOps Engineer
    - [ ] Make CI/CD pipeline
- [ ] Project Manager
    - [ ] Review [Do we use firebase analytics?]
- [ ] Marketeer
    - [ ] Make new release