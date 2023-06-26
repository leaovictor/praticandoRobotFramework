*** Settings ***
Documentation    Essa suite testa o site da Amazon.com.br
Resource         teste.resource.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador


*** Test Cases ***
Caso de teste 01 - Acesso ao menu "Ofertas do Dia"
    [Documentation]    Esse teste verifica o menu Ofertas do Dia do site da Amazon.com.br
    ...                e verifica a categoria Computadores e Informática
    [Tags]             menus    categorias
    Acessar a home page do site Amazon.com.br
    Entrar no menu "Ofertas do Dia"
    Verificar se o título da página fica "Ofertas e Promoções | Amazon.com.br"
    Verificar se aparece a frase "Ofertas e Promoções"
    Verificar se aparece a categoria "Dispositivos Amazon e Acessórios"

Caso de Teste 02 - Pesquisa de um produto
    [Documentation]    Esse teste verifica a busca de um produto
    [Tags]             busca_produtos    lista_busca
    Acessar a home page do site Amazon.com.br
    Digitar o nome de produto "Alexa" no campo de pesquisa    Alexa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto pesquisado    Echo Dot


