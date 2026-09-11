# ============================================================
# Makefile - outilsprof
# Package LaTeX d'outils pour l'enseignement
# Auteur : Jean Roussie
# ============================================================

# --- Configuration ---
PACKAGE      := outilsprof
VERSION      := 1.2
STY          := $(PACKAGE).sty
EXAMPLES_DIR := examples
EXAMPLES     := $(wildcard $(EXAMPLES_DIR)/*.tex)
EXAMPLES_PDF := $(EXAMPLES:.tex=.pdf)

# --- Détection de l'OS ---
UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
    TEXMF_HOME := $(HOME)/Library/texmf
    TEXHASH    := texhash $(TEXMF_HOME)
else
    TEXMF_HOME := $(HOME)/texmf
    TEXHASH    := mktexlsr $(TEXMF_HOME)
endif
TEXMF_DIR := $(TEXMF_HOME)/tex/latex/$(PACKAGE)

# --- Moteur LaTeX (xelatex par défaut) ---
LATEX    := xelatex
LATEXOPT := -interaction=nonstopmode -halt-on-error

# --- Commandes utilitaires ---
RM       := rm -f
MKDIR    := mkdir -p
CP       := cp
GIT      := git

# ============================================================
# Cibles principales
# ============================================================

.PHONY: all help compile clean cleanall install uninstall \
        check version tag git-commit test smoke-test ci distclean \
        compile-verbose

# --- Cible par défaut : aide ---
all: help

# --- Aide ---
help:
	@echo "Makefile pour le package $(PACKAGE) v$(VERSION)"
	@echo ""
	@echo "Cibles disponibles :"
	@echo "  make compile        Compile tous les exemples (PDF)"
	@echo "  make clean          Supprime les fichiers auxiliaires"
	@echo "  make cleanall       Supprime aussi les PDF"
	@echo "  make install        Installe le package dans TEXMF_HOME"
	@echo "  make uninstall      Désinstalle le package"
	@echo "  make check          Vérifie que le package est trouvé par TeX"
	@echo "  make version        Affiche la version du package"
	@echo "  make smoke-test     Test rapide (compile un fichier minimal)"
	@echo "  make test           Compile et affiche un résumé"
	@echo "  make ci             CI locale (clean + compile + test)"
	@echo "  make tag            Crée un tag Git v$(VERSION)"
	@echo "  make git-commit     Commit et push toutes les modifications"
	@echo ""
	@echo "TEXMF_HOME : $(TEXMF_HOME)"
	@echo "Dossier d'installation : $(TEXMF_DIR)"

# ============================================================
# Compilation des exemples
# ============================================================

# --- Compile tous les exemples ---
compile: $(EXAMPLES_PDF)

# --- Règle générique pour compiler un .tex en .pdf ---
$(EXAMPLES_DIR)/%.pdf: $(EXAMPLES_DIR)/%.tex $(STY)
	@echo ">>> Compilation de $<"
	@cd $(EXAMPLES_DIR) && $(LATEX) $(LATEXOPT) $(notdir $<) > /dev/null 2>&1 || true
	@cd $(EXAMPLES_DIR) && $(LATEX) $(LATEXOPT) $(notdir $<) > /dev/null 2>&1 || true
	@cd $(EXAMPLES_DIR) && $(LATEX) $(LATEXOPT) $(notdir $<) > /dev/null 2>&1
	@echo ">>> $@ généré"

# --- Compilation avec sortie complète (pour debug) ---
compile-verbose:
	@for f in $(EXAMPLES); do \
		echo ">>> Compilation de $$f"; \
		cd $(EXAMPLES_DIR) && $(LATEX) $(LATEXOPT) $$(basename $$f); \
	done

# ============================================================
# Nettoyage
# ============================================================

# --- Supprime les fichiers auxiliaires ---
clean:
	@echo ">>> Nettoyage des fichiers auxiliaires"
	@$(RM) $(EXAMPLES_DIR)/*.aux
	@$(RM) $(EXAMPLES_DIR)/*.log
	@$(RM) $(EXAMPLES_DIR)/*.out
	@$(RM) $(EXAMPLES_DIR)/*.toc
	@$(RM) $(EXAMPLES_DIR)/*.synctex.gz
	@$(RM) $(EXAMPLES_DIR)/*.fls
	@$(RM) $(EXAMPLES_DIR)/*.fdb_latexmk
	@$(RM) $(EXAMPLES_DIR)/*.nav
	@$(RM) $(EXAMPLES_DIR)/*.snm
	@$(RM) $(EXAMPLES_DIR)/*.vrb
	@echo ">>> Fait."

# --- Supprime aussi les PDF ---
cleanall: clean
	@echo ">>> Suppression des PDF"
	@$(RM) $(EXAMPLES_DIR)/*.pdf
	@echo ">>> Fait."

# ============================================================
# Installation dans TEXMF_HOME
# ============================================================

# --- Installe le package ---
install: $(STY)
	@echo ">>> Installation dans $(TEXMF_DIR)"
	@$(MKDIR) $(TEXMF_DIR)
	@$(CP) $(STY) $(TEXMF_DIR)/
	@$(TEXHASH)
	@echo ">>> Installation terminée."
	@echo ">>> Test : kpsewhich $(STY)"
	@kpsewhich $(STY) || echo ">>> ERREUR : $(STY) introuvable"

# --- Désinstalle le package ---
uninstall:
	@echo ">>> Désinstallation de $(TEXMF_DIR)/$(STY)"
	@$(RM) $(TEXMF_DIR)/$(STY)
	@$(TEXHASH)
	@echo ">>> Désinstallation terminée."

# ============================================================
# Vérification
# ============================================================

# --- Vérifie que le package est trouvé ---
check:
	@echo ">>> Vérification du package"
	@echo "Chemin trouvé par TeX :"
	@kpsewhich $(STY) || echo "(non trouvé)"
	@echo ""
	@echo "Version déclarée :"
	@grep "ProvidesPackage" $(STY) | head -1

# --- Affiche la version ---
version:
	@echo "$(PACKAGE) v$(VERSION)"
	@grep "ProvidesPackage" $(STY) | head -1

# ============================================================
# Compilation de test (vérifie le package)
# ============================================================

# --- Test rapide : compile un fichier minimal ---
smoke-test:
	@echo ">>> Test de fumée (smoke test)"
	@printf '%s\n' \
	  '\documentclass{article}' \
	  '\usepackage{$(PACKAGE)}' \
	  '\begin{document}' \
	  '\reperegradue[points={A/(4,5), B/(-2,3)/blue}]' \
	  '\end{document}' \
	  > /tmp/smoke-test.tex
	@cd /tmp && $(LATEX) $(LATEXOPT) smoke-test.tex > /dev/null 2>&1
	@if [ -f /tmp/smoke-test.pdf ]; then \
	  echo ">>> ✅ Test réussi : /tmp/smoke-test.pdf"; \
	else \
	  echo ">>> ❌ Test échoué"; \
	  echo ">>> Contenu de /tmp/smoke-test.tex :"; \
	  cat -v /tmp/smoke-test.tex; \
	  echo ">>> Dernières lignes du log :"; \
	  tail -30 /tmp/smoke-test.log; \
	  exit 1; \
	fi

# --- Test complet avec résumé ---
test: compile
	@echo ""
	@echo "============================="
	@echo "  RÉSUMÉ DE COMPILATION"
	@echo "============================="
	@for pdf in $(EXAMPLES_PDF); do \
		if [ -f "$$pdf" ]; then \
			pages=$$(pdfinfo "$$pdf" 2>/dev/null | grep Pages | awk '{print $$2}'); \
			size=$$(du -h "$$pdf" | awk '{print $$1}'); \
			printf "  %-30s %s pages (%s)\n" "$$pdf" "$$pages" "$$size"; \
		else \
			printf "  %-30s ÉCHEC\n" "$$pdf"; \
		fi; \
	done
	@echo "============================="

# ============================================================
# Git : commit et tag
# ============================================================

# --- Commit et push ---
git-commit:
	@echo ">>> Git commit"
	@$(GIT) add .
	@$(GIT) commit -m "v$(VERSION) : mise à jour" || echo "(rien à commiter)"
	@$(GIT) push origin main

# --- Tag Git ---
tag:
	@echo ">>> Création du tag v$(VERSION)"
	@$(GIT) tag -a v$(VERSION) -m "Version $(VERSION)"
	@$(GIT) push origin v$(VERSION)
	@echo ">>> Tag v$(VERSION) créé et poussé"

# ============================================================
# CI locale : à utiliser avant de pousser
# ============================================================

ci: clean compile test
	@echo ""
	@echo ">>> ✅ CI locale terminée avec succès"

# ============================================================
# Nettoyage total (y compris installations)
# ============================================================

distclean: cleanall uninstall
	@echo ">>> Nettoyage total terminé"