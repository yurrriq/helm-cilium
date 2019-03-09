# Tryin' real hard not to depend on https://gmsl.sourceforge.io/
# See the README.md
# TODO: Check https://www.gnu.org/software/make/manual/html_node/Special-Variables.html#Special-Variables
# .RECIPEPREFIX := | w00t!
#
##-------- INIT VARS --------##
# Don't echo commands unless $DEBUG
$(DEBUG).SILENT:

# Execute everything in a single shell
.ONESHELL:

# Delete the default suffixes & rules (make -d)
.SUFFIXES:
%: %,v
%: RCS/%,v
%: RCS/%
%: s.%
%: SCCS/s.%

##-------- HELM & KUBE STUFFS --------##
.PHONY: helm kubectl helm-init helm-vendor helm-clean helm-qa helm-push hf-qa
helm := DEBUG= helm $(if $(DEBUG),--debug)
helmfile := DEBUG= K8S_NS=$(K8S_NS) K8S_CTX=$(K8S_CTX) HELM_USER=$(HELM_USER) HELM_PASSWORD=$(HELM_PASSWORD) helmfile $(if $(DEBUG),--log-level debug)
kubectl := kubectl $(if $(DEBUG),--v=6)

name ?= $(K8S_NS)-$*
chart ?= stable/$*
values ?= $(HELM_VALUES)/$*.yml
_helm-%:
	$(helm) upgrade --install \
	  --namespace $(K8S_NS) \
	  --values $(values) \
	  $(if $(DRY_RUN),--dry-run)  \
	  $(name) \
	  $(chart)

helm-clean:
	rm -rf $(HELM_DIR)/charts $(HELM_DIR)/requirements.lock

helm-qa:
	$(helm) lint --strict $(HELM_DIR)

helm-push:
	if [ -z "`helm repo list | grep -E '$(HELM_REPO_NAME)[[:space:]]+$(HELM_REPO)'`" ]; then
		$(helm) repo add --password $(HELM_PASSWORD) --username $(HELM_USER) $(HELM_REPO_NAME) $(HELM_REPO)
	fi
	$(helm) push $(if $(FORCE), --force) $(HELM_DIR) $(HELM_REPO_NAME)

helm-init:
	$(helm) init --client-only
	$(helm) plugin install https://github.com/chartmuseum/helm-push
	$(helm) plugin install https://github.com/futuresimple/helm-secrets
	$(helm) plugin install https://github.com/databus23/helm-diff --version master
	# Helm 2.11: doesnt check if it's actually an update
	$(helm) plugin update push
	$(helm) plugin update secrets
	$(helm) plugin update diff
