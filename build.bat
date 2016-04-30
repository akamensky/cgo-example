set GOPATH=%cd%
set WORK=C:\tmp\1
set CGO_LDFLAGS="-g -O2"
mkdir %WORK%\foo\_obj\exe\
cd src\foo\
go tool cgo -objdir %WORK%\foo\_obj\ -importpath foo -exportheader=%WORK%\foo\_obj\_cgo_install.h -- -I %WORK%\foo\_obj\ foo.go
gcc -I . -m64 -pthread -fmessage-length=0 -fno-common -I %WORK%\foo\_obj\ -g -O2 -o %WORK%\foo\_obj\_cgo_main.o -c %WORK%\foo\_obj\_cgo_main.c
gcc -I . -m64 -pthread -fmessage-length=0 -fno-common -I %WORK%\foo\_obj\ -g -O2 -o %WORK%\foo\_obj\_cgo_export.o -c %WORK%\foo\_obj\_cgo_export.c
gcc -I . -m64 -pthread -fmessage-length=0 -fno-common -I %WORK%\foo\_obj\ -g -O2 -o %WORK%\foo\_obj\foo.cgo2.o -c %WORK%\foo\_obj\foo.cgo2.c
gcc -I . -m64 -pthread -fmessage-length=0 -fno-common -o %WORK%\foo\_obj\_cgo_.o %WORK%\foo\_obj\_cgo_main.o %WORK%\foo\_obj\_cgo_export.o %WORK%\foo\_obj\foo.cgo2.o -g -O2
go tool cgo -objdir %WORK%\foo\_obj\ -dynpackage main -dynimport %WORK%\foo\_obj\_cgo_.o -dynout %WORK%\foo\_obj\_cgo_import.go
gcc -I . -fPIC -m64 -pthread -fmessage-length=0 -fno-common -o %WORK%\foo\_obj\_all.o %WORK%\foo\_obj\_cgo_export.o %WORK%\foo\_obj\foo.cgo2.o -g -O2 -Wl,-r -nostdlib
go tool compile -o %WORK%\foo.a -trimpath %WORK% -p main -I %WORK% -pack %WORK%\foo\_obj\_cgo_gotypes.go %WORK%\foo\_obj\foo.cgo1.go %WORK%\foo\_obj\_cgo_import.go
go tool pack r %WORK%\foo.a %WORK%\foo\_obj\_all.o
cd %GOPATH%
go tool link -o %WORK%\foo\_obj\exe\a.out.a -L %WORK% -extld=gcc -buldmode=c-archive %WORK%\foo.a
