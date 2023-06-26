*** Settings ***
Documentation    Essa suite testa o site da Amazon.com.br
Resource         sauceDemo_gherkin.resource.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***
Login com sucesso
    [Documentation]  Login no site com sucesso
    Given I am on the login page
    When I enter valid username and password
    And I click on the "Login" button
    Then I should be redirected to the main page as an authenticated user

Tentativa de login inválida
    [Documentation]  Tentativa de login inválido
    Given I am on the login page
    When I enter invalid username and/or password
    And I click on the "Login" button
    Then I should receive an error message indicating login failure
    And I should remain on the login page

Adicionar produto ao carrinho com sucesso
    [Documentation]  Adicionar produto ao carrinho com sucesso
    Given I am logged in on the site
    And I am on the main page
    When I select an available product
    And I click on the "Add to Cart" button
    Then the product should be added to my shopping cart
    And the shopping cart icon should display the correct number of items

# Tentativa de adicionar produto indisponível ao carrinho
#     [Documentation]  Tentativa de adicionar produto indisponível ao carrinho
#     Given I am logged in on the site
#     And I am on the main page
#     When I select an unavailable product
#     And I click on the "Add to Cart" button
#     Then I should receive a message indicating that the product is not available to add to the cart
#     And the product should not be added to my shopping cart

