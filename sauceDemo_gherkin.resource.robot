*** Settings ***
Library   SeleniumLibrary


*** Variables ***
${USER}                      id=user-name
${PASSWORD}                  id=password

*** Keywords ***

Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    # Capture Page Screenshot
    Close Browser


I am on the login page
    Go To    url=https://saucedemo.com/
I enter valid username and password
    Wait Until Element Is Visible    ${USER}
    Wait Until Element Is Visible    ${PASSWORD}
    Input Text                       ${USER}    standard_user
    Input Text                       ${PASSWORD}    secret_sauce
And I click on the "Login" button
    Click Button    id=login-button
I should be redirected to the main page as an authenticated user
    ${header_text}=    Get Text    xpath=//div[@id='header_container']/div[2]/span 
    Should Be Equal    ${header_text}    Products

I enter invalid username and/or password
    Wait Until Element Is Visible    ${USER}
    Wait Until Element Is Visible    ${PASSWORD}
    Input Text                       ${USER}    standart_user
    Input Text                       ${PASSWORD}    secret_sauce
I click on the "Login" button
I should receive an error message indicating login failure
    ${erro_message}    Get Text      xpath=//div[@id='login_button_container']/div/form/div[3]/h3
    Should Be Equal    ${erro_message}    Epic sadface: Username and password do not match any user in this service
I should remain on the login page
    ${url}        Get Location
    Should Be Equal    ${url}    https://www.saucedemo.com/

I am logged in on the site
    I am on the login page
    I enter valid username and password
    And I click on the "Login" button
I am on the main page
    I should be redirected to the main page as an authenticated user

I select an available product
    Click Element  id=add-to-cart-sauce-labs-backpack

I click on the "Add to Cart" button
    Click Element  xpath=//div[@id='shopping_cart_container']/a/span

The product should be added to my shopping cart
    Page Should Contain     Sauce Labs Backpack

The shopping cart icon should display the correct number of items
    Element Text Should Be  xpath=//div[@id='cart_contents_container']/div/div/div[3]/div  1

I select an unavailable product
    Click Element  unavailable_product

I should receive a message indicating that the product is not available to add to the cart
    Page Should Contain  product_unavailable_message

The product should not be added to my shopping cart
    Page Should Not Contain  shopping_cart_product