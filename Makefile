all: install

install: install-library install-binaries install-service create-config
	@echo "BKM successfully installed!\nUse $ bkm --help to see usage"

install-library:
	@echo -n "Installing libraries..." \
		&& mkdir /usr/libexec/bkm \
		&& cp src/lib/* /usr/libexec/bkm \
		&& echo "Done"

install-binaries:
	@echo -n "Installing binaries..." \
		&& cp src/bkm.sh /usr/bin/bkm \
		&& chmod +x usr/bin/bkm \
		&& echo "Done"

install-service:
	@echo -n "Installing service..." \
    		&& echo "Todo"

create-config:
	@echo -n "Creating configuration..." \
			&& cp src/lib/templates/.bkm ~/bkm \
			&& echo "Done"

clean:
	@echo -n "Cleaning bkm..." \
		&& rm -rf /usr/libexec/bkm \
		&& rm /usr/bin/bkm \
		&& rm ~/.bkm \
		&& echo "Done"
	@echo "BKM has been successfully removed from your system"