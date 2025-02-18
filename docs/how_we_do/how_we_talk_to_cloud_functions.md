# 📝 How We Talk To Cloud Functions

# 📝 Table of Contents

- [Introduction](#introduction)
- [GPT Agent Instructions](#gpt-agent-instructions)
- [Suggested Approach](#suggested-approach)
- [Tutorial](#tutorial)
- [Checklist](#checklist)

# 📝 Introduction

This guide explains how we communicate with Firebase Cloud Functions in our Flutter applications. We use a standardized approach with type-safe requests and responses, proper error handling, and comprehensive logging.

# 🎯 GPT Agent Instructions

When implementing cloud functions communication, follow these guidelines:

## Initial Confirmation
- Confirm the cloud function's purpose and expected behavior
- Verify required request and response data structures
- Check environment requirements (emulator vs production)
- Identify any specific error handling needs
- Confirm logging requirements

## Execution Guidelines
- Track implementation progress with status emojis:
  - 🔄 Setting up cloud function structure
  - 🏗️ Implementing request/response DTOs
  - 🔌 Creating API implementation
  - ✅ Testing successful
  - ❌ Error handling needed
- Validate each implementation step:
  1. Request DTO matches cloud function parameters
  2. Response DTO handles all possible responses
  3. Error handling covers all edge cases
  4. Logging provides sufficient debugging info
- Handle errors gracefully with clear messages
- Follow type-safe patterns consistently

## Implementation Steps
1. Project Setup
   - Add required dependencies
   - Configure Firebase initialization
   - Set up environment configuration

2. Function Structure
   - Create function ID enum
   - Define URL patterns
   - Implement result mapping

3. Data Transfer Objects
   - Create request DTOs
   - Implement response handling
   - Add type-safe conversions

4. API Implementation
   - Create base API class
   - Add feature-specific methods
   - Implement error handling
   - Add comprehensive logging

5. Testing & Validation
   - Test with emulator
   - Verify error handling
   - Check logging output
   - Validate type safety

## Important Notes
- Never commit sensitive credentials
- Always use type-safe patterns
- Keep error messages user-friendly
- Log appropriately for debugging
- Follow existing naming conventions
- Maintain consistent error handling

## Communication Guidelines
- Report implementation progress clearly
- Document any deviations from standard patterns
- Explain error handling strategies
- Note any special considerations
- Document environment-specific behavior

# 🎯 Suggested Approach

- [ ] Create an enum for cloud function IDs with URLs
- [ ] Create request DTOs implementing `Writeable`
- [ ] Create response DTOs with proper type mapping
- [ ] Implement base cloud functions API
- [ ] Create feature-specific API implementation
- [ ] Add proper error handling and logging
- [ ] Test the implementation

# 👨‍🏫 Tutorial

## 1. 📦 Setting Up Cloud Functions

1. Add the required dependencies to `pubspec.yaml`:
   ```yaml
   dependencies:
     cloud_functions: ^latest_version
     cloud_firestore_api: ^latest_version
     feedback_response: ^latest_version
     loglytics: ^latest_version
   ```

2. Initialize Firebase in your app:
   ```dart
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

## 2. 🔢 Creating Function IDs

1. Create an enum for your cloud functions:
   ```dart
   enum CloudFunctionId {
     acceptHouseholdInvite,
     removeHouseholdMember;

     String get url {
       switch (Environment.current) {
         case EnvironmentType.emulators:
           const host = 'localhost:5001';
           return switch (this) {
             CloudFunctionId.acceptHouseholdInvite =>
               'http://$host/your-app/region/acceptHouseholdInvite',
             // Add other cases
           };
         case EnvironmentType.prod:
           const host = 'your-cloud-run-url';
           return switch (this) {
             CloudFunctionId.acceptHouseholdInvite => 
               'https://accepthouseholdinvite-$host',
             // Add other cases
           };
       }
     }

     T? Function<T>(Map<String, dynamic>? json) get fromJsonResult {
       return switch (this) {
         CloudFunctionId.acceptHouseholdInvite => 
           <T>(json) => null, // Or proper mapping
         // Add other cases
       };
     }
   }
   ```

## 3. 📝 Creating Request DTOs

1. Create a request class implementing `Writeable`:
   ```dart
   class AcceptHouseholdInviteRequest implements Writeable {
     const AcceptHouseholdInviteRequest({
       required this.inviteId,
     });

     final String inviteId;

     @override
     Map<String, dynamic> toJson() => {
       'inviteId': inviteId,
     };
   }
   ```

## 4. 🔌 Implementing Base API

1. Create a base cloud functions API:
   ```dart
   abstract class CloudFunctionsApi with Loglytics {
     final _firebaseFunctions = FirebaseFunctions.instance;

     Future<FeedbackResponse<T>> callCloudFunction<T>({
       required CloudFunctionId cloudFunctionId,
       required Writeable writeable,
     }) async {
       try {
         log.info('Calling cloud function: $cloudFunctionId');
         final response = await _firebaseFunctions
             .httpsCallableFromUrl(cloudFunctionId.url)
             .call(writeable.toJson());
         
         log.info('Successfully called cloud function: $cloudFunctionId');
         log.debug('Response: ${response.data}');
         
         final cloudResponse = CloudResponseDto.fromJson(response.data);
         final result = cloudFunctionId.fromJsonResult<T>(cloudResponse.result);
         
         return cloudResponse.isSuccess
             ? FeedbackResponse.successNone(result: result)
             : FeedbackResponse.errorNone(message: cloudResponse.message);
       } catch (error, trace) {
         log.error(
           'Failed to call cloud function: $cloudFunctionId',
           error: error,
           stackTrace: trace,
         );
         return FeedbackResponse.errorNone();
       }
     }
   }
   ```

## 5. 🎯 Creating Feature API

1. Create a feature-specific API implementation:
   ```dart
   class RmyCloudFunctionsApi extends CloudFunctionsApi {
     static RmyCloudFunctionsApi get locate => GetIt.I.get();
     static void registerFactory() => 
       GetIt.I.registerFactory(RmyCloudFunctionsApi.new);

     Future<FeedbackResponse> acceptHouseholdInvite({
       required String inviteId,
     }) async =>
         await callCloudFunction(
           cloudFunctionId: CloudFunctionId.acceptHouseholdInvite,
           writeable: AcceptHouseholdInviteRequest(inviteId: inviteId),
         );
   }
   ```

## 6. 🧪 Testing the Implementation

1. Register your API in the dependency injection:
   ```dart
   void setupDependencies() {
     RmyCloudFunctionsApi.registerFactory();
   }
   ```

2. Call the cloud function:
   ```dart
   final api = RmyCloudFunctionsApi.locate;
   final response = await api.acceptHouseholdInvite(
     inviteId: 'some-invite-id',
   );

   if (response.isSuccess) {
     // Handle success
   } else {
     // Handle error
   }
   ```

# ✅ Checklist

- [ ] Dependencies added to pubspec.yaml
- [ ] Firebase properly initialized
- [ ] Cloud function IDs defined with proper URLs
- [ ] Request DTOs implement Writeable interface
- [ ] Response DTOs handle all possible responses
- [ ] Base API implements proper error handling
- [ ] Feature API provides type-safe methods
- [ ] Logging implemented for debugging
- [ ] Error messages are user-friendly
- [ ] Emulator support configured

# ⚠️ Important Notes

- Always use type-safe request and response DTOs
- Implement proper error handling and logging
- Support both production and emulator environments
- Use dependency injection for better testability
- Keep function URLs in a centralized enum
- Never expose sensitive information in logs
- Always return FeedbackResponse for consistent error handling 
