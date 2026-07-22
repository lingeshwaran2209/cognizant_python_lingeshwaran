from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from pages.base_page import BasePage

class DropdownPage(BasePage):
    SELECT_DROPDOWN = (By.CSS_SELECTOR, "select#select-demo")
    SELECTED_TEXT = (By.CSS_SELECTOR, "p.selected-value")

    def select_day(self, day_name):
        select_element = self.find_element(self.SELECT_DROPDOWN)
        Select(select_element).select_by_visible_text(day_name)

    def get_selected_day_text(self):
        return self.find_element(self.SELECTED_TEXT).text
