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

helm-qa:
	$(helm) lint --strict $(HELM_DIR)

