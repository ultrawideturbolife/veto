# Cursor Index Copy Guide

This guide explains how to copy cursor indexes from your local environment.

## Steps to Copy

1. First, locate the workspaceStorage directory:
```bash
find ~ -type d -name "workspaceStorage"
```

2. Check the contents of the found workspaceStorage directory:
```bash
ls -la /path/to/found/workspaceStorage
```

3. Find the correct hash directory:
   - List all workspace.json files to find your project:
```bash
cat /path/to/workspaceStorage/*/workspace.json | grep -l "your_project_path"
```
   - The directory containing your project's workspace.json is your source

4. Copy the cursor retrieval data:
```bash
cp -R /path/to/workspaceStorage/<hash>/anysphere.cursor-retrieval cursor_indexes/
```

## Example

If you found:
```
/Users/username/Library/Application Support/Cursor/User/workspaceStorage
```

And found your project in:
```
c9ea4f3725af00371fc9700bee024ec7/workspace.json
```

Then your copy command would be:
```bash
cp -R "/Users/username/Library/Application Support/Cursor/User/workspaceStorage/c9ea4f3725af00371fc9700bee024ec7/anysphere.cursor-retrieval" cursor_indexes/
```

## Troubleshooting

- If no workspaceStorage directory is found, try searching in common locations:
  - `~/.cursor-server/data/User/workspaceStorage`
  - `~/.config/Cursor/User/workspaceStorage`
  - `~/Library/Application Support/Cursor/User/workspaceStorage` (macOS) 