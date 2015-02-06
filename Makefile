#Install dotfiles in $HOME dir
DIR = 		
DOT_DIR = 	fonts mpd ncmpcpp vim
DOT_FILE = 	xsessionrc Xmodmap_t61 xinitrc Xdefaults xbindkeysrc unburden-home-dir.list screenrc profile obnam.conf mpdconf inputrc hgrc gitconfig fehbg bashrc bash_profile ackrc

all: install

install: install-ssh install-awesome \
	$(foreach f, $(DIR), install-dir-$(f)) \
	$(foreach f, $(DOT_DIR), install-dotdir-$(f)) \
	$(foreach f, $(DOT_FILE), install-file-$(f))

install-ssh:
	@echo "  MKDIR Creating ~/.ssh"
	@mkdir $(HOME)/.ssh 2>/dev/null
	@ln -snf $(CURDIR)/ssh/config $(HOME)/.ssh/config

install-awesome:
	@echo "  LN ~/.config/awesome"
	@ln -snf $(CURDIR)/config/awesome $(HOME)/.config/awesome

install-dir-%: %
    @echo "  LN  $< to ~/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

install-dotdir-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<

install-file-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DIR), clean-$(f)) \
	$(foreach f, $(DOT_DIR), clean-.$(f)) \
	$(foreach f, $(DOT_FILE), clean-.$(f))

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

clean-ssh:
	@echo "  CLEAN  ~/.ssh/config"
	@sh -c "if [ -h ~/.ssh/config ]; then rm ~/.ssh/config; fi"

clean-awesome:
	@echo "  CLEAN  ~/.config/awesome"
	@sh -c "if [ -h ~/.config/awesome ]; then rm ~/.config/awesome fi"

