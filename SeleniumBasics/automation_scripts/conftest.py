import pytest
import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

@pytest.fixture(scope="session")
def base_url():
    """Provides a session-scoped base URL configuration constant."""
    return "https://lambdatest.com"

@pytest.fixture(scope="function")
def driver():
    """Initializes a fresh headless Chrome browser session for each test case and performs clean teardown."""
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--disable-gpu')
    chrome_options.add_argument('--window-size=1280,800')
    
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=chrome_options)
    
    yield driver  # Injects the driver session instance into the requesting test functions
    
    driver.quit()  # Teardown: Safely closes the browser processes after the test function finishes

@pytest.hookimpl(tryfirst=True, hookwrapper=True)
def pytest_runtest_makereport(item, call):
    """Listens across execution states and automatically captures a screenshot if a test failure occurs."""
    outcome = yield
    report = outcome.get_result()
    
    if report.when == "call" and report.failed:
        # Check if the test function has access to the driver fixture instance
        if "driver" in item.fixturenames:
            driver_instance = item.funcargs["driver"]
            test_name = item.name.replace("[", "_").replace("]", "_")
            screenshot_path = f"{test_name}_failure.png"
            driver_instance.save_screenshot(screenshot_path)
            print(f"\n[FAILURE HOOK] Test failed! Screenshot evidence saved to: {os.path.abspath(screenshot_path)}")
