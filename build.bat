set GOPATH=%cd%
go install -buildmode=c-archive foo
gcc -m64 -mthreads -fmessage-length=0 -I pkg\windows_amd64 -o test.exe bar.c pkg\windows_amd64\foo.a -l ntdll -l winmm -l Ws2_32
