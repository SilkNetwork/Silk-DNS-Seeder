CXXFLAGS = -O3 -g0
LDFLAGS = $(CXXFLAGS)

dnsseed: dns.o silk.o netbase.o protocol.o db.o main.o util.o
	g++ -pthread $(LDFLAGS) -o dnsseed dns.o silk.o netbase.o protocol.o db.o main.o util.o -lcrypto

%.o: %.cpp silk.h netbase.h protocol.h db.h serialize.h uint256.h util.h
	g++ -pthread $(CXXFLAGS) -Wno-invalid-offsetof -c -o $@ $<

dns.o: dns.c
	gcc -pthread -std=c99 $(CXXFLAGS) dns.c -c -o dns.o

%.o: %.cpp
