/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ssdt2.dat
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000011FC (4604)
 *     Revision         0x02
 *     Checksum         0xEA
 *     OEM ID           "CIXTEK"
 *     OEM Table ID     "SKY1EDK2"
 *     OEM Revision     0x01000101 (16777473)
 *     Compiler ID      "CIX "
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("", "SSDT", 2, "CIXTEK", "SKY1EDK2", 0x01000101)
{
    External (_SB_.LPIB, IntObj)
    External (_SB_.LPIL, IntObj)

    Scope (\_SB)
    {
        Device (CPU0)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x2000, 
                0x2000, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000000659009C, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x09C4
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x04, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPU1)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIL) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x0911, 
                0x0911, 
                0x0407, 
                0x0407, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000006590094, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0709
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x02, 
                    0xFD, 
                    0x04
                }
            })
        }

        Device (CPU2)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIL) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x0911, 
                0x0911, 
                0x0407, 
                0x0407, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000006590094, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0709
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x02, 
                    0xFD, 
                    0x04
                }
            })
        }

        Device (CPU3)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIL) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x0911, 
                0x0911, 
                0x0407, 
                0x0407, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000006590094, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0709
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x02, 
                    0xFD, 
                    0x04
                }
            })
        }

        Device (CPU4)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIL) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x0911, 
                0x0911, 
                0x0407, 
                0x0407, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000006590094, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0709
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x02, 
                    0xFD, 
                    0x04
                }
            })
        }

        Device (CPU5)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x1D70, 
                0x1D70, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000065900A0, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x08FC
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x05, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPU6)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x1D70, 
                0x1D70, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000065900A0, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x08FC
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x05, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPU7)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x1C28, 
                0x1C28, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000065900A4, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0898
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x06, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPU8)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x1C28, 
                0x1C28, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000065900A4, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0898
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x06, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPU9)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x1EB8, 
                0x1EB8, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000006590098, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0960
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x03, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPUA)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x0A)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x1EB8, 
                0x1EB8, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000006590098, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x0960
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x03, 
                    0xFD, 
                    0x02
                }
            })
        }

        Device (CPUB)
        {
            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
            Name (_UID, 0x0B)  // _UID: Unique ID
            Method (_LPI, 0, NotSerialized)  // _LPI: Low Power Idle States
            {
                Return (\_SB.LPIB) /* External reference */
            }

            Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Control
            {
                0x17, 
                0x03, 
                0x2000, 
                0x2000, 
                0x0A3D, 
                0x0A3D, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x000000000659009C, // Address
                        0x03,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000001, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x40,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        0x04,               // Access Size
                        )
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                Zero, 
                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemMemory, 
                        0x00,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000000000, // Address
                        ,)
                }, 

                0x03E8, 
                0x0320, 
                0x09C4
            })
            Name (_PSD, Package (0x01)  // _PSD: Power State Dependencies
            {
                Package (0x05)
                {
                    0x05, 
                    Zero, 
                    0x04, 
                    0xFD, 
                    0x02
                }
            })
        }

        Name (CPL0, Package (0x04)
        {
            \_SB.CPU1, 
            \_SB.CPU2, 
            \_SB.CPU3, 
            \_SB.CPU4
        })
        Name (CPM0, Package (0x02)
        {
            \_SB.CPU5, 
            \_SB.CPU6
        })
        Name (CPM1, Package (0x02)
        {
            \_SB.CPU7, 
            \_SB.CPU8
        })
        Name (CPB0, Package (0x02)
        {
            \_SB.CPU9, 
            \_SB.CPUA
        })
        Name (CPB1, Package (0x02)
        {
            \_SB.CPU0, 
            \_SB.CPUB
        })
        Name (CPUL, Package (0x0C)
        {
            \_SB.CPU0, 
            \_SB.CPU1, 
            \_SB.CPU2, 
            \_SB.CPU3, 
            \_SB.CPU4, 
            \_SB.CPU5, 
            \_SB.CPU6, 
            \_SB.CPU7, 
            \_SB.CPU8, 
            \_SB.CPU9, 
            \_SB.CPUA, 
            \_SB.CPUB
        })
    }
}

