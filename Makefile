SUBMODULES:=firmware hardware software submodules/board-support submodules/common-hdl submodules/ethernet-core submodules/fpga-family submodules/kicad_library submodules/peripheral-drivers submodules/qubic_not_open
AUTOCOMMITMSG=AUTOUPDATESUBMODULE
COMMITMSG = $(shell git log --pretty=oneline --abbrev-commit |head -1 | awk '{print $$2}')

submoduleupdate:
	$(for f in $(SUBMODULES); do echo $f; git add $f; done)
ifeq ($(COMMITMSG),$(AUTOCOMMITMSG))
	echo yes
	git reset --soft HEAD^
	-git commit -a -m $(AUTOCOMMITMSG)
else
	echo no,
	echo 'autocommitmsg',$(AUTOCOMMITMSG)
	echo 'commitmsg',$(COMMITMSG)
	-git commit -a -m $(AUTOCOMMITMSG)
endif
	-git commit -a -m $(AUTOCOMMITMSG)
	#for f in $(SUBMODULES); do git add $(f); done
