# Cursor Index Restore Guide

This guide explains how to restore cursor indexes in a development environment.

## Steps to Restore

1. First, locate the workspaceStorage directory from your project root:
```bash
find ~ -type d -name "workspaceStorage"
```

2. Check the contents of the found workspaceStorage directory:
```bash
ls -la /path/to/found/workspaceStorage
```

3. Determine the correct destination:
   - If there's only one hash directory, that's your destination
   - If there are multiple directories, check their contents for your project name
   - The correct directory will be something like: `workspaceStorage/<hash>`

4. Copy the cursor retrieval data:
```bash
cp -R cursor_indexes/anysphere.cursor-retrieval /path/to/workspaceStorage/<hash>/
```

## Example

If you found:
```
/home/vscode/.cursor-server/data/User/workspaceStorage
```

And it contains a single directory:
```
5eacad40e1cde70a069ccaf614716636
```

Then your restore command would be:
```bash
cp -R cursor_indexes/anysphere.cursor-retrieval /home/vscode/.cursor-server/data/User/workspaceStorage/5eacad40e1cde70a069ccaf614716636/
```

## Troubleshooting

- If no workspaceStorage directory is found, try searching in common locations:
  - `~/.cursor-server/data/User/workspaceStorage`
  - `~/.config/Cursor/User/workspaceStorage`
  - `~/Library/Application Support/Cursor/User/workspaceStorage` (macOS) 