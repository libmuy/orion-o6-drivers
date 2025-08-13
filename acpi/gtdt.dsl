/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembly of gtdt.dat
 *
 * ACPI Data Table [GTDT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "GTDT"    [Generic Timer Description Table]
[004h 0004 004h]                Table Length : 00000084
[008h 0008 001h]                    Revision : 03
[009h 0009 001h]                    Checksum : E5
[00Ah 0010 006h]                      Oem ID : "CIXTEK"
[010h 0016 008h]                Oem Table ID : "SKY1EDK2"
[018h 0024 004h]                Oem Revision : 01000101
[01Ch 0028 004h]             Asl Compiler ID : "CIX "
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 008h]       Counter Block Address : FFFFFFFFFFFFFFFF
[02Ch 0044 004h]                    Reserved : 00000000

[030h 0048 004h]        Secure EL1 Interrupt : 0000001D
[034h 0052 004h]   EL1 Flags (decoded below) : 00000002
                                Trigger Mode : 0
                                    Polarity : 1
                                   Always On : 0

[038h 0056 004h]    Non-Secure EL1 Interrupt : 0000001E
[03Ch 0060 004h]  NEL1 Flags (decoded below) : 00000002
                                Trigger Mode : 0
                                    Polarity : 1
                                   Always On : 0

[040h 0064 004h]     Virtual Timer Interrupt : 0000001B
[044h 0068 004h]    VT Flags (decoded below) : 00000002
                                Trigger Mode : 0
                                    Polarity : 1
                                   Always On : 0

[048h 0072 004h]    Non-Secure EL2 Interrupt : 0000001A
[04Ch 0076 004h]  NEL2 Flags (decoded below) : 00000002
                                Trigger Mode : 0
                                    Polarity : 1
                                   Always On : 0
[050h 0080 008h]  Counter Read Block Address : FFFFFFFFFFFFFFFF

[058h 0088 004h]        Platform Timer Count : 00000001
[05Ch 0092 004h]       Platform Timer Offset : 00000068
[060h 0096 004h]      Virtual EL2 Timer GSIV : 00000000
[064h 0100 004h]     Virtual EL2 Timer Flags : 00000000

[068h 0104 001h]               Subtable Type : 01 [Generic Watchdog Timer]
[069h 0105 002h]                      Length : 001C
[06Bh 0107 001h]                    Reserved : 00
[06Ch 0108 008h]       Refresh Frame Address : 0000000016008000
[074h 0116 008h]       Control Frame Address : 0000000016003000
[07Ch 0124 004h]             Timer Interrupt : 00000198
[080h 0128 004h] Timer Flags (decoded below) : 00000000
                                Trigger Mode : 0
                                    Polarity : 0
                                    Security : 0

Raw Table Data: Length 132 (0x84)

    0000: 47 54 44 54 84 00 00 00 03 E5 43 49 58 54 45 4B  // GTDT......CIXTEK
    0010: 53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20  // SKY1EDK2....CIX 
    0020: 01 00 00 00 FF FF FF FF FF FF FF FF 00 00 00 00  // ................
    0030: 1D 00 00 00 02 00 00 00 1E 00 00 00 02 00 00 00  // ................
    0040: 1B 00 00 00 02 00 00 00 1A 00 00 00 02 00 00 00  // ................
    0050: FF FF FF FF FF FF FF FF 01 00 00 00 68 00 00 00  // ............h...
    0060: 00 00 00 00 00 00 00 00 01 1C 00 00 00 80 00 16  // ................
    0070: 00 00 00 00 00 30 00 16 00 00 00 00 98 01 00 00  // .....0..........
    0080: 00 00 00 00                                      // ....
