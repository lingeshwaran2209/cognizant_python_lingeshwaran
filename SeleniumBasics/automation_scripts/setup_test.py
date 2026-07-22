""" HANDSON_4 """
import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

def run_hands_on_4():
    # --- TASK 1: SETUP HEADLESS CHROME WEBDRIVER ---
    print("\n--- Starting Hands-On 4 Execution ---")
    chrome_options = Options()
    chrome_options.add_argument('--headless')  # Run in headless mode (no visible GUI window)
    chrome_options.add_argument('--disable-gpu')
    
    # Initialize driver with auto-managed ChromeDriver binaries via webdriver-manager
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=chrome_options)
    
    # Global implicit wait configuration (Bad practice noted above)
    driver.implicitly_wait(10)
    
    try:
        # --- TASK 2: WEBDRIVER NAVIGATION AND WINDOW COMMANDS ---
        # 1. Open the Selenium Playground site
        print("Navigating to LambdaTest Playground...")
        driver.get("https://lambdatest.com")
        
        # Print original page title
        print(f"Original Page Title: {driver.title}")
        
        # 2. Window size metrics tracking
        print(f"Default window size: {driver.get_window_size()}")
        driver.set_window_size(1280, 800)
        print(f"Enforced uniform window size: {driver.get_window_size()}")
        
        # 3. Simulate deep path URL validation via a direct page hit
        print("Navigating directly to Simple Form Demo page...")
        driver.get("https://lambdatest.comsimple-form-demo")
        
        # Assert target URL pattern matches expectations
        assert "simple-form-demo" in driver.current_url, f"URL Check Failed: {driver.current_url}"
        print(f"Assertion passed! Verified URL path contains substring: 'simple-form-demo'")
        
        # Navigate backward in runtime sequence history
        driver.back()
        print(f"Executed driver.back(). Returned to URL: {driver.current_url}")
        
        # 4. Open a secondary browser tab using JavaScript execution context
        print("Executing script context window injection to open Google...")
        driver.execute_script('window.open("https://google.com");')
        
        # Extract and verify tab tracking lists
        all_handles = driver.window_handles
        print(f"Detected open tab handles: {all_handles}")
        
        # Switch focus to the secondary tab index
        driver.switch_to.window(all_handles[1])
        print(f"Switched focus to second window tab. Title: {driver.title}")
        
        # Switch focus back to primary tab sequence index
        driver.switch_to.window(all_handles[0])
        print("Switched focus back to base playground window.")
        
        # 5. Capture runtime screen evidence to disk
        screenshot_filename = 'playground_screenshot.png'
        driver.save_screenshot(screenshot_filename)
        
        # Confirm creation block
        if os.path.exists(screenshot_filename):
            print(f"Success! Captured file evidence successfully saved to: {os.path.abspath(screenshot_filename)}")
        else:
            print("Error: Failure to record screenshot to filesystem location.")
            
    finally:
        # Gracefully terminate all active browser runtime driver windows
        print("Executing driver.quit(). Terminating processes...")
        driver.quit()
        print("--- Hands-On 4 Execution Completed Successfully ---\n")

if __name__ == "__main__":
    run_hands_on_4()
