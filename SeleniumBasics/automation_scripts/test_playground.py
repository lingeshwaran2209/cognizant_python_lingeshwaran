import pytest
import sys
import os

# Append current folder to path to allow seamless pages package lookup executions
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from pages.simple_form_page import SimpleFormPage
from pages.checkbox_page import CheckboxPage
from pages.dropdown_page import DropdownPage
from pages.input_form_page import InputFormPage

def test_pom_simple_form(driver, base_url):
    form_page = SimpleFormPage(driver)
    form_page.navigate_to(f"{base_url}simple-form-demo")
    
    message = "Hello POM Architecture"
    form_page.enter_message(message)
    form_page.click_submit()
    
    assert form_page.get_displayed_message() == message

def test_pom_checkbox(driver, base_url):
    checkbox_page = CheckboxPage(driver)
    checkbox_page.navigate_to(f"{base_url}checkbox-demo")
    
    assert not checkbox_page.is_checkbox_selected()
    checkbox_page.toggle_single_checkbox()
    assert checkbox_page.is_checkbox_selected()
    assert "success" in checkbox_page.get_success_message().lower()

def test_pom_dropdown(driver, base_url):
    dropdown_page = DropdownPage(driver)
    dropdown_page.navigate_to(f"{base_url}select-dropdown-demo")
    
    dropdown_page.select_day("Wednesday")
    assert "Wednesday" in dropdown_page.get_selected_day_text()

def test_pom_input_form_submit(driver, base_url):
    form_page = InputFormPage(driver)
    form_page.navigate_to(f"{base_url}input-form-demo")
    
    form_page.fill_form(
        name="John Doe", email="john@example.com", password="SecurePassword123",
        company="Cognizant", website="https://cognizant.com", city="Chennai",
        address1="123 Tech Park", address2="Ondipudur", state="Tamil Nadu", zip_code="600001"
    )
    form_page.submit_form()
    
    assert "thanks for contacting us" in form_page.get_success_message().lower()
