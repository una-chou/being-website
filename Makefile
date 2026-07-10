# being-website 前端部署
# 用法：make

SERVER_HOST ?= 140.143.171.29
SERVER_USER ?= ubuntu
SSH_TARGET := $(SERVER_USER)@$(SERVER_HOST)

DIST_DIR ?= dist
REMOTE_TMP_DIR ?= /tmp/being-website-dist
REMOTE_WEB_ROOT ?= /var/www/being-website
PUBLIC_URL ?= http://$(SERVER_HOST)/

NPM ?= npm
SSH ?= ssh
SCP ?= scp
CURL ?= curl

.PHONY: all deploy build remote sync health_check clean dev preview help check-remote

all: build remote sync ## 本地打包、上传服务器、同步到 Nginx 目录

deploy: all ## 同 all

dev: ## 启动本地开发服务
	$(NPM) run dev

build: ## 本地打包 dist/
	$(NPM) run build

remote: check-remote ## 上传 dist/ 到服务器临时目录
	@test -d $(DIST_DIR) || (echo "缺少 $(DIST_DIR)，请先执行 make build" && exit 1)
	$(SSH) $(SSH_TARGET) 'rm -rf $(REMOTE_TMP_DIR) && mkdir -p $(REMOTE_TMP_DIR)'
	$(SCP) -r $(DIST_DIR)/* $(SSH_TARGET):$(REMOTE_TMP_DIR)/

sync: check-remote ## 同步临时目录到 Nginx 静态目录
	$(SSH) -t $(SSH_TARGET) 'sudo mkdir -p $(REMOTE_WEB_ROOT) && sudo rm -rf $(REMOTE_WEB_ROOT)/* && sudo cp -a $(REMOTE_TMP_DIR)/. $(REMOTE_WEB_ROOT)/'

health_check: check-remote ## 检查公网访问
	$(CURL) -fsS $(PUBLIC_URL) >/dev/null
	@echo "✓ 前端访问正常：$(PUBLIC_URL)"

clean: ## 清理本地构建产物
	rm -rf $(DIST_DIR)

preview: ## 本地预览 dist/
	$(NPM) run preview

check-remote:
	@test -n "$(SERVER_HOST)" || (echo "请执行：make SERVER_HOST=你的服务器公网IP" && exit 1)

help: ## 显示命令列表
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'
