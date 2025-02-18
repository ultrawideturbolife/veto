# 👤 Actors & 🧩 Components
- [x] [CLI Tool]
    - [x] [Config Manager]
        - [x] Manages source and target configurations
        - [x] Stores configurations in .turbo/config.json
    - [x] [Sync Engine]
        - [x] Handles file watching and syncing
        - [x] Manages file operations
    - [ ] [Logger]
        - [ ] Provides formatted output
        - [ ] Shows progress and errors

# 🎬 Activities
- [x] [Configure Source]
    - [x] Add source directory with tag
    - [x] Validate source exists
    - [x] Save to config
- [x] [Configure Target]
    - [x] Add target directory with tag
    - [x] Validate target exists
    - [x] Save to config
- [x] [Start Sync]
    - [x] Start sync for specific tag
    - [x] Watch for changes
    - [x] Copy files
    - [x] Handle deletions

## 🌊 Activity Flows
- [x] [Configure Source]
    - [x] Happy Flow
        - [x] Run `turbo source add --tag <tag> --path <path>`
        - [x] Validate directory exists
        - [x] Create .turbo directory if needed
        - [x] Save configuration
        - [x] Show success message
    - [x] Error Flow (Invalid Path)
        - [x] Run command with invalid path
        - [x] Show error message
        - [x] Exit with error code

- [x] [Configure Target]
    - [x] Happy Flow
        - [x] Run `turbo target add --tag <tag> --path <path>`
        - [x] Validate directory exists
        - [x] Save configuration
        - [x] Show success message
    - [x] Error Flow (Invalid Path)
        - [x] Run command with invalid path
        - [x] Show error message
        - [x] Exit with error code

- [x] [Start Sync]
    - [x] Happy Flow
        - [x] Run `turbo sync start --tag <tag>`
        - [x] Load configuration
        - [x] Validate source and targets exist
        - [x] Start file watcher
        - [x] Show sync status
    - [x] Error Flow (Invalid Tag)
        - [x] Run command with invalid tag
        - [x] Show error message
        - [x] Exit with error code

# 📝 Properties
- [x] [Config File]
    - [x] path: ".turbo/config.json"
    - [x] format: JSON

- [x] [Source Configuration]
    - [x] tag: string
    - [x] path: string
    - [x] created_at: DateTime

- [x] [Target Configuration]
    - [x] tag: string
    - [x] path: string
    - [x] created_at: DateTime

# 🛠️ Behaviors
- [x] [Config Manager]
    - [x] Creates .turbo directory if not exists
    - [x] Creates config.json if not exists
    - [x] Validates paths before saving
    - [x] Prevents duplicate tags

- [x] [Sync Engine]
    - [x] Uses watcher for file watching
    - [x] Handles file creation/modification/deletion
    - [x] Maintains directory structure
    - [x] Skips .turbo directory
    - [x] Skips .DS_Store files
    - [x] Skips git internals

- [ ] [Logger]
    - [ ] Shows timestamps
    - [ ] Color codes different message types
    - [ ] Shows progress for long operations

# 🧪 Unit Tests
- [x] [Config Manager]
    - [x] Test adding source
        - [x] Arrange: Create temp directory
        - [x] Act: Add source config
        - [x] Assert: Config file contains correct data

    - [x] Test adding target
        - [x] Arrange: Create temp directory and source
        - [x] Act: Add target config
        - [x] Assert: Config file contains correct data

    - [x] Test duplicate tag
        - [x] Arrange: Add source with tag
        - [x] Act: Add another source with same tag
        - [x] Assert: Error is thrown

- [x] [Sync Engine]
    - [x] Test file sync
        - [x] Arrange: Set up source and target
        - [x] Act: Create file in source
        - [x] Assert: File exists in target

    - [x] Test file deletion
        - [x] Arrange: Create file in source and target
        - [x] Act: Delete file from source
        - [x] Assert: File is deleted from target

# 💡 Ideas & 🪵 Backlog
- [ ] Add support for ignore patterns
- [ ] Add dry-run mode
- [ ] Add support for multiple tags per directory
- [ ] Add support for bidirectional sync
- [ ] Add support for sync conflict resolution
- [ ] Add support for file transformations

# ❓ Questions
- [ ] Should we support wildcards in paths?
- [ ] How should we handle symlinks?
- [ ] Should we support remote directories?

# 🎯 Roles & 📝 Todo's
- [ ] CLI Developer
    - [x] Implement [Config Manager]
    - [x] Implement [Sync Engine]
    - [ ] Implement [Logger]
    - [x] Create unit tests for [Config Manager]
    - [x] Create unit tests for [Sync Engine]
    - [ ] Document CLI commands
    - [ ] Create example configurations

# 📝 Progress Log
2025-01-04:
- ✅ Implemented Config Manager with JSON storage
- ✅ Added source and target commands with tag support
- ✅ Created comprehensive tests for Config Manager
- ✅ All Config Manager tests passing
- ✅ Command structure set up with proper error handling

2025-01-04 (continued):
- ✅ Implemented Sync Engine with file watching
- ✅ Added support for file creation, modification, and deletion
- ✅ Created comprehensive tests for Sync Engine
- ✅ All Sync Engine tests passing
- ✅ Added proper cleanup of empty directories
- ✅ Added file exclusion patterns (.DS_Store, .git, etc.)

Next step: Implement the Logger for better output formatting and progress tracking. Would you like me to proceed with that? 