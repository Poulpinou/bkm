all: install

install: install-library install-binaries install-service create-config
	@echo "BKM successfully installed!\nUse $ bkm --help to see usage"

install-library:
	@echo -n "Installing libraries..." \
		&& mkdir -p /usr/local/lib/bkm \
		&& cp -r src/lib/* /usr/local/lib/bkm \
		&& echo "Done"

install-binaries:
	@echo -n "Installing binaries..."
	@mkdir -p ~/bin
	@cp src/bin/bkm.sh ~/bin/bkm \
		&& chmod +x ~/bin/bkm \
		&& echo "Done"

install-service:
	@echo -n "Installing service..." \
    		&& echo "Todo"

create-config:
	@echo -n "Creating configuration..." \
			&& cp src/lib/templates/.bkm ~/.bkm \
			&& echo "Done"

clean:
	@echo -n "Cleaning bkm..." \
		&& rm -rf /usr/local/lib/bkm \
		&& rm -f ~/bin/bkm \
		&& rm -f ~/.bkm \
		&& echo "Done"
	@echo "BKM has been successfully removed from your system"