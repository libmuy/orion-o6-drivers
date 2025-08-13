/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembly of mcfg.dat
 *
 * ACPI Data Table [MCFG]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
[004h 0004 004h]                Table Length : 0000005C
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : 4B
[00Ah 0010 006h]                      Oem ID : "CIXTEK"
[010h 0016 008h]                Oem Table ID : "SKY1EDK2"
[018h 0024 004h]                Oem Revision : 01000101
[01Ch 0028 004h]             Asl Compiler ID : "CIX "
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 008h]                    Reserved : 0000000000000000

[02Ch 0044 008h]                Base Address : 0000000020000000
[034h 0052 002h]        Segment Group Number : 0000
[036h 0054 001h]            Start Bus Number : 90
[037h 0055 001h]              End Bus Number : AF
[038h 0056 004h]                    Reserved : 00000000

[03Ch 0060 008h]                Base Address : 0000000020000000
[044h 0068 002h]        Segment Group Number : 0000
[046h 0070 001h]            Start Bus Number : 30
[047h 0071 001h]              End Bus Number : 4F
[048h 0072 004h]                    Reserved : 00000000

[04Ch 0076 008h]                Base Address : 0000000020000000
[054h 0084 002h]        Segment Group Number : 0000
[056h 0086 001h]            Start Bus Number : 00
[057h 0087 001h]              End Bus Number : 1F
[058h 0088 004h]                    Reserved : 00000000

Raw Table Data: Length 92 (0x5C)

    0000: 4D 43 46 47 5C 00 00 00 01 4B 43 49 58 54 45 4B  // MCFG\....KCIXTEK
    0010: 53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20  // SKY1EDK2....CIX 
    0020: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 20  // ............... 
    0030: 00 00 00 00 00 00 90 AF 00 00 00 00 00 00 00 20  // ............... 
    0040: 00 00 00 00 00 00 30 4F 00 00 00 00 00 00 00 20  // ......0O....... 
    0050: 00 00 00 00 00 00 00 1F 00 00 00 00              // ............
