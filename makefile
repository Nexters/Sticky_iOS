GREEN=\n\033[1;32;40m
RED=\n\033[1;31;40m
NC=\033[0m # No Color

# OS_VERSION 환경변수 등록 필수
SWIFTLINT = $(shell command -v swiftlint)

lint:
ifndef SWIFTLINT
	./install_swiftlint.sh
endif
	swiftlint
.PHONY: lint

XCPRETTY = $(shell command -v xcpretty)
PROJECT_NAME = Sticky
# WORKSPACE = $(shell find . -name "project.xcworkspace")
WORKSPACE = Sticky.xcworkspace
EMULATOR = iPhone 12 mini

OS_VERSION = $(shell xcodebuild -showsdks | egrep "iOS (\d)+.(\d)+" | head -1 | cut -f2 -d" ")
build:
ifndef XCPRETTY
	$(error xcpretty를 설치하세요)
endif
	set -o pipefail && xcodebuild \
	-workspace ${WORKSPACE} \
	-configuration Debug \
	-scheme ${PROJECT_NAME} \
	-destination 'platform=iOS Simulator,OS=${OS_VERSION},name=${EMULATOR}' \
	-enableCodeCoverage YES \
	build test \
	CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=YES | xcpretty
.PHONY: build

test:
ifndef XCPRETTY
	$(error xcpretty를 설치하세요)
endif
	xcodebuild \
	-workspace ${WORKSPACE} \
	-configuration Debug \
	-scheme ${PROJECT_NAME} \
	-destination 'platform=iOS Simulator,OS=${OS_VERSION},name=${EMULATOR}' \
	-enableCodeCoverage YES \
	test \
	CODE_SIGN_IDENTITY="" \
	CODE_SIGNING_REQUIRED=NO \
	ONLY_ACTIVE_ARCH=NO | xcpretty
.PHONY: test

release:
	sed -i ".bak" "s/MARKETING_VERSION = .*/MARKETING_VERSION = $(shell npx next-standard-version);/g" ${PROJECT_NAME}.xcodeproj/project.pbxproj
	sed -i ".bak" "s/CURRENT_PROJECT_VERSION = .*/CURRENT_PROJECT_VERSION = ${GITHUB_RUN_NUMBER};/g" ${PROJECT_NAME}.xcodeproj/project.pbxproj
.PHONY: release

# 마지막 tag로부터 현재까지의 changelog 및 버전 확인 용
current_changelog:
	@/bin/sh -c "echo \"${GREEN}[release version] $(shell npx next-standard-version)${NC}\""
	@/bin/sh -c "echo \"${GREEN}[description] ${NC}\""
	@npx standard-version --dry-run --silent | grep -v Done | grep -v "\-\-\-" | grep -v standard-version
.PHONY: current_changelog
