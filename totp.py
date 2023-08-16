import pyotp


def get_totp(secret):
    totp = pyotp.TOTP(secret)
    return totp.now()


# secret = "GAXG2MTEOR3DMMDG"
# otp = get_totp(secret)
# print("OTP :", otp)
