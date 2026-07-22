from selenium.webdriver.common.by import By
from pages.base_page import BasePage

class CheckboxPage(BasePage):
    SINGLE_CHECKBOX = (By.CSS_SELECTOR, "input#isAgeSelected")
    SUCCESS_MESSAGE = (By.CSS_SELECTOR, "div#txtAge")

    def toggle_single_checkbox(self):
        self.find_element(self.SINGLE_CHECKBOX).click()

    def is_checkbox_selected(self):
        return self.find_element(self.SINGLE_CHECKBOX).is_selected()

    def get_success_message(self):
        return self.wait_for_element(self.SUCCESS_MESSAGE).text
