include .env

push:
	scp exports/*.apk $(WEB_USER)@$(URL):$(APK_PATH)
