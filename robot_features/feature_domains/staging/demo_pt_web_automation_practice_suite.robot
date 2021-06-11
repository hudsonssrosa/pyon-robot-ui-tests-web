*** Settings ***
Documentation           ATDD formal para o website Automation Practice.
...                     Usando estilo Gherkin
Library                 Selenium2Library

*** Variables ***
# Dados do teste
${BROWSER}              Chrome
${url}                  http://automationpractice.com/index.php
${nome_produto}         Blouse

# Localizadores
${elm_text_busca}       xpath=//*[@id="search_query_top"]
${elm_button_busca}     xpath=//*[@id="searchbox"]/button
${elm_label_produto}    xpath=//*[@id="center_column"]/ul/li/div/div[2]/h5/a

*** Test Cases ***
Cenário: TC-0001 Usuário busca um produto específico
    Dado que o navegador é aberto e maximizado para o website Automation Practice
    Quando o usuário digita "Blouse" no campo de busca
    E clica no botão de pesquisa
    Entao o produto é encontrado nos resultados
    [Teardown]                                                                       Close Browser

*** Keywords ***
Dado que o navegador é aberto e maximizado para o website Automation Practice
    Open Browser                                                                     ${url}                  browser=${BROWSER}
    Maximize Browser Window
Quando o usuário digita "Blouse" no campo de busca
    Input text                                                                       ${elm_text_busca}       ${nome_produto}
E clica no botão de pesquisa
    Click Button                                                                     ${elm_button_busca}
    Press Keys                                                                       ${elm_button_busca}     \\34
Entao o produto é encontrado nos resultados
    Wait Until Element Contains                                                      ${elm_label_produto}    ${nome_produto}
