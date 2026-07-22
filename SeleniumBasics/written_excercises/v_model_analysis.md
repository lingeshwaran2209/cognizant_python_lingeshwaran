# Handson-2

## Task 1: V-Model Mapping

### 1. V-Model Diagram (ASCII Art)
```text
  SDLC (Development Phases)                        TDLC (Testing Phases)
  ─────────────────────────                        ─────────────────────
  Requirements Review ───────────────────────────► Acceptance Testing
         │                                                 ▲
         ▼                                                 │
   System Design ─────────────────────────────────► System Testing
         │                                                 ▲
         ▼                                                 │
   Architecture Design ───────────────────────────► Integration Testing
         │                                                 ▲
         ▼                                                 │
    Module Design ────────────────────────────────► Unit Testing
         │                                                 ▲
         ▼                                                 │
      Coding ──────────────────────────────────────────────┘
```

### 2. Test Artifacts Produced During Development Phases
*   **Requirements Phase**: Acceptance Test Plan and User Acceptance Test (UAT) criteria are written.
*   **System Design Phase**: System Test Plan and System-level Functional Test Cases are created.
*   **Architecture Design Phase**: Integration Test Plan and Component/Interface verification scripts are designed.
*   **Module Design Phase**: Unit Test Cases and component mock configurations are prepared.

### 3. Entry and Exit Criteria for Testing Levels

#### Unit Testing
*   **Entry Criteria**: Coding phase is complete; code compiles without errors; peer review is done.
*   **Exit Criteria**: 100% of unit tests pass; code coverage meets the target threshold (e.g., 80%+).

#### Integration Testing
*   **Entry Criteria**: Unit testing is complete; distinct software modules are checked into the branch repository.
*   **Exit Criteria**: Interface verification tests run successfully; no data transfer issues remain between components.

#### System Testing
*   **Entry Criteria**: Integration testing is signed off; full end-to-end system build is deployed to the test environment.
*   **Exit Criteria**: 100% of functional test cases executed; zero open Critical or High severity bugs remain.

#### User Acceptance Testing (UAT)
*   **Entry Criteria**: System testing is complete; product sign-off received; UAT environment is live with production-like data.
*   **Exit Criteria**: Business users/administrators sign off on workflow readiness; all primary user stories pass.

### 4. QA Engagement Points in Course Management API Project
*   **Engagement Point 1 (Requirements Phase)**: Participating in technical requirement reviews to spot ambiguities, gaps, or untestable rules before code drafting begins.
*   **Engagement Point 2 (Architecture Design Phase)**: Reviewing API contract designs (Swagger/OpenAPI docs) early to map parameters, preventing integration mismatches later.

---

## Task 2: Agile QA and Shift-Left Testing

### 5. Problems Caused by Traditional Waterfall Testing
*   **Delayed Bug Discovery**: Finding bugs late in the timeline makes them highly expensive and complex to fix.
*   **Timeline Compression**: Delays in development routinely shrink the testing window, risking poor deployment quality.
*   **Lack of Collaboration**: Developers and QA work in silos, creating friction and communication gaps during handovers.

### 6. QA Activities in Agile Ceremonies
*   **Sprint Planning**: QA reviews user stories and defines clear, testable Acceptance Criteria.
*   **Daily Standup**: QA shares daily progress, test coverage status, and highlights blocking issues.
*   **Sprint Review**: QA helps demonstrate verified features to stakeholders and validates real-world usability.
*   **Retrospective**: QA points out workflow friction points and suggests process fixes for the upcoming sprint.

### 7. Shift-Left Practices Applied to Course Management API
*   **(a) Reviewing requirements for testability**: QA reviews the API specs early to ensure clear error conditions are defined for invalid inputs.
*   **(b) Writing test cases before code**: Teams use a Test-Driven Development (TDD) approach to write endpoint validations before code is active.
*   **(c) Static code analysis**: Setting up tools like SonarQube in the pipeline to catch security risks and bugs automatically on every commit.
*   **(d) API contract testing**: Using tools to validate payload structures between services before full system integration.

### 8. Acceptance Criteria (Gherkin Format) - Course Creation User Story

```gherkin
Feature: Course Creation

  Scenario: Successfully create a new course (Happy Path)
    Given The college administrator is authenticated and on the dashboard
    When The admin submits a valid payload with code "CS101" and name "Intro to Python"
    Then The system should return HTTP status 201 Created
    And The course records should reflect the new entry accurately

  Scenario: Prevent creation of a course with a duplicate course code
    Given The course code "CS101" already exists in the system database
    When The admin tries to submit a new course payload with code "CS101"
    Then The system should return HTTP status 400 Bad Request
    And An error message should state "Course code must be unique"

  Scenario: Prevent creation when required fields are missing
    Given The college administrator is ready to submit a course payload
    When The admin submits a payload missing the required field "name"
    Then The system should return HTTP status 400 Bad Request
    And An validation message should identify the missing name field
```
