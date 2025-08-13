/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembly of dbg2.dat
 *
 * ACPI Data Table [DBG2]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "DBG2"    [Debug Port Table type 2]
[004h 0004 004h]                Table Length : 0000005C
[008h 0008 001h]                    Revision : 00
[009h 0009 001h]                    Checksum : 8A
[00Ah 0010 006h]                      Oem ID : "CIXTEK"
[010h 0016 008h]                Oem Table ID : "SKY1EDK2"
[018h 0024 004h]                Oem Revision : 01000101
[01Ch 0028 004h]             Asl Compiler ID : "CIX "
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]                 Info Offset : 0000002C
[028h 0040 004h]                  Info Count : 00000001

[02Ch 0044 001h]                    Revision : 00
[02Dh 0045 002h]                      Length : 0030
[02Fh 0047 001h]              Register Count : 01
[030h 0048 002h]             Namepath Length : 000A
[032h 0050 002h]             Namepath Offset : 0026
[034h 0052 002h]             OEM Data Length : 0000 [Optional field not present]
[036h 0054 002h]             OEM Data Offset : 0000 [Optional field not present]
[038h 0056 002h]                   Port Type : 8000
[03Ah 0058 002h]                Port Subtype : 0003
[03Ch 0060 002h]                    Reserved : 0000
[03Eh 0062 002h]         Base Address Offset : 0016
[040h 0064 002h]         Address Size Offset : 0022

[042h 0066 00Ch]       Base Address Register : [Generic Address Structure]
[042h 0066 001h]                    Space ID : 00 [SystemMemory]
[043h 0067 001h]                   Bit Width : 20
[044h 0068 001h]                  Bit Offset : 00
[045h 0069 001h]        Encoded Access Width : 03 [DWord Access:32]
[046h 0070 008h]                     Address : 00000000040E0000

[04Eh 0078 004h]                Address Size : 00001000

[052h 0082 00Ah]                    Namepath : "\_SB.COM2"

Raw Table Data: Length 92 (0x5C)

    0000: 44 42 47 32 5C 00 00 00 00 8A 43 49 58 54 45 4B  // DBG2\.....CIXTEK
    0010: 53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20  // SKY1EDK2....CIX 
    0020: 01 00 00 00 2C 00 00 00 01 00 00 00 00 30 00 01  // ....,........0..
    0030: 0A 00 26 00 00 00 00 00 00 80 03 00 00 00 16 00  // ..&.............
    0040: 22 00 00 20 00 03 00 00 0E 04 00 00 00 00 00 10  // ".. ............
    0050: 00 00 5C 5F 53 42 2E 43 4F 4D 32 00              // ..\_SB.COM2.
