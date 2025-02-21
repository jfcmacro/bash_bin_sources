all: ${HOME}/bin/checkDir ${HOME}/bin/mvnGenerate
# generateParciales gen mdWndFiles2UxFiles mvnGenerate nextSession setSDKInitJava

${HOME}/bin/checkDir: checkDir.sh
	install $< $@
	chmod +x $@

${HOME}/bin/mvnGenerate: mvnGenerate.sh
	install $< $@
	chmod +x $@

