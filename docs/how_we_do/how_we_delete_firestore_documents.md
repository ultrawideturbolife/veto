# 🗑️ How We Delete Firestore Documents

## 📝 Introduction

This guide explains our standardized approach to implementing Firestore document deletion in our applications. We follow a layered approach that ensures safe deletion with proper validation, error handling, and user feedback.

## 🤖 GPT Agent Instructions

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
   
6. Only mark task as complete when explicitly told to do so

If the agent decides to change approach due to errors, new insights or other reasons:
1. ALWAYS first ask whether the user agrees on the new approach
2. Present a new plan with steps
3. Explain and give arguments regarding why they want to step away from the current approach
4. Explain why the new approach is better (pros and cons)
5. Get feedback and continue based on the feedback

## 🎯 Suggested Approach

- [ ] Add delete functionality to the service layer with validation logic
- [ ] Implement UI elements to trigger deletion (e.g., delete icon)
- [ ] Add view model logic with user confirmation and error handling
- [ ] Add proper logging throughout the deletion flow
- [ ] Handle empty states and navigation after deletion

## 👨‍🏫 Tutorial

### 1. 🛠️ Service Layer Implementation

First, implement the delete functionality in your service class:

```dart
Future<FeedbackResponse<void>> deleteItem(ItemDto item) async {
  // Add validation logic
  if (item.isProtected) {
    log.debug('Cannot delete protected item');
    return FeedbackResponse.error(
      title: gStrings.somethingWentWrong,
      message: 'This item cannot be deleted.',
    );
  }
  
  log.debug('Deleting item with id: ${item.id}');
  return deleteDoc(doc: item);
}
```

### 2. 🎨 UI Implementation

Add a delete button to your view:

```dart
BaseAppBar(
  context: context,
  header: EmojiHeader.scaffoldTitle(
    emoji: Emoji.yourEmoji,
    title: model.title,
  ),
  actions: [
    if (item?.isProtected == false)
      RightPadding(
        child: IconButton(
          iconData: Icons.delete_rounded,
          onPressed: () => model.onDeletePressed(context),
        ),
      ),
  ],
),
```

### 3. 🧠 View Model Implementation

Implement the delete logic in your view model:

```dart
Future<void> onDeletePressed(BuildContext context) async {
  if (gIsBusy) return;

  final shouldDelete = await gShowOkCancelDialog(
    title: (strings) => gStrings.deleteItem,
    message: (strings) => gStrings.areYouSureYouWantToDeleteThis,
  );

  if (shouldDelete != true) return;

  try {
    gSetBusy();
    final item = _item.value;
    if (item == null) {
      throw const UnexpectedResultException(reason: 'Item not found');
    }
    
    // Important: Block updates when listening to document changes
    // This prevents UI flicker and potential errors when the document is deleted
    _ignoreChanges = true;
    
    final response = await _service.deleteItem(item);
    response.fold(
      ifSuccess: (response) {
        gShowNotification(title: gStrings.itemDeleted);
        // Navigate away from the view since the item no longer exists
        gPop(context);
      },
      orElse: (response) {
        gShowOkDialog(
          title: (strings) => strings.somethingWentWrong,
          message: (strings) => gStrings.failedToDeleteItemPleaseTryAgainLater,
        );
        // Re-enable updates since deletion failed
        _ignoreChanges = false;
      },
    );
  } catch (error, stackTrace) {
    log.error(
      '$error caught while deleting item',
      error: error,
      stackTrace: stackTrace,
    );
    _ignoreChanges = false;
  } finally {
    gSetIdle();
  }
}
```

### 4. 🎭 Empty State Handling

When showing lists or managing items that can be deleted, always handle empty states:

```dart
ValueListenableBuilder<List<ItemDto>>(
  valueListenable: model.items,
  builder: (context, items, child) {
    if (items.isEmpty) {
      return EmptyPlaceholder(
        message: strings.noItemsFound,
        ctaText: strings.goBack,
        onCtaPressed: () => model.onGoBackPressed(context),
      );
    }
    
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemListTile(item: item);
      },
    );
  },
);
```

## ✅ Checklist

### Service Layer
- [ ] Implement delete method with validation
- [ ] Return FeedbackResponse
- [ ] Add logging

### View Layer  
- [ ] Add delete widget
- [ ] Implement empty state handling
- [ ] Show appropriate error states

### View Model Layer
- [ ] Handle busy state
- [ ] Show confirmation dialog
- [ ] Block updates during deletion process
- [ ] Handle errors and navigation
- [ ] Implement proper cleanup in dispose

### Empty State Handling
- [ ] Show empty state placeholder when list is empty
