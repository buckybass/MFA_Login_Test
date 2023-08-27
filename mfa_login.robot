*** Settings ***
Library    SeleniumLibrary
Library    totp.py  

*** Variables ***
${BROWSER}    chrome

*** Test Cases ***
Login Pass And OTP Pass
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=username    demo_user
    Input Text    id=password    secret_pass
    ${totp}    get_totp    GAXG2MTEOR3DMMDG
    Input Text    id=totpcode     ${totp}
    Click Element    id=log-in
    Wait Until Page Contains    Welcome!

Login Pass And OTP Fail
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=username    demo_user
    Input Text    id=password    secret_pass
    ${totp}    Get Totp    JBSWY3DPEHPK3PXP
    Input Text    id=totpcode     ${totp}
    Click Element    id=log-in
    Wait Until Page Contains    Invalid MFA Code!

Login Username Wrong
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=username    demo_user2
    Input Text    id=password    secret_pass
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Input Text    id=totpcode     ${totp}
    Click Element    id=log-in
    Wait Until Page Contains    Invalid Username!

Login Password Wrong
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=username    demo_user
    Input Text    id=password    secret_passa
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Input Text    id=totpcode     ${totp}
    Click Element    id=log-in
    Wait Until Page Contains    Invalid Password!

Login Without Username
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=password    secret_pass
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Input Text    id=totpcode     ${totp}
    Click Element    id=log-in
    Wait Until Page Contains    The Username is Required!

Login Without Password
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=username    demo_user
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Input Text    id=totpcode     ${totp}
    Click Element    id=log-in
    Wait Until Page Contains    The Password is Required!

Login Without OTP
    Open Browser    https://seleniumbase.io/realworld/login    browser=${BROWSER}
    Input Text    id=username    demo_user
    Input Text    id=password    secret_pass
    Click Element    id=log-in
    Wait Until Page Contains    The MFA Code is Required!
