/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembly of iort.dat
 *
 * ACPI Data Table [IORT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
[004h 0004 004h]                Table Length : 00000AD8
[008h 0008 001h]                    Revision : 05
[009h 0009 001h]                    Checksum : 7E
[00Ah 0010 006h]                      Oem ID : "CIXTEK"
[010h 0016 008h]                Oem Table ID : "SKY1EDK2"
[018h 0024 004h]                Oem Revision : 01000101
[01Ch 0028 004h]             Asl Compiler ID : "CIX "
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]                  Node Count : 00000013
[028h 0040 004h]                 Node Offset : 00000030
[02Ch 0044 004h]                    Reserved : 00000000

[030h 0048 001h]                        Type : 00
[031h 0049 002h]                      Length : 0018
[033h 0051 001h]                    Revision : 00
[034h 0052 004h]                  Identifier : 00000000
[038h 0056 004h]               Mapping Count : 00000000
[03Ch 0060 004h]              Mapping Offset : 00000000

[040h 0064 004h]                    ItsCount : 00000001
[044h 0068 004h]                 Identifiers : 00000000

[048h 0072 001h]                        Type : 04
[049h 0073 002h]                      Length : 0058
[04Bh 0075 001h]                    Revision : 02
[04Ch 0076 004h]                  Identifier : 00000000
[050h 0080 004h]               Mapping Count : 00000001
[054h 0084 004h]              Mapping Offset : 00000044

[058h 0088 008h]                Base Address : 000000000B010000
[060h 0096 004h]       Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
                              DeviceID Valid : 0
[064h 0100 004h]                    Reserved : 00000000
[068h 0104 008h]               VATOS Address : 0000000000000000
[070h 0112 004h]                       Model : 00000000
[074h 0116 004h]                  Event GSIV : 0000006B
[078h 0120 004h]                    PRI GSIV : 00000074
[07Ch 0124 004h]                   GERR GSIV : 00000070
[080h 0128 004h]                   Sync GSIV : 0000006C
[084h 0132 004h]            Proximity Domain : 00000000
[088h 0136 004h]     Device ID Mapping Index : 00000000

[08Ch 0140 004h]                  Input base : 00000000
[090h 0144 004h]                    ID Count : 0000FFFF
[094h 0148 004h]                 Output Base : 00000000
[098h 0152 004h]            Output Reference : 00000030
[09Ch 0156 004h]       Flags (decoded below) : 00000000
                              Single Mapping : 0

[0A0h 0160 001h]                        Type : 02
[0A1h 0161 002h]                      Length : 003C
[0A3h 0163 001h]                    Revision : 00
[0A4h 0164 004h]                  Identifier : 00000000
[0A8h 0168 004h]               Mapping Count : 00000001
[0ACh 0172 004h]              Mapping Offset : 00000028

[0B0h 0176 008h]           Memory Properties : [IORT Memory Access Properties]
[0B0h 0176 004h]             Cache Coherency : 00000001
[0B4h 0180 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[0B5h 0181 002h]                    Reserved : 0000
[0B7h 0183 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[0B8h 0184 004h]               ATS Attribute : 00000001
[0BCh 0188 004h]          PCI Segment Number : 00000000
[0C0h 0192 001h]           Memory Size Limit : 00
[0C1h 0193 002h]          PASID Capabilities : 0000
[0C3h 0195 001h]                    Reserved : 00

[0C8h 0200 004h]                  Input base : 00000000
[0CCh 0204 004h]                    ID Count : 0000FFFF
[0D0h 0208 004h]                 Output Base : 00000000
[0D4h 0212 004h]            Output Reference : 00000048
[0D8h 0216 004h]       Flags (decoded below) : 00000000
                              Single Mapping : 0

[0DCh 0220 001h]                        Type : 04
[0DDh 0221 002h]                      Length : 0044
[0DFh 0223 001h]                    Revision : 02
[0E0h 0224 004h]                  Identifier : 00000001
[0E4h 0228 004h]               Mapping Count : 00000000
[0E8h 0232 004h]              Mapping Offset : 00000000

[0ECh 0236 008h]                Base Address : 000000000B1B0000
[0F4h 0244 004h]       Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
                              DeviceID Valid : 0
[0F8h 0248 004h]                    Reserved : 00000000
[0FCh 0252 008h]               VATOS Address : 0000000000000000
[104h 0260 004h]                       Model : 00000000
[108h 0264 004h]                  Event GSIV : 0000008D
[10Ch 0268 004h]                    PRI GSIV : 00000096
[110h 0272 004h]                   GERR GSIV : 00000092
[114h 0276 004h]                   Sync GSIV : 0000008E
[118h 0280 004h]            Proximity Domain : 00000000
[11Ch 0284 004h]     Device ID Mapping Index : 00000000

[120h 0288 001h]                        Type : 01
[121h 0289 002h]                      Length : 00A0
[123h 0291 001h]                    Revision : 00
[124h 0292 004h]                  Identifier : 00000000
[128h 0296 004h]               Mapping Count : 00000005
[12Ch 0300 004h]              Mapping Offset : 00000028

[130h 0304 004h]                  Node Flags : 00000000
[134h 0308 008h]           Memory Properties : [IORT Memory Access Properties]
[134h 0308 004h]             Cache Coherency : 00000001
[138h 0312 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[139h 0313 002h]                    Reserved : 0000
[13Bh 0315 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[13Ch 0316 001h]           Memory Size Limit : 28
[13Dh 0317 00Bh]                 Device Name : "\_SB_.DPU0"
[148h 0328 014h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 158h 0344   4 */                            53 4B 59 31                                     /* SKY1 */\

[148h 0328 004h]                  Input base : 00000000
[14Ch 0332 004h]                    ID Count : 00000000
[150h 0336 004h]                 Output Base : 00000000
[154h 0340 004h]            Output Reference : 000000DC
[158h 0344 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[15Ch 0348 004h]                  Input base : 00000000
[160h 0352 004h]                    ID Count : 00000000
[164h 0356 004h]                 Output Base : 00000001
[168h 0360 004h]            Output Reference : 000000DC
[16Ch 0364 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[170h 0368 004h]                  Input base : 00000000
[174h 0372 004h]                    ID Count : 00000000
[178h 0376 004h]                 Output Base : 00000003
[17Ch 0380 004h]            Output Reference : 000000DC
[180h 0384 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[184h 0388 004h]                  Input base : 00000000
[188h 0392 004h]                    ID Count : 00000000
[18Ch 0396 004h]                 Output Base : 00000004
[190h 0400 004h]            Output Reference : 000000DC
[194h 0404 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[198h 0408 004h]                  Input base : 00000000
[19Ch 0412 004h]                    ID Count : 00000000
[1A0h 0416 004h]                 Output Base : 00000005
[1A4h 0420 004h]            Output Reference : 000000DC
[1A8h 0424 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[1C0h 0448 001h]                        Type : 01
[1C1h 0449 002h]                      Length : 00A0
[1C3h 0451 001h]                    Revision : 00
[1C4h 0452 004h]                  Identifier : 00000000
[1C8h 0456 004h]               Mapping Count : 00000001
[1CCh 0460 004h]              Mapping Offset : 00000028

[1D0h 0464 004h]                  Node Flags : 00000000
[1D4h 0468 008h]           Memory Properties : [IORT Memory Access Properties]
[1D4h 0468 004h]             Cache Coherency : 00000001
[1D8h 0472 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[1D9h 0473 002h]                    Reserved : 0000
[1DBh 0475 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[1DCh 0476 001h]           Memory Size Limit : 28
[1DDh 0477 00Bh]                 Device Name : "\_SB_.AEU0"
[1E8h 0488 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 1F8h 0504  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 208h 0520  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 218h 0536  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 228h 0552  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 238h 0568  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 248h 0584   4 */                            01 00 00 00                                     /* .... */\

[1E8h 0488 004h]                  Input base : 00000000
[1ECh 0492 004h]                    ID Count : 00000000
[1F0h 0496 004h]                 Output Base : 00000002
[1F4h 0500 004h]            Output Reference : 000000DC
[1F8h 0504 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[260h 0608 001h]                        Type : 01
[261h 0609 002h]                      Length : 00A0
[263h 0611 001h]                    Revision : 00
[264h 0612 004h]                  Identifier : 00000000
[268h 0616 004h]               Mapping Count : 00000005
[26Ch 0620 004h]              Mapping Offset : 00000028

[270h 0624 004h]                  Node Flags : 00000000
[274h 0628 008h]           Memory Properties : [IORT Memory Access Properties]
[274h 0628 004h]             Cache Coherency : 00000001
[278h 0632 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[279h 0633 002h]                    Reserved : 0000
[27Bh 0635 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[27Ch 0636 001h]           Memory Size Limit : 28
[27Dh 0637 00Bh]                 Device Name : "\_SB_.DPU1"
[288h 0648 014h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 298h 0664   4 */                            53 4B 59 31                                     /* SKY1 */\

[288h 0648 004h]                  Input base : 00000000
[28Ch 0652 004h]                    ID Count : 00000000
[290h 0656 004h]                 Output Base : 00000006
[294h 0660 004h]            Output Reference : 000000DC
[298h 0664 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[29Ch 0668 004h]                  Input base : 00000000
[2A0h 0672 004h]                    ID Count : 00000000
[2A4h 0676 004h]                 Output Base : 00000007
[2A8h 0680 004h]            Output Reference : 000000DC
[2ACh 0684 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[2B0h 0688 004h]                  Input base : 00000000
[2B4h 0692 004h]                    ID Count : 00000000
[2B8h 0696 004h]                 Output Base : 00000009
[2BCh 0700 004h]            Output Reference : 000000DC
[2C0h 0704 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[2C4h 0708 004h]                  Input base : 00000000
[2C8h 0712 004h]                    ID Count : 00000000
[2CCh 0716 004h]                 Output Base : 0000000A
[2D0h 0720 004h]            Output Reference : 000000DC
[2D4h 0724 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[2D8h 0728 004h]                  Input base : 00000000
[2DCh 0732 004h]                    ID Count : 00000000
[2E0h 0736 004h]                 Output Base : 0000000B
[2E4h 0740 004h]            Output Reference : 000000DC
[2E8h 0744 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[300h 0768 001h]                        Type : 01
[301h 0769 002h]                      Length : 00A0
[303h 0771 001h]                    Revision : 00
[304h 0772 004h]                  Identifier : 00000000
[308h 0776 004h]               Mapping Count : 00000001
[30Ch 0780 004h]              Mapping Offset : 00000028

[310h 0784 004h]                  Node Flags : 00000000
[314h 0788 008h]           Memory Properties : [IORT Memory Access Properties]
[314h 0788 004h]             Cache Coherency : 00000001
[318h 0792 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[319h 0793 002h]                    Reserved : 0000
[31Bh 0795 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[31Ch 0796 001h]           Memory Size Limit : 28
[31Dh 0797 00Bh]                 Device Name : "\_SB_.AEU1"
[328h 0808 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 338h 0824  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 348h 0840  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 358h 0856  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 368h 0872  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 378h 0888  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 388h 0904   4 */                            01 00 00 00                                     /* .... */\

[328h 0808 004h]                  Input base : 00000000
[32Ch 0812 004h]                    ID Count : 00000000
[330h 0816 004h]                 Output Base : 00000008
[334h 0820 004h]            Output Reference : 000000DC
[338h 0824 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[3A0h 0928 001h]                        Type : 01
[3A1h 0929 002h]                      Length : 00A0
[3A3h 0931 001h]                    Revision : 00
[3A4h 0932 004h]                  Identifier : 00000000
[3A8h 0936 004h]               Mapping Count : 00000005
[3ACh 0940 004h]              Mapping Offset : 00000028

[3B0h 0944 004h]                  Node Flags : 00000000
[3B4h 0948 008h]           Memory Properties : [IORT Memory Access Properties]
[3B4h 0948 004h]             Cache Coherency : 00000001
[3B8h 0952 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[3B9h 0953 002h]                    Reserved : 0000
[3BBh 0955 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[3BCh 0956 001h]           Memory Size Limit : 28
[3BDh 0957 00Bh]                 Device Name : "\_SB_.DPU2"
[3C8h 0968 014h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 3D8h 0984   4 */                            53 4B 59 31                                     /* SKY1 */\

[3C8h 0968 004h]                  Input base : 00000000
[3CCh 0972 004h]                    ID Count : 00000000
[3D0h 0976 004h]                 Output Base : 0000000C
[3D4h 0980 004h]            Output Reference : 000000DC
[3D8h 0984 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[3DCh 0988 004h]                  Input base : 00000000
[3E0h 0992 004h]                    ID Count : 00000000
[3E4h 0996 004h]                 Output Base : 0000000D
[3E8h 1000 004h]            Output Reference : 000000DC
[3ECh 1004 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[3F0h 1008 004h]                  Input base : 00000000
[3F4h 1012 004h]                    ID Count : 00000000
[3F8h 1016 004h]                 Output Base : 0000000F
[3FCh 1020 004h]            Output Reference : 000000DC
[400h 1024 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[404h 1028 004h]                  Input base : 00000000
[408h 1032 004h]                    ID Count : 00000000
[40Ch 1036 004h]                 Output Base : 00000010
[410h 1040 004h]            Output Reference : 000000DC
[414h 1044 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[418h 1048 004h]                  Input base : 00000000
[41Ch 1052 004h]                    ID Count : 00000000
[420h 1056 004h]                 Output Base : 00000011
[424h 1060 004h]            Output Reference : 000000DC
[428h 1064 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[440h 1088 001h]                        Type : 01
[441h 1089 002h]                      Length : 00A0
[443h 1091 001h]                    Revision : 00
[444h 1092 004h]                  Identifier : 00000000
[448h 1096 004h]               Mapping Count : 00000001
[44Ch 1100 004h]              Mapping Offset : 00000028

[450h 1104 004h]                  Node Flags : 00000000
[454h 1108 008h]           Memory Properties : [IORT Memory Access Properties]
[454h 1108 004h]             Cache Coherency : 00000001
[458h 1112 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[459h 1113 002h]                    Reserved : 0000
[45Bh 1115 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[45Ch 1116 001h]           Memory Size Limit : 28
[45Dh 1117 00Bh]                 Device Name : "\_SB_.AEU2"
[468h 1128 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 478h 1144  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 488h 1160  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 498h 1176  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 4A8h 1192  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 4B8h 1208  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 4C8h 1224   4 */                            01 00 00 00                                     /* .... */\

[468h 1128 004h]                  Input base : 00000000
[46Ch 1132 004h]                    ID Count : 00000000
[470h 1136 004h]                 Output Base : 0000000E
[474h 1140 004h]            Output Reference : 000000DC
[478h 1144 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[4E0h 1248 001h]                        Type : 01
[4E1h 1249 002h]                      Length : 00A0
[4E3h 1251 001h]                    Revision : 00
[4E4h 1252 004h]                  Identifier : 00000000
[4E8h 1256 004h]               Mapping Count : 00000005
[4ECh 1260 004h]              Mapping Offset : 00000028

[4F0h 1264 004h]                  Node Flags : 00000000
[4F4h 1268 008h]           Memory Properties : [IORT Memory Access Properties]
[4F4h 1268 004h]             Cache Coherency : 00000001
[4F8h 1272 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[4F9h 1273 002h]                    Reserved : 0000
[4FBh 1275 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[4FCh 1276 001h]           Memory Size Limit : 28
[4FDh 1277 00Bh]                 Device Name : "\_SB_.DPU3"
[508h 1288 014h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 518h 1304   4 */                            53 4B 59 31                                     /* SKY1 */\

[508h 1288 004h]                  Input base : 00000000
[50Ch 1292 004h]                    ID Count : 00000000
[510h 1296 004h]                 Output Base : 00000012
[514h 1300 004h]            Output Reference : 000000DC
[518h 1304 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[51Ch 1308 004h]                  Input base : 00000000
[520h 1312 004h]                    ID Count : 00000000
[524h 1316 004h]                 Output Base : 00000013
[528h 1320 004h]            Output Reference : 000000DC
[52Ch 1324 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[530h 1328 004h]                  Input base : 00000000
[534h 1332 004h]                    ID Count : 00000000
[538h 1336 004h]                 Output Base : 00000015
[53Ch 1340 004h]            Output Reference : 000000DC
[540h 1344 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[544h 1348 004h]                  Input base : 00000000
[548h 1352 004h]                    ID Count : 00000000
[54Ch 1356 004h]                 Output Base : 00000016
[550h 1360 004h]            Output Reference : 000000DC
[554h 1364 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[558h 1368 004h]                  Input base : 00000000
[55Ch 1372 004h]                    ID Count : 00000000
[560h 1376 004h]                 Output Base : 00000017
[564h 1380 004h]            Output Reference : 000000DC
[568h 1384 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[580h 1408 001h]                        Type : 01
[581h 1409 002h]                      Length : 00A0
[583h 1411 001h]                    Revision : 00
[584h 1412 004h]                  Identifier : 00000000
[588h 1416 004h]               Mapping Count : 00000001
[58Ch 1420 004h]              Mapping Offset : 00000028

[590h 1424 004h]                  Node Flags : 00000000
[594h 1428 008h]           Memory Properties : [IORT Memory Access Properties]
[594h 1428 004h]             Cache Coherency : 00000001
[598h 1432 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[599h 1433 002h]                    Reserved : 0000
[59Bh 1435 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[59Ch 1436 001h]           Memory Size Limit : 28
[59Dh 1437 00Bh]                 Device Name : "\_SB_.AEU3"
[5A8h 1448 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 5B8h 1464  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 5C8h 1480  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 5D8h 1496  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 5E8h 1512  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 5F8h 1528  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 608h 1544   4 */                            01 00 00 00                                     /* .... */\

[5A8h 1448 004h]                  Input base : 00000000
[5ACh 1452 004h]                    ID Count : 00000000
[5B0h 1456 004h]                 Output Base : 00000014
[5B4h 1460 004h]            Output Reference : 000000DC
[5B8h 1464 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[620h 1568 001h]                        Type : 01
[621h 1569 002h]                      Length : 00A0
[623h 1571 001h]                    Revision : 00
[624h 1572 004h]                  Identifier : 00000000
[628h 1576 004h]               Mapping Count : 00000005
[62Ch 1580 004h]              Mapping Offset : 00000028

[630h 1584 004h]                  Node Flags : 00000000
[634h 1588 008h]           Memory Properties : [IORT Memory Access Properties]
[634h 1588 004h]             Cache Coherency : 00000001
[638h 1592 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[639h 1593 002h]                    Reserved : 0000
[63Bh 1595 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[63Ch 1596 001h]           Memory Size Limit : 28
[63Dh 1597 00Bh]                 Device Name : "\_SB_.DPU4"
[648h 1608 014h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 658h 1624   4 */                            53 4B 59 31                                     /* SKY1 */\

[648h 1608 004h]                  Input base : 00000000
[64Ch 1612 004h]                    ID Count : 00000000
[650h 1616 004h]                 Output Base : 00000018
[654h 1620 004h]            Output Reference : 000000DC
[658h 1624 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[65Ch 1628 004h]                  Input base : 00000000
[660h 1632 004h]                    ID Count : 00000000
[664h 1636 004h]                 Output Base : 00000019
[668h 1640 004h]            Output Reference : 000000DC
[66Ch 1644 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[670h 1648 004h]                  Input base : 00000000
[674h 1652 004h]                    ID Count : 00000000
[678h 1656 004h]                 Output Base : 0000001B
[67Ch 1660 004h]            Output Reference : 000000DC
[680h 1664 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[684h 1668 004h]                  Input base : 00000000
[688h 1672 004h]                    ID Count : 00000000
[68Ch 1676 004h]                 Output Base : 0000001C
[690h 1680 004h]            Output Reference : 000000DC
[694h 1684 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[698h 1688 004h]                  Input base : 00000000
[69Ch 1692 004h]                    ID Count : 00000000
[6A0h 1696 004h]                 Output Base : 0000001D
[6A4h 1700 004h]            Output Reference : 000000DC
[6A8h 1704 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[6C0h 1728 001h]                        Type : 01
[6C1h 1729 002h]                      Length : 00A0
[6C3h 1731 001h]                    Revision : 00
[6C4h 1732 004h]                  Identifier : 00000000
[6C8h 1736 004h]               Mapping Count : 00000001
[6CCh 1740 004h]              Mapping Offset : 00000028

[6D0h 1744 004h]                  Node Flags : 00000000
[6D4h 1748 008h]           Memory Properties : [IORT Memory Access Properties]
[6D4h 1748 004h]             Cache Coherency : 00000001
[6D8h 1752 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[6D9h 1753 002h]                    Reserved : 0000
[6DBh 1755 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[6DCh 1756 001h]           Memory Size Limit : 28
[6DDh 1757 00Bh]                 Device Name : "\_SB_.AEU4"
[6E8h 1768 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 6F8h 1784  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 708h 1800  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 718h 1816  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 728h 1832  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 738h 1848  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 748h 1864   4 */                            01 00 00 00                                     /* .... */\

[6E8h 1768 004h]                  Input base : 00000000
[6ECh 1772 004h]                    ID Count : 00000000
[6F0h 1776 004h]                 Output Base : 0000001A
[6F4h 1780 004h]            Output Reference : 000000DC
[6F8h 1784 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[760h 1888 001h]                        Type : 01
[761h 1889 002h]                      Length : 00A0
[763h 1891 001h]                    Revision : 00
[764h 1892 004h]                  Identifier : 00000000
[768h 1896 004h]               Mapping Count : 00000001
[76Ch 1900 004h]              Mapping Offset : 00000028

[770h 1904 004h]                  Node Flags : 00000000
[774h 1908 008h]           Memory Properties : [IORT Memory Access Properties]
[774h 1908 004h]             Cache Coherency : 00000001
[778h 1912 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[779h 1913 002h]                    Reserved : 0000
[77Bh 1915 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[77Ch 1916 001h]           Memory Size Limit : 28
[77Dh 1917 00Bh]                 Device Name : "\_SB_.NPU0"
[788h 1928 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 798h 1944  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 7A8h 1960  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 7B8h 1976  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 7C8h 1992  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 7D8h 2008  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 7E8h 2024   4 */                            01 00 00 00                                     /* .... */\

[788h 1928 004h]                  Input base : 00000000
[78Ch 1932 004h]                    ID Count : 00000000
[790h 1936 004h]                 Output Base : 0000001E
[794h 1940 004h]            Output Reference : 000000DC
[798h 1944 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[800h 2048 001h]                        Type : 01
[801h 2049 002h]                      Length : 00A0
[803h 2051 001h]                    Revision : 00
[804h 2052 004h]                  Identifier : 00000000
[808h 2056 004h]               Mapping Count : 00000001
[80Ch 2060 004h]              Mapping Offset : 00000028

[810h 2064 004h]                  Node Flags : 00000000
[814h 2068 008h]           Memory Properties : [IORT Memory Access Properties]
[814h 2068 004h]             Cache Coherency : 00000001
[818h 2072 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[819h 2073 002h]                    Reserved : 0000
[81Bh 2075 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[81Ch 2076 001h]           Memory Size Limit : 28
[81Dh 2077 00Bh]                 Device Name : "\_SB_.ISPM"
[828h 2088 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 838h 2104  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 848h 2120  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 858h 2136  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 868h 2152  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 878h 2168  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 888h 2184   4 */                            01 00 00 00                                     /* .... */\

[828h 2088 004h]                  Input base : 00000000
[82Ch 2092 004h]                    ID Count : 00000000
[830h 2096 004h]                 Output Base : 0000001F
[834h 2100 004h]            Output Reference : 000000DC
[838h 2104 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[8A0h 2208 001h]                        Type : 01
[8A1h 2209 002h]                      Length : 00A0
[8A3h 2211 001h]                    Revision : 00
[8A4h 2212 004h]                  Identifier : 00000000
[8A8h 2216 004h]               Mapping Count : 00000001
[8ACh 2220 004h]              Mapping Offset : 00000028

[8B0h 2224 004h]                  Node Flags : 00000000
[8B4h 2228 008h]           Memory Properties : [IORT Memory Access Properties]
[8B4h 2228 004h]             Cache Coherency : 00000001
[8B8h 2232 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[8B9h 2233 002h]                    Reserved : 0000
[8BBh 2235 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[8BCh 2236 001h]           Memory Size Limit : 28
[8BDh 2237 00Bh]                 Device Name : "\_SB_.CBD0"
[8C8h 2248 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 8D8h 2264  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 8E8h 2280  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 8F8h 2296  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 908h 2312  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 918h 2328  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 928h 2344   4 */                            01 00 00 00                                     /* .... */\

[8C8h 2248 004h]                  Input base : 00000000
[8CCh 2252 004h]                    ID Count : 00000000
[8D0h 2256 004h]                 Output Base : 00000021
[8D4h 2260 004h]            Output Reference : 000000DC
[8D8h 2264 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[940h 2368 001h]                        Type : 01
[941h 2369 002h]                      Length : 00A0
[943h 2371 001h]                    Revision : 00
[944h 2372 004h]                  Identifier : 00000000
[948h 2376 004h]               Mapping Count : 00000001
[94Ch 2380 004h]              Mapping Offset : 00000028

[950h 2384 004h]                  Node Flags : 00000000
[954h 2388 008h]           Memory Properties : [IORT Memory Access Properties]
[954h 2388 004h]             Cache Coherency : 00000001
[958h 2392 001h]       Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[959h 2393 002h]                    Reserved : 0000
[95Bh 2395 001h] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
               Ensured Coherency of Accesses : 0
[95Ch 2396 001h]           Memory Size Limit : 28
[95Dh 2397 00Bh]                 Device Name : "\_SB_.CBD2"
[968h 2408 064h]                     Padding : 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B /* IORT.....~CIXTEK */\
/* 978h 2424  16 */                            53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20 /* SKY1EDK2....CIX  */\
/* 988h 2440  16 */                            01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00 /* ........0....... */\
/* 998h 2456  16 */                            00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00 /* ................ */\
/* 9A8h 2472  16 */                            01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00 /* .........X...... */\
/* 9B8h 2488  16 */                            01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00 /* ....D........... */\
/* 9C8h 2504   4 */                            01 00 00 00                                     /* .... */\

[968h 2408 004h]                  Input base : 00000000
[96Ch 2412 004h]                    ID Count : 00000000
[970h 2416 004h]                 Output Base : 00000022
[974h 2420 004h]            Output Reference : 000000DC
[978h 2424 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[9E0h 2528 001h]                        Type : 06
[9E1h 2529 002h]                      Length : 00F8
[9E3h 2531 001h]                    Revision : 03
[9E4h 2532 004h]                  Identifier : 00000000
[9E8h 2536 004h]               Mapping Count : 0000000A
[9ECh 2540 004h]              Mapping Offset : 0000001C

[9F0h 2544 004h]       Flags (decoded below) : 00000011
                         Remapping Permitted : 1
                           Access Privileged : 0
                           Access Attributes : 04
[9F4h 2548 004h]   Number of RMR Descriptors : 00000001
[9F8h 2552 004h]       RMR Descriptor Offset : 000000E4

[AC4h 2756 008h]         Base Address of RMR : 0000000084800000
[ACCh 2764 008h]               Length of RMR : 0000000000800000
[AD4h 2772 004h]                    Reserved : 00000000

[9FCh 2556 004h]                  Input base : 00000000
[A00h 2560 004h]                    ID Count : 00000000
[A04h 2564 004h]                 Output Base : 00000000
[A08h 2568 004h]            Output Reference : 000000DC
[A0Ch 2572 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A10h 2576 004h]                  Input base : 00000000
[A14h 2580 004h]                    ID Count : 00000000
[A18h 2584 004h]                 Output Base : 00000001
[A1Ch 2588 004h]            Output Reference : 000000DC
[A20h 2592 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A24h 2596 004h]                  Input base : 00000000
[A28h 2600 004h]                    ID Count : 00000000
[A2Ch 2604 004h]                 Output Base : 00000006
[A30h 2608 004h]            Output Reference : 000000DC
[A34h 2612 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A38h 2616 004h]                  Input base : 00000000
[A3Ch 2620 004h]                    ID Count : 00000000
[A40h 2624 004h]                 Output Base : 00000007
[A44h 2628 004h]            Output Reference : 000000DC
[A48h 2632 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A4Ch 2636 004h]                  Input base : 00000000
[A50h 2640 004h]                    ID Count : 00000000
[A54h 2644 004h]                 Output Base : 0000000C
[A58h 2648 004h]            Output Reference : 000000DC
[A5Ch 2652 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A60h 2656 004h]                  Input base : 00000000
[A64h 2660 004h]                    ID Count : 00000000
[A68h 2664 004h]                 Output Base : 0000000D
[A6Ch 2668 004h]            Output Reference : 000000DC
[A70h 2672 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A74h 2676 004h]                  Input base : 00000000
[A78h 2680 004h]                    ID Count : 00000000
[A7Ch 2684 004h]                 Output Base : 00000012
[A80h 2688 004h]            Output Reference : 000000DC
[A84h 2692 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A88h 2696 004h]                  Input base : 00000000
[A8Ch 2700 004h]                    ID Count : 00000000
[A90h 2704 004h]                 Output Base : 00000013
[A94h 2708 004h]            Output Reference : 000000DC
[A98h 2712 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[A9Ch 2716 004h]                  Input base : 00000000
[AA0h 2720 004h]                    ID Count : 00000000
[AA4h 2724 004h]                 Output Base : 00000018
[AA8h 2728 004h]            Output Reference : 000000DC
[AACh 2732 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

[AB0h 2736 004h]                  Input base : 00000000
[AB4h 2740 004h]                    ID Count : 00000000
[AB8h 2744 004h]                 Output Base : 00000019
[ABCh 2748 004h]            Output Reference : 000000DC
[AC0h 2752 004h]       Flags (decoded below) : 00000001
                              Single Mapping : 1

Raw Table Data: Length 2776 (0xAD8)

    0000: 49 4F 52 54 D8 0A 00 00 05 7E 43 49 58 54 45 4B  // IORT.....~CIXTEK
    0010: 53 4B 59 31 45 44 4B 32 01 01 00 01 43 49 58 20  // SKY1EDK2....CIX 
    0020: 01 00 00 00 13 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
    0030: 00 18 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0040: 01 00 00 00 00 00 00 00 04 58 00 02 00 00 00 00  // .........X......
    0050: 01 00 00 00 44 00 00 00 00 00 01 0B 00 00 00 00  // ....D...........
    0060: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0070: 00 00 00 00 6B 00 00 00 74 00 00 00 70 00 00 00  // ....k...t...p...
    0080: 6C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // l...............
    0090: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
    00A0: 02 3C 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // .<..........(...
    00B0: 01 00 00 00 00 00 00 03 01 00 00 00 00 00 00 00  // ................
    00C0: 00 00 00 00 00 00 00 00 00 00 00 00 FF FF 00 00  // ................
    00D0: 00 00 00 00 48 00 00 00 00 00 00 00 04 44 00 02  // ....H........D..
    00E0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 1B 0B  // ................
    00F0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0100: 00 00 00 00 00 00 00 00 8D 00 00 00 96 00 00 00  // ................
    0110: 92 00 00 00 8E 00 00 00 00 00 00 00 00 00 00 00  // ................
    0120: 01 A0 00 00 00 00 00 00 05 00 00 00 28 00 00 00  // ............(...
    0130: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0140: 42 5F 2E 44 50 55 30 00 00 00 00 00 00 00 00 00  // B_.DPU0.........
    0150: 00 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0160: 00 00 00 00 01 00 00 00 DC 00 00 00 01 00 00 00  // ................
    0170: 00 00 00 00 00 00 00 00 03 00 00 00 DC 00 00 00  // ................
    0180: 01 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00  // ................
    0190: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    01A0: 05 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    01B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    01C0: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    01D0: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    01E0: 42 5F 2E 41 45 55 30 00 00 00 00 00 00 00 00 00  // B_.AEU0.........
    01F0: 02 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0260: 01 A0 00 00 00 00 00 00 05 00 00 00 28 00 00 00  // ............(...
    0270: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0280: 42 5F 2E 44 50 55 31 00 00 00 00 00 00 00 00 00  // B_.DPU1.........
    0290: 06 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    02A0: 00 00 00 00 07 00 00 00 DC 00 00 00 01 00 00 00  // ................
    02B0: 00 00 00 00 00 00 00 00 09 00 00 00 DC 00 00 00  // ................
    02C0: 01 00 00 00 00 00 00 00 00 00 00 00 0A 00 00 00  // ................
    02D0: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    02E0: 0B 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    02F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0300: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    0310: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0320: 42 5F 2E 41 45 55 31 00 00 00 00 00 00 00 00 00  // B_.AEU1.........
    0330: 08 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    03A0: 01 A0 00 00 00 00 00 00 05 00 00 00 28 00 00 00  // ............(...
    03B0: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    03C0: 42 5F 2E 44 50 55 32 00 00 00 00 00 00 00 00 00  // B_.DPU2.........
    03D0: 0C 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    03E0: 00 00 00 00 0D 00 00 00 DC 00 00 00 01 00 00 00  // ................
    03F0: 00 00 00 00 00 00 00 00 0F 00 00 00 DC 00 00 00  // ................
    0400: 01 00 00 00 00 00 00 00 00 00 00 00 10 00 00 00  // ................
    0410: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0420: 11 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0440: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    0450: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0460: 42 5F 2E 41 45 55 32 00 00 00 00 00 00 00 00 00  // B_.AEU2.........
    0470: 0E 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    04A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    04B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    04C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    04D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    04E0: 01 A0 00 00 00 00 00 00 05 00 00 00 28 00 00 00  // ............(...
    04F0: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0500: 42 5F 2E 44 50 55 33 00 00 00 00 00 00 00 00 00  // B_.DPU3.........
    0510: 12 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0520: 00 00 00 00 13 00 00 00 DC 00 00 00 01 00 00 00  // ................
    0530: 00 00 00 00 00 00 00 00 15 00 00 00 DC 00 00 00  // ................
    0540: 01 00 00 00 00 00 00 00 00 00 00 00 16 00 00 00  // ................
    0550: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0560: 17 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0580: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    0590: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    05A0: 42 5F 2E 41 45 55 33 00 00 00 00 00 00 00 00 00  // B_.AEU3.........
    05B0: 14 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    05C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0620: 01 A0 00 00 00 00 00 00 05 00 00 00 28 00 00 00  // ............(...
    0630: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0640: 42 5F 2E 44 50 55 34 00 00 00 00 00 00 00 00 00  // B_.DPU4.........
    0650: 18 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0660: 00 00 00 00 19 00 00 00 DC 00 00 00 01 00 00 00  // ................
    0670: 00 00 00 00 00 00 00 00 1B 00 00 00 DC 00 00 00  // ................
    0680: 01 00 00 00 00 00 00 00 00 00 00 00 1C 00 00 00  // ................
    0690: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    06A0: 1D 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    06B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06C0: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    06D0: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    06E0: 42 5F 2E 41 45 55 34 00 00 00 00 00 00 00 00 00  // B_.AEU4.........
    06F0: 1A 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0760: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    0770: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0780: 42 5F 2E 4E 50 55 30 00 00 00 00 00 00 00 00 00  // B_.NPU0.........
    0790: 1E 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    07A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    07B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    07C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    07D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    07E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    07F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0800: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    0810: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0820: 42 5F 2E 49 53 50 4D 00 00 00 00 00 00 00 00 00  // B_.ISPM.........
    0830: 1F 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    08A0: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    08B0: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    08C0: 42 5F 2E 43 42 44 30 00 00 00 00 00 00 00 00 00  // B_.CBD0.........
    08D0: 21 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // !...............
    08E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    08F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0940: 01 A0 00 00 00 00 00 00 01 00 00 00 28 00 00 00  // ............(...
    0950: 00 00 00 00 01 00 00 00 00 00 00 03 28 5C 5F 53  // ............(\_S
    0960: 42 5F 2E 43 42 44 32 00 00 00 00 00 00 00 00 00  // B_.CBD2.........
    0970: 22 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // "...............
    0980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09E0: 06 F8 00 03 00 00 00 00 0A 00 00 00 1C 00 00 00  // ................
    09F0: 11 00 00 00 01 00 00 00 E4 00 00 00 00 00 00 00  // ................
    0A00: 00 00 00 00 00 00 00 00 DC 00 00 00 01 00 00 00  // ................
    0A10: 00 00 00 00 00 00 00 00 01 00 00 00 DC 00 00 00  // ................
    0A20: 01 00 00 00 00 00 00 00 00 00 00 00 06 00 00 00  // ................
    0A30: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A40: 07 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0A50: 00 00 00 00 0C 00 00 00 DC 00 00 00 01 00 00 00  // ................
    0A60: 00 00 00 00 00 00 00 00 0D 00 00 00 DC 00 00 00  // ................
    0A70: 01 00 00 00 00 00 00 00 00 00 00 00 12 00 00 00  // ................
    0A80: DC 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A90: 13 00 00 00 DC 00 00 00 01 00 00 00 00 00 00 00  // ................
    0AA0: 00 00 00 00 18 00 00 00 DC 00 00 00 01 00 00 00  // ................
    0AB0: 00 00 00 00 00 00 00 00 19 00 00 00 DC 00 00 00  // ................
    0AC0: 01 00 00 00 00 00 80 84 00 00 00 00 00 00 80 00  // ................
    0AD0: 00 00 00 00 00 00 00 00                          // ........
