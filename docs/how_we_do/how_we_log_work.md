# 📝 How We Create Logs

## 📝 Introduction

We log our work to:
- Document technical decisions and implementations
- Create source material for documentation
- Track project progress and solutions
- Share knowledge within the team
- Capture visual context for complex changes
- Generate content for social media sharing
- Enable cross-project knowledge sharing

## 📁 Log Structure

All projects share a central log directory at `/Users/codaveto/Documents/ultrawideturbodev/logs` with the following structure:

```
/Users/codaveto/Documents/ultrawideturbodev/logs/
  ├── YYYY/            # Year folder
  │   ├── MM/          # Month folder
  │   │   ├── DD.md    # Daily log file (shared by all projects)
  │   │   └── ...
  │   └── ...
```

The template for creating new logs is stored at `docs/templates/log_template.md`

## 📝 What to Log

Each completed task entry should include:
- Project name
- Amount of work it would take a human to do (HH:MM)
- What was actually done
- How it was implemented
- Why certain decisions were made
- Links to related work (PRs, docs)
- Screenshot placeholders for:
  - Technical documentation
  - Social media content
- Important insights or learnings

## ✅ Best Practices

- Log right after completing a task while details are fresh
- Always include your project name in entries
- Keep entries factual and concise
- Include relevant links to code, PRs, or documentation
- Tag entries for easy searching (#bug, #feature, #meeting)
- Focus on technical details and decisions
- Document problems solved and how
- Respect and preserve other projects' entries
- Add screenshot placeholders for:
  - Technical documentation:
    - UI changes and flows
    - Bug reproductions
    - Complex data structures
    - Architecture diagrams
  - Social media content:
    - Cool UI animations
    - Before/after improvements
    - Interesting visualizations
    - Impressive features
    - Developer experience improvements

## 🤖 GPT Agent Instructions

When logging work:

1. Multi-Agent Coordination:
   - Multiple agents from different projects will be updating these logs
   - Always read the entire file before appending to avoid conflicts
   - Add your project name to each task entry
   - Maintain chronological order of entries
   - Respect existing content and formatting

2. Create/Update Log:
   - Always use `/Users/codaveto/Documents/ultrawideturbodev/logs` as base directory
   - Check if the log file already exists at `/Users/codaveto/Documents/ultrawideturbodev/logs/YYYY/MM/DD.md`
   - If it exists:
     - Read the entire file first
     - Append your entry while maintaining chronological order
     - Preserve existing entries and formatting
   - If not:
     - Create necessary directories and the log file
     - Initialize with this template
   - Use descriptive task titles with project name

3. For Each Task Entry:
   - Include project name in task title
   - Add amount of work (HH:MM)
   - Document what was actually done
   - Explain how it was implemented
   - Note why certain decisions were made
   - Include all relevant links (PRs, docs, etc.)
   - Add important insights or learnings
   - Keep it factual and concise
   - Add screenshot placeholders for:
     - Technical context (UI changes, flows, bugs)
     - Social media worthy moments:
       - Cool UI animations
       - Before/after improvements
       - Interesting visualizations
       - Impressive features
       - Developer experience improvements

4. Focus on:
   - Technical details that might be useful later
   - Decisions and their rationale
   - Problems solved and how
   - Links to all related work
   - Content opportunities for social media
   - Knowledge worth preserving

DON'T FORGET: Check if the log file already exists at `/Users/codaveto/Documents/ultrawideturbodev/logs/YYYY/MM/DD.md`
