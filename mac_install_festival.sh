curl -O http://www.cstr.ed.ac.uk/downloads/festival/2.4/festival-2.4-release.tar.gz
curl -O http://www.cstr.ed.ac.uk/downloads/festival/2.4/speech_tools-2.4-release.tar.gz
gunzip -c festival-2.4-release.tar.gz | tar xopf -
gunzip -c speech_tools-2.4-release.tar.gz | tar xopf -
cd speech_tools
./configure
make
make install
cd ..
cd festival
./configure
make
make install
