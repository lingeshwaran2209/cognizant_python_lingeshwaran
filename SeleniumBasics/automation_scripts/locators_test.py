""" Handson-5 """

import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException
from webdriver_manager.chrome import ChromeDriverManager

def run_hands_on_5():
    print("\n--- Starting Hands-On 5 Execution ---")
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--disable-gpu')
    
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=chrome_options)
    
    try:
        # ==========================================
        # TASK 1: LOCATOR STRATEGIES DEMONSTRATION
        # ==========================================
        print("Navigating to Simple Form Demo Page...")
        driver.get("https://lambdatest.com")
        
        # 1. Demonstrate multiple strategies hitting the message text field input
        element_id     = driver.find_element(By.ID, "user-message")
        element_name   = driver.find_element(By.NAME, "message")
        element_class  = driver.find_element(By.CLASS_NAME, "form-control")
        element_tag    = driver.find_elements(By.TAG_NAME, "input")[2] # Indexing input block context
        element_rxpath = driver.find_element(By.XPATH, "//input[@id='user-message']")
        
        print("Successfully validated 5 core strategies against the text input field.")
        
        # 2. Demonstrate 3 separate CSS Selectors hitting the exact same input
        css_id        = driver.find_element(By.CSS_SELECTOR, "#user-message")
        css_attribute = driver.find_element(By.CSS_SELECTOR, "input[placeholder='Please enter your Message']")
        css_hierarchy = driver.find_element(By.CSS_SELECTOR, "div.form-group > input#user-message")
        
        print("Successfully validated 3 unique CSS Selector pattern variants.")
        
        # 3. Text-based XPath strategy on Checkbox Demo
        print("Navigating to Checkbox Demo Page...")
        driver.get("https://lambdatest.com")
        
        lbl_exact    = driver.find_element(By.XPATH, "//label[text()='Click on Checkbox to check the check box']")
        lbl_contains = driver.find_elements(By.XPATH, "//label[contains(text(),'Option')]")
        
        print(f"XPath matching completed. Located text label matches and found {len(lbl_contains)} options.")

        # ==========================================
        # TASK 2: EXPLICIT WAITS VS STATIC SLEEPS
        # ==========================================
        print("Navigating to Bootstrap Alerts page...")
        driver.get("https://lambdatest.com")
        
        btn_selector = (By.CSS_SELECTOR, "button.btn-success")
        alert_selector = (By.CSS_SELECTOR, "div.alert-success-clickable")
        
        # Wait until button is ready to click
        btn = WebDriverWait(driver, 10).until(EC.element_to_be_clickable(btn_selector))
        
        # Baseline profiling: Explicit wait benchmark
        start_wait = time.time()
        btn.click()
        alert_box = WebDriverWait(driver, 10).until(EC.visibility_of_element_located(alert_selector))
        end_wait = time.time()
        print(f"Explicit Wait performance resolving time: {end_wait - start_wait:.4f} seconds.")
        assert "successfully" in alert_box.text.lower()
        
        # Baseline profiling: Hardcoded time sleep calculation
        start_sleep = time.time()
        btn.click()
        time.sleep(3) # Anti-pattern simulation
        alert_box_sleep = driver.find_element(*alert_selector)
        end_sleep = time.time()
        print(f"Static Sleep performance forcing delay: {end_sleep - start_sleep:.4f} seconds.")

        # 4. Fluent Wait custom simulation polling framework
        print("Executing micro-polling interval simulation framework...")
        fluent_wait = WebDriverWait(driver, timeout=10, poll_frequency=0.5, ignored_exceptions=[NoSuchElementException])
        active_alert = fluent_wait.until(EC.presence_of_element_located(alert_selector))
        print("Fluent wait confirmation pattern resolved successfully.")

    finally:
        print("Terminating active browser drivers...")
        driver.quit()
        print("--- Hands-On 5 Execution Completed Successfully ---\n")

if __name__ == "__main__":
    run_hands_on_5()
