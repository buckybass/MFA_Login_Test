*** Settings ***
Library    Browser
Library    totp.py  
Suite Setup    Open Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup    New Context
Test Teardown    Close Context
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    False

*** Test Cases ***
Login Pass And OTP Pass
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=username    demo_user
    Fill Text    id=password    secret_pass
    ${totp}    get_totp    GAXG2MTEOR3DMMDG  # เปลี่ยนชื่อฟังก์ชันจาก Get Totp เป็น get_totp
    Fill Text    id=totpcode     ${totp}
    Click    "Sign in"
    Browser.Get Text  h1  ==  Welcome!

Login Pass And OTP Fail
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=username    demo_user
    Fill Text    id=password    secret_pass
    ${totp}    Get Totp    JBSWY3DPEHPK3PXP
    Fill Text    id=totpcode     ${totp}
    Click    "Sign in"
    ${top_message}    Browser.Get Text    xpath=//*[@id="top_message"]
    Should Be Equal As Strings    ${top_message}    Invalid MFA Code!

Login Username Wrong
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=username    demo_user2
    Fill Text    id=password    secret_pass
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Fill Text    id=totpcode     ${totp}
    Click    "Sign in"
    ${top_message}    Browser.Get Text    xpath=//*[@id="top_message"]
    Should Be Equal As Strings    ${top_message}    Invalid Username!

Login Password Wrong
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=username    demo_user
    Fill Text    id=password    secret_passa
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Fill Text    id=totpcode     ${totp}
    Click    "Sign in"
    ${top_message}    Browser.Get Text    xpath=//*[@id="top_message"]
    Should Be Equal As Strings    ${top_message}    Invalid Password!

Login Without Username
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=password    secret_pass
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Fill Text    id=totpcode     ${totp}
    Click    "Sign in"
    ${top_message}    Browser.Get Text    xpath=//*[@id="top_message"]
    Should Be Equal As Strings    ${top_message}    The Username is Required!

Login Without Password
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=username    demo_user
    ${totp}    Get Totp    GAXG2MTEOR3DMMDG
    Fill Text    id=totpcode     ${totp}
    Click    "Sign in"
    ${top_message}    Browser.Get Text    xpath=//*[@id="top_message"]
    Should Be Equal As Strings    ${top_message}    The Password is Required!

Login Without OTP
    New Page    https://seleniumbase.io/realworld/login
    Fill Text    id=username    demo_user
    Fill Text    id=password    secret_pass
    Click    "Sign in"
    ${top_message}    Browser.Get Text    xpath=//*[@id="top_message"]
    Should Be Equal As Strings    ${top_message}    The MFA Code is Required!
