# 🎯 UltraWideTurbo CLI Sync Feature Requirements

# 👤 Actors & 🧩 Components
- [ ] User
    - [ ] Developer using the CLI
- [ ] CLI Components
    - [ ] Source Command
    - [ ] Target Command
    - [ ] Sync Command
    - [ ] Config Manager
    - [ ] Sync Engine

# 🎬 Activities
- [ ] Source Management
    - [ ] Add source folder with tag
    - [ ] List source folders
    - [ ] Remove source folder
- [ ] Target Management
    - [ ] Add target folder with tag
    - [ ] List target folders
    - [ ] Remove target folder
- [ ] Tag Management
    - [ ] List all tags with their sources and targets
- [ ] Sync Operations
    - [ ] Sync single tag
    - [ ] Sync multiple tags
    - [ ] Watch for changes

## 🌊 Activity Flows
- [ ] Add source folder
    - [ ] Happy flow
        - [ ] Run `turbo source <folder> --tag <tag>`
        - [ ] Validate folder exists
        - [ ] Add to config
        - [ ] Show success message
    - [ ] Error flow
        - [ ] Show error if folder doesn't exist
        - [ ] Show error if tag already exists

- [ ] Add target folder
    - [ ] Happy flow
        - [ ] Run `turbo target <folder> --tag <tag>`
        - [ ] Validate folder exists
        - [ ] Add to config
        - [ ] Show success message
    - [ ] Error flow
        - [ ] Show error if folder doesn't exist
        - [ ] Show error if tag doesn't exist

- [ ] Remove source folder
    - [ ] Happy flow
        - [ ] Run `turbo source <folder> --remove`
        - [ ] Remove from config
        - [ ] Show success message
    - [ ] Error flow
        - [ ] Show error if source doesn't exist

- [ ] Remove target folder
    - [ ] Happy flow
        - [ ] Run `turbo target <folder> --remove`
        - [ ] Remove from config
        - [ ] Show success message
    - [ ] Error flow
        - [ ] Show error if target doesn't exist

- [ ] List sources
    - [ ] Happy flow
        - [ ] Run `turbo source --list`
        - [ ] Show all configured sources
        - [ ] Show tag and path for each source
    - [ ] Empty flow
        - [ ] Show "No sources configured" message

- [ ] List targets
    - [ ] Happy flow
        - [ ] Run `turbo target --list`
        - [ ] Show all configured targets
        - [ ] Show tag and path for each target
    - [ ] Empty flow
        - [ ] Show "No targets configured" message

- [ ] List tags
    - [ ] Happy flow
        - [ ] Run `turbo tag --list`
        - [ ] Show all configured tags
    - [ ] Empty flow
        - [ ] Show "No tags configured" message

- [ ] List syncs
    - [ ] Happy flow
        - [ ] Run `turbo sync --list`
        - [ ] Show all active syncs
        - [ ] For each sync show:
            - [ ] Tag
            - [ ] Source folder
            - [ ] Target folders
            - [ ] Watch status (active/inactive)
    - [ ] Empty flow
        - [ ] Show "No active syncs" message

- [ ] Sync operations
    - [ ] Single tag sync
        - [ ] Happy flow
            - [ ] Run `turbo sync <tag>`
            - [ ] Copy all files from source to targets
            - [ ] Show progress
            - [ ] Handle file renames
        - [ ] Error flow
            - [ ] Show error if tag doesn't exist
            - [ ] Show error if source folder is missing
            - [ ] Show error if target folder is missing
            - [ ] Show error if files can't be copied
            - [ ] Show error if rename operation fails
    - [ ] Multiple tag sync
        - [ ] Happy flow
            - [ ] Run `turbo sync <tag1> <tag2> <tag3>`
            - [ ] Copy files for each tag
            - [ ] Show progress per tag
        - [ ] Error flow
            - [ ] Show error if any tag doesn't exist
            - [ ] Show error if any source folder is missing
            - [ ] Show error if any target folder is missing
            - [ ] Continue with valid tags if some fail
    - [ ] Watch mode
        - [ ] Happy flow
            - [ ] Run `turbo sync <tag> --watch`
            - [ ] Initial sync
            - [ ] Watch for changes
            - [ ] Collect changes for 2s debounce period
            - [ ] Optimize collected changes
            - [ ] Execute optimized batch
            - [ ] Report batch results
        - [ ] Error flow
            - [ ] Show error if watch fails to start
            - [ ] Show error if sync fails during watch
            - [ ] Show error if rename detection fails
            - [ ] Show error if debounce timer fails
            - [ ] Show error if batch optimization fails
            - [ ] Roll back failed batch operations
            - [ ] Attempt to restart watch on error
            - [ ] Allow graceful shutdown

# 📝 Properties
- [ ] Source
    - [ ] tag: String
    - [ ] path: String
- [ ] Target
    - [ ] tag: String
    - [ ] paths: List<String>
- [ ] Config
    - [ ] sources: Map<String, String>
    - [ ] targets: Map<String, List<String>>
- [ ] Sync Status
    - [ ] isActive: bool
    - [ ] tag: String
    - [ ] watchMode: bool
    - [ ] lastSyncTime: DateTime
    - [ ] error: String?
    - [ ] debounceTime: Duration = 2 seconds
    - [ ] lastDebounceTime: DateTime?
- [ ] File Operation
    - [ ] type: Enum (CREATE, MODIFY, DELETE, RENAME)
    - [ ] oldPath: String?
    - [ ] newPath: String
    - [ ] timestamp: DateTime
- [ ] Batch Operation
    - [ ] operations: List<FileOperation>
    - [ ] startTime: DateTime
    - [ ] endTime: DateTime
    - [ ] status: Enum (PENDING, IN_PROGRESS, COMPLETED, FAILED)
    - [ ] error: String?

# 🛠️ Behaviors
- [ ] Source Management
    - [ ] Only one source per tag
    - [ ] Source must exist
    - [ ] Source path must be absolute or relative to current directory
- [ ] Target Management
    - [ ] Multiple targets per tag
    - [ ] Target must exist
    - [ ] Target path must be absolute or relative to current directory
- [ ] Sync Operations
    - [ ] Skip system files (.DS_Store, Thumbs.db)
    - [ ] Maintain directory structure
    - [ ] Handle file deletions
    - [ ] Handle file modifications
    - [ ] Handle new files
    - [ ] Handle file renames
        - [ ] Detect file rename in source
        - [ ] Delete old file in targets
        - [ ] Copy new file to targets
        - [ ] Preserve file content on rename
    - [ ] Debounce file operations
        - [ ] Wait 2 seconds after last file change
        - [ ] Batch changes during debounce period
        - [ ] Execute all changes after debounce
        - [ ] Reset timer on new changes
    - [ ] Batch Operations
        - [ ] Collect all file operations during debounce period
        - [ ] Group operations by type (CREATE, MODIFY, DELETE, RENAME)
        - [ ] Optimize operations
            - [ ] Remove redundant operations (e.g., create then delete)
            - [ ] Combine multiple modifications into one
            - [ ] Handle rename chains (A -> B -> C becomes A -> C)
        - [ ] Execute operations in correct order
            - [ ] First: Deletes
            - [ ] Second: Renames
            - [ ] Third: Creates/Modifications
        - [ ] Roll back all operations on failure
    - [ ] Clean up empty directories

# 🧪 Unit Tests
- [ ] Source Command Tests
    - [ ] `turbo source <folder>` adds source
    - [ ] `turbo source --list` shows all sources
    - [ ] `turbo source <folder> --remove` removes source
    - [ ] `turbo source --list` shows "No sources configured" when empty
    - [ ] `turbo source <folder>` fails with invalid folder
    - [ ] `turbo source <folder>` fails with duplicate tag
    - [ ] `turbo source <folder> --remove` fails with non-existent source
- [ ] Target Command Tests
    - [ ] `turbo target <folder>` adds target
    - [ ] `turbo target --list` shows all targets
    - [ ] `turbo target <folder> --remove` removes target
    - [ ] `turbo target --list` shows "No targets configured" when empty
    - [ ] `turbo target <folder>` fails with invalid folder
    - [ ] `turbo target <folder>` fails with non-existent tag
    - [ ] `turbo target <folder> --remove` fails with non-existent target
- [ ] Tag Command Tests
    - [ ] `turbo tag --list` shows all configured tags
    - [ ] `turbo tag --list` shows "No tags configured" when empty
    - [ ] `turbo tag --list` shows correct source and targets for each tag
- [ ] Sync Command Tests
    - [ ] `turbo sync <tag>` syncs single tag
    - [ ] `turbo sync <tag> <tag> <tag>` syncs multiple tags
    - [ ] `turbo sync <tag> <tag> --watch` watches multiple tags and their configured targets for changes
    - [ ] `turbo sync <tag> --watch` watches one tag and its configured targets for changes
    - [ ] `turbo sync --list` shows all active and inactive syncs with details
    - [ ] `turbo sync --list` shows "No active syncs" when empty
    - [ ] `turbo sync <tag>` fails with non-existent tag
    - [ ] `turbo sync <tag>` fails with missing source folder
    - [ ] `turbo sync <tag>` fails with missing target folder
    - [ ] `turbo sync <tag> --watch` recovers from watch errors
    - [ ] `turbo sync <tag> <tag>` continues with valid tags if some fail
    - [ ] `turbo sync <tag>` correctly handles file rename in source
    - [ ] `turbo sync <tag> --watch` detects and syncs file renames in real-time
    - [ ] `turbo sync <tag>` preserves file content during rename
    - [ ] `turbo sync <tag>` handles multiple simultaneous renames
    - [ ] `turbo sync <tag> --watch` debounces file changes for 2 seconds
    - [ ] `turbo sync <tag> --watch` batches multiple changes during debounce
    - [ ] `turbo sync <tag> --watch` resets debounce timer on new changes
    - [ ] `turbo sync <tag> --watch` executes all changes after debounce period
    - [ ] Batch Operation Tests
        - [ ] Redundant operations are removed during debounce
        - [ ] Multiple modifications are combined
        - [ ] Rename chains are optimized
        - [ ] Operations execute in correct order
        - [ ] Failed batches are rolled back completely
        - [ ] Batch status is reported correctly
        - [ ] Multiple batches can be queued
        - [ ] Batches respect debounce timing

# 🎯 Roles & 📝 Todo's
- [ ] Developer
    - [ ] Implement source command functionality
    - [ ] Implement target command functionality
    - [ ] Implement list command functionality
    - [ ] Implement sync command functionality
    - [ ] Write unit tests for all commands
    - [ ] Ensure all tests pass
    - [ ] Document usage in README

# 📋 Implementation Plan

## Phase 1: Core Infrastructure
1. [ ] Config Manager Implementation
    - [ ] Create ConfigManager class with in-memory state
    - [ ] Implement file persistence (load/save)
    - [ ] Add source management methods
        - [ ] addSource(tag, path)
        - [ ] removeSource(path)
        - [ ] listSources()
    - [ ] Add target management methods
        - [ ] addTarget(tag, path)
        - [ ] removeTarget(path)
        - [ ] listTargets()
    - [ ] Add config validation
        - [ ] validateSourcePath(path)
        - [ ] validateTargetPath(path)
        - [ ] validateTag(tag)

2. [ ] Sync Engine Implementation
    - [ ] Create SyncEngine class
    - [ ] Implement file system operations
        - [ ] copyFile(source, target)
        - [ ] deleteFile(path)
        - [ ] watchDirectory(path)
        - [ ] detectRename(oldPath, newPath)
        - [ ] handleRename(oldPath, newPath, targets)
    - [ ] Add sync methods
        - [ ] syncTag(tag)
        - [ ] syncMultipleTags(tags)
        - [ ] startWatching(tags)
        - [ ] stopWatching(tags)
    - [ ] Add debounce handling
        - [ ] createDebounceTimer()
        - [ ] resetDebounceTimer()
        - [ ] batchChanges(changes)
        - [ ] executeBatchedChanges()
    - [ ] Add batch handling
        - [ ] createBatch()
        - [ ] addToBatch(operation)
        - [ ] optimizeBatch()
        - [ ] executeBatch()
        - [ ] rollbackBatch()
        - [ ] reportBatchStatus()

## Phase 2: Command Implementation
3. [ ] Source Command
    - [ ] Create SourceCommand class
    - [ ] Implement command options
        - [ ] --tag for adding source
        - [ ] --list for showing sources
        - [ ] --remove for removing source
    - [ ] Add input validation
    - [ ] Add error handling
    - [ ] Add success messages

4. [ ] Target Command
    - [ ] Create TargetCommand class
    - [ ] Implement command options
        - [ ] --tag for adding target
        - [ ] --list for showing targets
        - [ ] --remove for removing target
    - [ ] Add input validation
    - [ ] Add error handling
    - [ ] Add success messages

5. [ ] Tag Command
    - [ ] Create TagCommand class
    - [ ] Implement command options
        - [ ] --list for showing tags
    - [ ] Add output formatting
    - [ ] Add empty state handling

6. [ ] Sync Command
    - [ ] Create SyncCommand class
    - [ ] Implement command options
        - [ ] <tag> for single tag sync
        - [ ] <tag> <tag> for multiple tag sync
        - [ ] --watch for watching changes
        - [ ] --list for showing syncs
    - [ ] Add progress reporting
    - [ ] Add error handling
    - [ ] Add watch mode handling

## Phase 3: Testing
7. [ ] Unit Tests
    - [ ] Config Manager Tests
        - [ ] Test file persistence
        - [ ] Test source management
        - [ ] Test target management
        - [ ] Test validation
    - [ ] Sync Engine Tests
        - [ ] Test file operations
        - [ ] Test sync operations
        - [ ] Test watch mode
    - [ ] Command Tests
        - [ ] Test source commands
        - [ ] Test target commands
        - [ ] Test tag commands
        - [ ] Test sync commands

## Phase 4: Documentation & Polish
8. [ ] Documentation
    - [ ] Update README.md
        - [ ] Installation instructions
        - [ ] Usage examples
        - [ ] Command reference
    - [ ] Add inline code documentation
    - [ ] Create example configurations

9. [ ] Final Polish
    - [ ] Add colorized output
    - [ ] Improve error messages
    - [ ] Add progress indicators
    - [ ] Add debug logging
    - [ ] Performance optimization

## Implementation Order
1. Config Manager (foundation for all commands)
2. Source Command (needed for setting up syncs)
3. Target Command (needed for setting up syncs)
4. Tag Command (for viewing configurations)
5. Sync Engine (core sync functionality)
6. Sync Command (brings everything together)
7. Tests (verify everything works)
8. Documentation (make it usable)
9. Polish (make it nice)

## Dependencies
- Config Manager <- All Commands
- Sync Engine <- Sync Command
- Source Command <- Sync Command
- Target Command <- Sync Command
- Tag Command (independent)

## Milestones
1. [ ] Basic Configuration Management
    - Config Manager implemented
    - Source and Target commands working
    - Basic tests passing

2. [ ] Core Sync Functionality
    - Sync Engine implemented
    - Single tag sync working
    - Watch mode working
    - Core tests passing

3. [ ] Complete Feature Set
    - All commands implemented
    - Multiple tag sync working
    - All tests passing
    - Basic documentation

4. [ ] Production Ready
    - Full documentation
    - All edge cases handled
    - Polished user experience
    - Performance optimized
``` 