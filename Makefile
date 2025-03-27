# Makefile for deploying Flutter web projects to GitHub

BASE_HREF = /$(OUTPUT)/
GITHUB_USER = horlann
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT).git
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

# Check if OUTPUT is set before running deploy
ifndef OUTPUT
$(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif

.PHONY: deploy

deploy:
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Deployment finished: $(GITHUB_REPO)"
	@echo "🌐 View your site: https://$(GITHUB_USER).github.io/$(OUTPUT)/"
