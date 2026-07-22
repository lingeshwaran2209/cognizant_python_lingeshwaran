# Handson-3

## Task 1: Automation Decision and Test Case Selection

### 1. 5 Automation Decision Criteria Applied to POST /api/courses/
*   **High Repetition**: The endpoint is executed continuously during every regression and smoke test run.
*   **Business Risk**: Course creation is a critical operation; its failure completely breaks downstream workflows.
*   **Determinism**: The expected results (HTTP 201 and precise JSON validation) are strictly predictable and binary.
*   **Data-Driven Potential**: The test requires validation against multiple input datasets (valid data variations, boundaries).
*   **Technical Feasibility**: The API uses standard JSON payloads over HTTP, which are straightforward to automate via standard libraries.
*   *Application*: The scenario **should be automated** because it fulfills all 5 criteria perfectly.

### 2. Test Case Selection Matrix
*   **(a) Regression test for all CRUD endpoints after every code change**
    *   *Decision*: **Automate**
    *   *Justification*: High frequency, repetitive, and critical for catching unexpected breaking changes.
*   **(b) Exploratory testing of a new search feature**
    *   *Decision*: **Manual**
    *   *Justification*: Requires human intuition, creativity, and ad-hoc learning which cannot be scripted.
*   **(c) Performance test: 100 concurrent users calling GET /api/courses/**
    *   *Decision*: **Automate**
    *   *Justification*: Impossible to simulate 100 concurrent users manually with accuracy.
*   **(d) UI test for the login form**
    *   *Decision*: **Automate**
    *   *Justification*: Core authentication pathway that must remain unbroken across all system releases.
*   **(e) Verify the API documentation (Swagger) is accurate**
    *   *Decision*: **Manual**
    *   *Justification*: A one-time or low-frequency visual inspection task that changes rarely.
*   **(f) Smoke test: verify the API is reachable after deployment**
    *   *Decision*: **Automate**
    *   *Justification*: Lightweight, frequent check that provides immediate feedback on environment health.

### 3. Test Automation ROI Calculation
*   **Definition**: Return on Investment (ROI) measures the net savings in time or cost achieved by switching from manual execution to automated verification.
*   **Calculation Parameters**:
    *   Initial Automation Creation Cost = 4 hours (240 minutes)
    *   Manual Execution Cost Per Run = 30 minutes
*   **Breakeven Analysis**:
    *   \(\text{Breakeven Runs} = \frac{\text{Initial Automation Cost}}{\text{Manual Execution Cost}} = \frac{240 \text{ minutes}}{30 \text{ minutes}} = 8 \text{ runs}\)
    *   *Conclusion*: The automation pays for itself on the **8th run**. Because 8 is less than 10, the 20% post-10th run maintenance overhead does not affect the initial breakeven point.

### 4. Flaky Test Analysis
*   **Definition**: A flaky test is an unstable test script that exhibits both passing and failing results across different runs without any underlying changes to the application code.
*   **Real-World Example**: A test fails because it tries to click a "Submit" button before the backend API responds and the front-end rendering engine finishes displaying it.
*   **3 Prevention Strategies**:
    1.  Replace all hard-coded timeouts (`time.sleep`) with explicit waits (`WebDriverWait`).
    2.  Ensure each test case handles its own data setup and teardown to prevent state pollution.
    3.  Implement reliable, unique locator strategies (such as dedicated data-test attributes) instead of brittle absolute XPaths.

---

## Task 2: Compare Automation Framework Types

### 5. Architectural Comparison Matrix

| Framework Type | One-Paragraph Description | Primary Advantage | Primary Disadvantage | Course Management Example |
| :--- | :--- | :--- | :--- | :--- |
| **Linear** | A simple procedural "record and playback" script written sequentially without modular functions. | Very fast to set up initially. | Extremely high maintenance overhead. | A single continuous script that records logging in, creating a course, and logging out. |
| **Modular** | Break down your test scripts into reusable functions or page blocks representing application modules. | High code reusability. | Requires coding structure planning. | Creating an isolated function for `login_user()` and reusing it across all test suites. |
| **Data-Driven** | Separates the test scripts from the test values by externalizing values into CSV or Excel sheets. | Tests many datasets easily. | Complex file parsing logic required. | Running one course creation script against 50 different course rows in a CSV sheet. |
| **Keyword-Driven** | Maps specific actions into string keywords (e.g., "CLICK", "TYPE") matching distinct handler code. | Non-technical users can write tests. | Extremely high initial framework setup. | Writing an Excel sheet row reading: `OPEN_BROWSER`, `TYPE \| course_input`, `CLICK \| submit_btn`. |
| **Hybrid** | Combines the features of Modular, Data-Driven, and Keyword architectures into a single framework. | Maximizes modularity and flexibility. | Steep learning curve for engineers. | A Page Object Model design patterns suite running parameterised datasets from external fixtures. |

### 6. Framework Architecture Recommendation
*   **Recommendation**: A **Hybrid Framework combining Modular (Page Object Model) and Data-Driven patterns** is the ideal solution.
*   **Justification**: 
    1.  **Data-Driven**: Easily handles testing the login mechanism across 50 distinct username/password combinations without duplicating code.
    2.  **Modular (POM)**: Isolates the login procedures into a single component class, ensuring it can be cleanly reused across all 20 dependent test cases.
    3.  **Pytest Integration**: Using descriptive fixture parameters and Gherkin step expressions allows non-technical team members to write or read test steps clearly.

### 7. Hybrid Framework Directory Structure Design
```text
course_management_tests/
│
├── config/
│   └── config.ini              # Global system variables and URLs
│
├── data/
│   └── user_credentials.csv    # 50 username and password rows
│
├── pages/                      # Page Object classes (Modular UI actions)
│   ├── base_page.py
│   ├── login_page.py
│   └── course_page.py
│
├── tests/                      # Core test files (Assertions only)
│   ├── conftest.py             # Shared pytest driver configurations
│   ├── test_login.py           # Parameterised login tests
│   └── test_courses.py         # Functional verification tests
│
└── utils/
    └── data_reader.py          # CSV/Excel parsing utility functions
```
