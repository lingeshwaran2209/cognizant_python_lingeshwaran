from selenium.webdriver.common.by import By
from pages.base_page import BasePage

class SimpleFormPage(BasePage):
    # Locators managed centrally as class-level tuples
    MESSAGE_INPUT = (By.ID, "user-message")
    SUBMIT_BUTTON = (By.ID, "showInput")
    DISPLAYED_MESSAGE = (By.ID, "message")

    def enter_message(self, text):
        self.find_element(self.MESSAGE_INPUT).send_keys(text)

    def click_submit(self):
        self.find_element(self.SUBMIT_BUTTON).click()

    def get_displayed_message(self):
        return self.wait_for_element(self.DISPLAYED_MESSAGE).text
