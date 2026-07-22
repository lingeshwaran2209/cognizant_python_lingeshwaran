from selenium.webdriver.common.by import By
from pages.base_page import BasePage

class InputFormPage(BasePage):
    # Form input locators matching the Input Form Submit practice page
    NAME_FIELD = (By.NAME, "name")
    EMAIL_FIELD = (By.ID, "inputEmail4")
    PASSWORD_FIELD = (By.ID, "inputPassword4")
    COMPANY_FIELD = (By.NAME, "company")
    WEBSITE_FIELD = (By.NAME, "website")
    CITY_FIELD = (By.ID, "inputCity")
    ADDRESS1_FIELD = (By.ID, "inputAddress1")
    ADDRESS2_FIELD = (By.ID, "inputAddress2")
    STATE_FIELD = (By.ID, "inputState")
    ZIP_FIELD = (By.ID, "inputZip")
    SUBMIT_BUTTON = (By.XPATH, "//button[text()='Submit']")
    SUCCESS_MSG = (By.CSS_SELECTOR, ".success-msg")

    def fill_form(self, name, email, password, company, website, city, address1, address2, state, zip_code):
        self.find_element(self.NAME_FIELD).send_keys(name)
        self.find_element(self.EMAIL_FIELD).send_keys(email)
        self.find_element(self.PASSWORD_FIELD).send_keys(password)
        self.find_element(self.COMPANY_FIELD).send_keys(company)
        self.find_element(self.WEBSITE_FIELD).send_keys(website)
        self.find_element(self.CITY_FIELD).send_keys(city)
        self.find_element(self.ADDRESS1_FIELD).send_keys(address1)
        self.find_element(self.ADDRESS2_FIELD).send_keys(address2)
        self.find_element(self.STATE_FIELD).send_keys(state)
        self.find_element(self.ZIP_FIELD).send_keys(zip_code)

    def submit_form(self):
        self.find_element(self.SUBMIT_BUTTON).click()

    def get_success_message(self):
        return self.wait_for_element(self.SUCCESS_MSG).text
