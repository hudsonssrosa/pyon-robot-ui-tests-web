*** Settings ***
Documentation           Formal ATDD for Automation Practice website.
...                     Using a single Gherkin style
Library                 Selenium2Library

*** Variables ***
# Test Data
${BROWSER}              Chrome
${url}                  http://automationpractice.com/index.php
${product_name}         Blouse

# Locators
${elm_text_search}      xpath=//*[@id="search_query_top"]
${elm_button_search}    xpath=//*[@id="searchbox"]/button
${elm_label_product}    xpath=//*[@id="center_column"]/ul/li/div/div[2]/h5/a

*** Test Cases ***
Scenario: TC-0001 User can search a specific product
    Given browser is opened and maximized to Automation Practice website
    When user types "Blouse" in the search field
    And clicks in the search button
    Then the product is found in the results
    [Teardown]                                                              Close Browser

*** Keywords ***
Given browser is opened and maximized to Automation Practice website
    Open Browser                                                            ${url}                  browser=${BROWSER}
    Maximize Browser Window
When user types "${nome_produto}" in the search field
    Input text                                                              ${elm_text_search}      ${product_name}
And clicks in the search button
    Click Button                                                            ${elm_button_search}
    Press Keys                                                              ${elm_button_search}    \\34
Then the product is found in the results
    Wait Until Element Contains                                             ${elm_label_product}    ${product_name}
