/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembly of csrt.dat
 *
 * ACPI Data Table [CSRT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "CSRT"    [Core System Resource Table]
[004h 0004 004h]                Table Length : 0000008C
[008h 0008 001h]                    Revision : 00
[009h 0009 001h]                    Checksum : 65
[00Ah 0010 006h]                      Oem ID : "CIXTEK"
[010h 0016 008h]                Oem Table ID : "SKY1EDK2"
[018h 0024 004h]                Oem Revision : 01000101
[01Ch 0028 004h]             Asl Compiler ID : "CIX "
[020h 0032 004h]       Asl Compiler Revision : 00000001


[024h 0036 004h]                      Length : 00000034
[028h 0040 004h]                   Vendor ID : 20584943
[02Ch 0044 004h]                Subvendor ID : 00000000
[030h 0048 002h]                   Device ID : 0000
[032h 0050 002h]                Subdevice ID : 0000
[034h 0052 002h]                    Revision : 0000
[036h 0054 002h]                    Reserved : 0000
[038h 0056 004h]          Shared Info Length : 0000001C

[03Ch 0060 002h]               Major Version : 0000
[03Eh 0062 002h]               Minor Version : 0000
[040h 0064 004h]       MMIO Base Address Low : 04190000
[044h 0068 004h]      MMIO Base Address High : 00000000
[048h 0072 004h]               GSI Interrupt : 0000014F
[04Ch 0076 001h]          Interrupt Polarity : 00
[04Dh 0077 001h]              Interrupt Mode : 00
[04Eh 0078 001h]                Num Channels : 08
[04Fh 0079 001h]           DMA Address Width : 20
[050h 0080 002h]           Base Request Line : 0000
[052h 0082 002h]       Num Handshake Signals : 0020
[054h 0084 004h]              Max Block Size : 00000000

[058h 0088 004h]                      Length : 00000034
[05Ch 0092 004h]                   Vendor ID : 20584943
[060h 0096 004h]                Subvendor ID : 00000000
[064h 0100 002h]                   Device ID : 0001
[066h 0102 002h]                Subdevice ID : 0000
[068h 0104 002h]                    Revision : 0000
[06Ah 0106 002h]                    Reserved : 0000
[06Ch 0108 004h]          Shared Info Length : 0000001C

[070h 0112 002h]               Major Version : 0000
[072h 0114 002h]               Minor Version : 0000
[074h 0116 004h]       MMIO Base Address Low : 07010000
[078h 0120 004h]      MMIO Base Address High : 00000000
[07Ch 0124 004h]               GSI Interrupt : 00000106
[080h 0128 001h]          Interrupt Polarity : 00
[081h 0129 001h]              Interrupt Mode : 00
[082h 0130 001h]                Num Channels : 08
[083h 0131 001h]           DMA Address Width : 20
[084h 0132 002h]           Base Request Line : 0020
[086h 0134 002h]       Num Handshake Signals : 0020
[088h 0136 004h]              Max Block Size : 00000000

Raw Table Data: Length 140 (0x8C)

    0000: 43 53 52 54 8C 00 00 00 00 65 43 49 58 54 45 4B  // CSRT.....eCIXTEK
    0010: 53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20  // SKY1EDK2....CIX 
    0020: 01 00 00 00 34 00 00 00 43 49 58 20 00 00 00 00  // ....4...CIX ....
    0030: 00 00 00 00 00 00 00 00 1C 00 00 00 00 00 00 00  // ................
    0040: 00 00 19 04 00 00 00 00 4F 01 00 00 00 00 08 20  // ........O...... 
    0050: 00 00 20 00 00 00 00 00 34 00 00 00 43 49 58 20  // .. .....4...CIX 
    0060: 00 00 00 00 01 00 00 00 00 00 00 00 1C 00 00 00  // ................
    0070: 00 00 00 00 00 00 01 07 00 00 00 00 06 01 00 00  // ................
    0080: 00 00 08 20 20 00 20 00 00 00 00 00              // ...  . .....
