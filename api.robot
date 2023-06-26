*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    FakerLibrary    locale=pt_BR
Library    Collections
 

*** Test Cases ***
Teste de Requisição GET
    [Tags]    API
    Create Session    Example API    http://localhost:3000
    ${response}    GET On Session    Example API    /usuarios
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.text}

Teste de Requisição POST
    [Tags]    API
    Create Session    Example API    http://localhost:3000
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary    email=fulano@qa.com    password=teste
    ${response}=    POST On Session    Example API    /login    headers=${headers}    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.text}


Teste de Cadastro de Usuário
    ${NOME_FAKE}        FakerLibrary.Name
    ${EMAIL_FAKE}       FakerLibrary.Email
    ${PASSWORD_FAKE}    FakerLibrary.Password
    ${BOOLEAN_FAKE}     FakerLibrary.Boolean
    @{PESSOA}           Create List    Nome Aleatório: ${NOME_FAKE}    Email Aleatório: ${EMAIL_FAKE}
    ...    Senha Aleatória: ${PASSWORD_FAKE}
    Log Many    @{PESSOA}



    [Tags]    API
    Create Session    Example API    http://localhost:3000

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1bGFub0BxYS5jb20iLCJwYXNzd29yZCI6InRlc3RlIiwiaWF0IjoxNjg3NzE3NjM4LCJleHAiOjE2ODc3MTgyMzh9.i4B2C97ryI7movY970UbkO4XV9Od8kZSamcc-3e1K_A

    ${payload}=    Create Dictionary
    ...    nome=${NOME_FAKE}
    ...    email=${EMAIL_FAKE}
    ...    password=${PASSWORD_FAKE}
    ...    administrador=${BOOLEAN_FAKE}

    ${string_boolean}=    Run Keyword If    '${BOOLEAN_FAKE}' == 'True'    Set Variable    true    ELSE    Set Variable    false
    Set To Dictionary    ${payload}    administrador    ${string_boolean}


    ${response}=    POST On Session    Example API    /usuarios    headers=${headers}    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    201
    Log    ${response.text}



Teste de Estresse no Endpoint de Cadastro
    [Tags]    Estresse

    Create Session    Example API    http://localhost:3000

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1bGFub0BxYS5jb20iLCJwYXNzd29yZCI6InRlc3RlIiwiaWF0IjoxNjg3NzE3NjM4LCJleHAiOjE2ODc3MTgyMzh9.i4B2C97ryI7movY970UbkO4XV9Od8kZSamcc-3e1K_A

    FOR    ${i}    IN RANGE    10
        ${NOME_FAKE}=        FakerLibrary.Name
        ${EMAIL_FAKE}=       FakerLibrary.Email
        ${PASSWORD_FAKE}=    FakerLibrary.Password
        ${BOOLEAN_FAKE}=     FakerLibrary.Boolean

        ${payload}=    Create Dictionary    nome=${NOME_FAKE}    email=${EMAIL_FAKE}    password=${PASSWORD_FAKE}    administrador=${BOOLEAN_FAKE}
        ${string_boolean}=    Run Keyword If    '${BOOLEAN_FAKE}' == 'True'    Set Variable    true    ELSE    Set Variable    false
        Set To Dictionary    ${payload}    administrador    ${string_boolean}
        ${response}=    POST On Session    Example API    /usuarios    headers=${headers}    json=${payload}
        Should Be Equal As Strings    ${response.status_code}    201
        Log    ${response.text}
    END

Buscar Cadastro por ID
    [Tags]    API

    Create Session    Example API    http://localhost:3000

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZ1bGFub0BxYS5jb20iLCJwYXNzd29yZCI6InRlc3RlIiwiaWF0IjoxNjg3NzE3NjM4LCJleHAiOjE2ODc3MTgyMzh9.i4B2C97ryI7movY970UbkO4XV9Od8kZSamcc-3e1K_A

    ${response}=    GET On Session    Example API    /usuarios/ljbSXeZ2JtJGYqY6    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    ${response.text}