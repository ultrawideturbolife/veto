# 📝 How We Post Blogs

# 📝 Table of Contents

- [Introduction](#introduction)
- [Suggested Approach](#suggested-approach)
- [Tutorial](#tutorial)
- [Checklist](#checklist)

# 📝 Introduction

This guide explains how we post blog content to our Ghost blog at ultra-wide-turbo-dev.ghost.io. We use a custom CLI tool that converts markdown files to Ghost posts, making it easy to maintain our blog content alongside our codebase.

# 🤖 Suggested Approach

- [ ] Create markdown file in appropriate location
- [ ] Add required frontmatter (title, tags, excerpt)
- [ ] Write content using markdown formatting
- [ ] Verify environment variables are set
- [ ] Run publishing script to create draft
- [ ] Review post in Ghost admin panel
- [ ] Make any necessary adjustments
- [ ] Publish when ready

# 👨‍🏫 Tutorial

## 1. 📝 Creating the Markdown File

1. Create a new markdown file with `.md` extension
2. Add frontmatter at the top of the file:
   ```markdown
   ---
   title: Your Post Title
   tags: 
     - tag1
     - tag2
   featured: false
   excerpt: A brief description of your post
   ---
   ```
3. Write your content using markdown formatting

## 2. 🔧 Setting Up Environment

1. Ensure `.env` file exists in `ghost/scripts` with:
   ```
   GHOST_URL=https://your-blog-url
   GHOST_ADMIN_API_KEY=your-admin-api-key
   ```

## 3. 📤 Publishing the Post

1. Navigate to the scripts directory:
   ```bash
   cd ghost/scripts
   ```

2. Run the publishing script:
   ```bash
   npm start -- publish path/to/your-post.md
   ```

3. Check the Ghost admin panel for your draft post

## 4. 👀 Reviewing and Publishing

1. Log into Ghost admin panel
2. Find your post in Drafts
3. Preview the content
4. Make any necessary adjustments
5. Publish when ready

# ✅ Checklist

- [ ] Markdown file has correct frontmatter
- [ ] All required fields are filled (title, tags, excerpt)
- [ ] Content is properly formatted
- [ ] Code blocks are correctly syntax highlighted
- [ ] Images (if any) are properly referenced
- [ ] Environment variables are correctly set
- [ ] Publishing script runs without errors
- [ ] Draft post appears in Ghost admin panel
- [ ] Content renders correctly in Ghost preview
- [ ] Final review completed before publishing

# ⚠️ Important Notes

- Always publish as draft first
- Verify frontmatter is correctly formatted
- Check for required fields (title, excerpt, tags)
- Test code blocks and formatting in Ghost preview
- Keep environment variables secure and never commit them
``` 
