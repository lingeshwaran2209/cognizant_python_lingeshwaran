## Handson-1
## Task 1: Map Testing Types to a Real System
*   **Unit Testing**: Testing the `validate_course_code()` Python function in isolation to verify it correctly flags invalid alphanumeric strings before any database or routing layer is invoked.
*   **Integration Testing**: Testing the communication boundary between the `POST /api/courses/` controller and the PostgreSQL database to ensure a valid payload properly writes a new record into the database table.
*   **System Testing**: Executing a complete end-to-end API flow where an automated script sends an HTTP request, checks for an isolated `201 Created` response code, and verifies that systemic parameters (like auto-incrementing primary IDs) match downstream expectations.
*   **User Acceptance Testing (UAT)**: A college administrator logs into the system front-end interface to confirm that the course creation dashboard behaves correctly according to daily operational administration workflows.

### 2. Functional vs. Non-Functional Classification
*   The four test cases above are **Functional Testing** because they validate *what* the system does and verify that the features meet baseline specifications.
*   **Non-Functional Test Case Example (Performance)**: Executing a load test using a tool like Locust to run `100 concurrent users` invoking `GET /api/courses/` simultaneously, verifying that the system latency remains under `500ms` and system resource utilization remains stable.

### 3. Black-Box vs. White-Box Testing
*   **Black-Box Testing**: Software testing executed entirely from the outside without checking the underlying code structure, internal variables, or logic statements. Typically performed by a **QA Automation/Manual Tester**.
*   **White-Box Testing**: Structural testing that analyzes the code logic, control flows, loop conditions, and statement coverage metrics inside the application. Typically performed by a **Software Developer**.

### 4. Formal Test Cases for POST /api/courses/ Endpoint

| Test Case ID | Description | Preconditions | Test Steps | Expected Result | Actual Result | Pass/Fail |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **TC_POST_001** | Create a course with valid parameters | API is reachable; authentication token is valid | 1. Send POST to `/api/courses/` with JSON body `{"code": "CS101", "name": "Intro to Python"}` | HTTP status `201 Created` returned; JSON response mirrors course data with assigned ID | | |
| **TC_POST_002** | Reject duplicate course code entry | Course `CS101` already exists in the database records | 1. Send POST to `/api/courses/` with payload trying to recreate `CS101` code | HTTP status `400 Bad Request` returned; Error text states code must be unique | | |
| **TC_POST_003** | Validate payload missing required name field | API service is up and running normally | 1. Send POST to `/api/courses/` with payload `{"code": "CS102"}` (omitting name) | HTTP status `400 Bad Request` returned; Validation error identifies missing name field | | |

---

## Task 2: Defect Lifecycle & Severity Classification

### 5. Defect Lifecycle Text Flow Execution Description
The operational sequence of a defect report follows this systematic trajectory:
*   **New**: A problem is discovered by a tester and logged formally.
*   **Assigned**: Assigned directly to a development lead for review.
*   **Open**: Development lead analyzes the issue and confirms it is a valid bug.
*   **Fixed**: The developer changes the code and pushes a patch build.
*   **Retest**: The QA tester runs specific test scripts against the patch build to verify the fix.
*   **Verified**: Tester confirms that the defect no longer replicates.
*   **Closed**: The bug lifecycle terminates completely.

**Alternative Pathways:**
*   **Rejected**: If a developer proves the behavior matches design rules, the workflow routes from *Open → Rejected → Closed*.
*   **Deferred**: If a fix is postponed to a subsequent release due to priority scheduling, the path changes from *Open → Deferred*.

### 6. Bug Classifications and Justifications
*   **a) POST /api/courses/ returns 500 Error for all requests**
    *   *Severity*: **Critical** | *Priority*: **P1**
    *   *Justification*: Core API engine is entirely broken. Blocks all downstream operations and presents a system crash state.
*   **b) Course names longer than 150 characters are silently truncated**
    *   *Severity*: **Medium** | *Priority*: **P2**
    *   *Justification*: Causes data corruption without notifying the application client, but basic operations still execute.
*   **c) The /docs Swagger page has a typo in the API description**
    *   *Severity*: **Low** | *Priority*: **P4**
    *   *Justification*: Isolated cosmetic typo. Zero operational risk or programmatic impact on API mechanics.
*   **d) Login intermittently returns a 401 Unauthorized error on first attempt**
    *   *Severity*: **High** | *Priority*: **P2**
    *   *Justification*: Intermittent failure in authenticating users indicates authentication layer instability. Requires near-term isolation.

### 7. Formal Defect Report (Bug A)
*   **Defect ID**: DEF_POST_001
*   **Title**: POST /api/courses/ returns 500 Internal Server Error for valid creation payloads
*   **Environment**: Staging API Server Environment
*   **Build Version**: v5.0.4-QA
*   **Severity**: Critical
*   **Priority**: P1
*   **Steps to Reproduce**:
    1. Authenticate user to acquire a valid authorization bearer token.
    2. Construct a standard HTTP POST request directed toward `/api/courses/`.
    3. Pass payload data body containing valid `code` and `name` attributes.
    4. Send the request.
*   **Expected Result**: System returns `201 Created` status code and generates a tracking sequence ID.
*   **Actual Result**: Application service returns a `500 Internal Server Error` exception message.
*   **Attachments**: screenshot of 500 error logs

### 8. Difference Between Severity and Priority
*   **Severity**: Measures the technical impact of a bug on the application's runtime stability.
*   **Priority**: Measures the business urgency for scheduling and executing a bug fix.
*   *Real-World Example (High Severity, Low Priority)*: A legacy data processing script crashes completely with an unhandled exception (High Severity) whenever it processes an obscure format that the company officially deprecated two years ago and no current clients use (Low Priority).
