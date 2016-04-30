set GOPATH=%cd%
go build -buildmode=c-archive foo
gcc -m64 -mthreads -fmessage-length=0 -Wl,-no_pie -I pkg\windows_amd64 -o test.exe bar.c pkg\windows_amd64\foo.a
