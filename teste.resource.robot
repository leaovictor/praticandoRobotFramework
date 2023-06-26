*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${ofertas_do_dia}            //a[contains(text(),'Ofertas do Dia')]



*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    Close Browser


Acessar a home page do site Amazon.com.br
    Go To    https://www.amazon.com.br/

Entrar no menu "Ofertas do Dia"
    Wait Until Element Is Visible    ${ofertas_do_dia}
    Click Element    ${ofertas_do_dia}

Verificar se o título da página fica "Ofertas e Promoções | Amazon.com.br"
    Wait Until Element Is Visible    //h1[contains(text(),'Ofertas e Promoções')]
    ${title}    Get Title
    [return]     Ofertas e Promoções | Amazon.com.br
    Should Be Equal As Strings    ${title}    Ofertas e Promoções | Amazon.com.br

Verificar se aparece a frase "Ofertas e Promoções"
    Page Should Contain    Ofertas e Promoções

Verificar se aparece a categoria "Dispositivos Amazon e Acessórios"
    Page Should Contain    Dispositivos Amazon e Acessórios
    

Digitar o nome de produto "Alexa" no campo de pesquisa
    [Arguments]    ${product_name}
    Input Text    //input[@id='twotabsearchtextbox']        ${product_name}
    

Clicar no botão de pesquisa
    Click Element    nav-search-submit-button


Verificar o resultado da pesquisa se está listando o produto pesquisado 
    [Arguments]    ${product_name}
    Wait Until Page Contains Element    xpath=//span[@class='a-size-base-plus a-color-base a-text-normal' and contains(text(), '${product_name}')]
    Page Should Contain Element    xpath=//span[@class='a-size-base-plus a-color-base a-text-normal' and contains(text(), 'Echo Dot')]