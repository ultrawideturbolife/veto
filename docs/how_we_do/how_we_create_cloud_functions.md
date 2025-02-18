# Roomy Cloud Functions

A guide on implementing new cloud functions for the Roomy backend.

## Table of Contents
- [Project Structure](#project-structure)
- [Implementation Guide](#implementation-guide)
- [Example Implementation](#example-implementation)

## Project Structure

```
functions/src/
├── core/                 # Core utilities and shared code
│   ├── abstracts/       # Abstract classes and interfaces
│   ├── analytics/       # Analytics related code
│   ├── api/            # API related code
│   ├── constants/      # Shared constants
│   ├── dtos/           # Shared DTOs
│   ├── enums/          # Shared enums
│   ├── exceptions/     # Custom exceptions
│   ├── functions/      # Shared functions
│   ├── middleware/     # Auth and validation middleware
│   ├── models/         # Shared models
│   ├── requests/       # Shared request types
│   ├── responses/      # Response types
│   ├── services/       # Shared services
│   └── util/           # Utility functions
├── [feature-name]/      # Feature specific code
│   ├── abstracts/      # Feature-specific abstract classes
│   ├── analytics/      # Feature-specific analytics
│   ├── api/           # Feature-specific API code
│   ├── constants/     # Feature-specific constants
│   ├── dtos/          # Feature-specific DTOs
│   ├── enums/         # Feature-specific enums
│   ├── exceptions/    # Feature-specific exceptions
│   ├── functions/     # Feature-specific functions
│   ├── middleware/    # Feature-specific middleware
│   ├── models/        # Feature-specific models
│   ├── requests/      # Feature-specific request types
│   ├── responses/     # Feature-specific responses
│   ├── services/      # Feature-specific services
│   └── util/          # Feature-specific utilities
└── index.ts            # Main export file
```

## Implementation Guide

### 1. Create Feature Directory
Create a new directory for your feature in `functions/src/[feature-name]`.

### 2. Add Collection Type
Update `core/enums/firestoreCollectionType.ts`:

```typescript
enum FirestoreCollectionType {
    // existing types...
    yourCollection,
}

// Update firestoreDto
function firestoreDto<T>(type: FirestoreCollectionType, data: any): T {
    switch (type) {
        // existing cases...
        case FirestoreCollectionType.yourCollection:
            return YourDto.fromJson(data) as T;
    }
}

// Update firestorePath
function firestorePath(type: FirestoreCollectionType): string {
    switch (type) {
        // existing cases...
        case FirestoreCollectionType.yourCollection:
            return 'yourCollection';
    }
}
```

### 3. Create DTOs
Create `[feature-name]/dtos/your_dto.ts`:

```typescript
export class YourDto {
    constructor(
        public field1: string,
        public field2: number,
    ) {}

    static fromJson(json: any): YourDto {
        return new YourDto(
            json.field1,
            json.field2,
        );
    }

    toJson(): any {
        return {
            field1: this.field1,
            field2: this.field2,
        };
    }
}
```

### 4. Create Request Types
Create `[feature-name]/requests/your_request.ts`:

```typescript
export interface YourRequest {
    param1: string;
    param2: number;
}
```

### 5. Implement Function
Create `[feature-name]/index.ts`:

```typescript
import {onCall} from "firebase-functions/v2/https";
import {CloudResponse} from "../core/responses/cloudResponse";
import {callableAuthMiddleware} from "../core/middleware/callableAuthMiddleware";
import {YourRequest} from "./requests/your_request";

export const yourFunction = onCall(async (request) => {
    const auth = await callableAuthMiddleware(request);
    const data = request.data as YourRequest;
    
    // Your implementation
    
    return new CloudResponse({
        statusCode: 200,
        result: yourResult
    });
});
```

### 6. Export Function
Update `functions/src/index.ts`:

```typescript
export {yourFunction} from './[feature-name]';
```

## Example Implementation

Here's a complete example of implementing a household member removal function:

### 1. Household Collection Type
```typescript
// core/enums/firestoreCollectionType.ts
enum FirestoreCollectionType {
    // existing types...
    households,
}

function firestoreDto<T>(type: FirestoreCollectionType, data: any): T {
    switch (type) {
        case FirestoreCollectionType.households:
            return HouseholdDto.fromJson(data) as T;
    }
}

function firestorePath(type: FirestoreCollectionType): string {
    switch (type) {
        case FirestoreCollectionType.households:
            return 'households';
    }
}
```

### 2. Household DTO
```typescript
// households/dtos/household_dto.ts
export class HouseholdDto {
    constructor(
        public id: string,
        public name: string,
        public userIds: string[],
        public adminUserIds: string[],
        public invitedUserIds: string[],
        public createdBy: string,
        public createdAt: number,
        public updatedAt: number,
    ) {}

    static fromJson(json: any): HouseholdDto {
        return new HouseholdDto(
            json.id,
            json.name,
            json.userIds,
            json.adminUserIds,
            json.invitedUserIds,
            json.createdBy,
            json.createdAt,
            json.updatedAt,
        );
    }

    toJson(): any {
        return {
            id: this.id,
            name: this.name,
            userIds: this.userIds,
            adminUserIds: this.adminUserIds,
            invitedUserIds: this.invitedUserIds,
            createdBy: this.createdBy,
            createdAt: this.createdAt,
            updatedAt: this.updatedAt,
        };
    }
}
```

### 3. Remove Member Request
```typescript
// households/requests/remove_household_member_request.ts
export interface RemoveHouseholdMemberRequest {
    householdId: string;
    userId: string;
}
```

### 4. Function Implementation
```typescript
// households/functions/remove_household_member.ts
import {onCall} from "firebase-functions/v2/https";
import {CloudResponse} from "../../core/responses/cloudResponse";
import {callableAuthMiddleware} from "../../core/middleware/callableAuthMiddleware";
import {RemoveHouseholdMemberRequest} from "../requests/remove_household_member_request";
import {db} from "../../core/firebase";
import {firestorePath} from "../../core/enums/firestoreCollectionType";
import {throwNotFound} from "../../core/util/throwNotFound";
import {throwPermissionDenied} from "../../core/util/throwPermissionDenied";

export const removeHouseholdMember = onCall(async (request) => {
    const auth = await callableAuthMiddleware(request);
    const {householdId, userId} = request.data as RemoveHouseholdMemberRequest;
    
    const householdRef = db.collection(firestorePath(FirestoreCollectionType.households)).doc(householdId);
    const householdDoc = await householdRef.get();
    
    if (!householdDoc.exists) {
        throwNotFound("Household not found");
    }
    
    const householdData = householdDoc.data();
    if (!householdData.userIds.includes(auth.uid) && !householdData.adminUserIds.includes(auth.uid)) {
        throwPermissionDenied("You don't have permission to remove members from this household");
    }
    
    await householdRef.update({
        userIds: householdData.userIds.filter((id: string) => id !== userId),
        updatedAt: Date.now(),
    });
    
    return new CloudResponse({
        statusCode: 200,
        result: { success: true }
    });
});
```

### 5. Export Function
```typescript
// functions/src/index.ts
export {removeHouseholdMember} from './households/functions/remove_household_member';
```

## Error Handling

Use core utility functions for consistent error handling:

```typescript
import {throwNotFound} from "../core/util/throwNotFound";
import {throwPermissionDenied} from "../core/util/throwPermissionDenied";

// Not Found (404)
throwNotFound("Household not found");

// Permission Denied (403)
throwPermissionDenied("User not authorized to access this household");
```

## Response Format

All functions return a `CloudResponse`:

```typescript
new CloudResponse({
    statusCode: 200,     // HTTP status code
    message?: string,    // Optional message
    result: T | null     // Response data
});
``` 
