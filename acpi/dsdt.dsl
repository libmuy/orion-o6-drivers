/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of dsdt.dat
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00012C20 (76832)
 *     Revision         0x05
 *     Checksum         0x39
 *     OEM ID           "CIXTEK"
 *     OEM Table ID     "SKY1EDK2"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "DSDT", 5, "CIXTEK", "SKY1EDK2", 0x00000001)
{
    External (_SB_.CPU0, UnknownObj)
    External (_SB_.I2C1.PD10, UnknownObj)
    External (_SB_.I2C1.PD11, UnknownObj)
    External (_SB_.I2C7.PD00, UnknownObj)
    External (_SB_.I2C7.PD01, UnknownObj)

    Scope (_SB)
    {
        Mutex (DBGM, 0x00)
        Method (UDBG, 1, Serialized)
        {
            OperationRegion (COMA, SystemMemory, 0x040E0000, 0x0100)
            Field (COMA, ByteAcc, NoLock, Preserve)
            {
                UTXD,   8, 
                Offset (0x18), 
                UTS,    8
            }

            ToHexString (Arg0, Local0)
            Local1 = SizeOf (Local0)
            Local2 = Zero
            Acquire (DBGM, 0xFFFF)
            While ((Local2 < Local1))
            {
                Local3 = Zero
                While ((Local3 < 0x00989680))
                {
                    If (((UTS & 0x20) == Zero))
                    {
                        Break
                    }

                    Local3++
                }

                Mid (Local0, Local2, One, UTXD) /* \_SB_.UDBG.UTXD */
                Local2++
            }

            UTXD = 0x0D
            UTXD = 0x0A
            Release (DBGM)
        }

        Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
        {
            CreateDWordField (Arg3, Zero, STS0)
            CreateDWordField (Arg3, 0x04, CAP0)
            If ((Arg0 == ToUUID ("0811b06e-4a27-44f9-8d60-3cbbc22e7b48") /* Platform-wide Capabilities */))
            {
                If ((Arg1 == One))
                {
                    STS0 &= 0xFFFFFFFFFFFFFFE0
                    If ((CAP0 & 0x0100))
                    {
                        CAP0 &= 0xFFFFFFFFFFFFFEFF
                        STS0 |= 0x10
                    }

                    If ((CAP0 & 0x20))
                    {
                        CAP0 &= 0xFFFFFFFFFFFFFFDF
                        STS0 |= 0x10
                    }
                }
                Else
                {
                    STS0 &= 0xFFFFFFFFFFFFFFE0
                    STS0 |= 0x0A
                }
            }
            Else
            {
                STS0 &= 0xFFFFFFFFFFFFFFE0
                STS0 |= 0x06
            }

            Return (Arg3)
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            ULPI ()
        }

        Method (ULPI, 0, NotSerialized)
        {
            Local0 = GETV (0x1F)
            Local1 = GETV (0x20)
            Local2 = GETV (0x21)
            DerefOf (LPIB [0x03]) [0x02] = Local0
            DerefOf (LPIL [0x03]) [0x02] = Local0
            DerefOf (LPIB [0x04]) [0x02] = Local1
            DerefOf (LPIL [0x04]) [0x02] = Local1
            DerefOf (LPIB [0x05]) [0x02] = Local2
            DerefOf (LPIL [0x05]) [0x02] = Local2
        }

        Name (LPIB, Package (0x06)
        {
            Zero, 
            Zero, 
            0x03, 
            Package (0x0A)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000FFFFFFFF, // Address
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

                "Standby"
            }, 

            Package (0x0A)
            {
                0x0BB8, 
                0x0168, 
                Zero, 
                One, 
                Zero, 
                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000010000, // Address
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

                "Powerdown"
            }, 

            Package (0x0A)
            {
                0x2710, 
                0x01F4, 
                Zero, 
                One, 
                Zero, 
                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000001010000, // Address
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

                "ClusterPD"
            }
        })
        Name (LPIL, Package (0x06)
        {
            Zero, 
            Zero, 
            0x03, 
            Package (0x0A)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x00000000FFFFFFFF, // Address
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

                "Standby"
            }, 

            Package (0x0A)
            {
                0x0BB8, 
                0x0168, 
                Zero, 
                One, 
                Zero, 
                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000000010000, // Address
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

                "Powerdown"
            }, 

            Package (0x0A)
            {
                0x2710, 
                0x01F4, 
                Zero, 
                One, 
                Zero, 
                Zero, 
                ResourceTemplate ()
                {
                    Register (FFixedHW, 
                        0x20,               // Bit Width
                        0x00,               // Bit Offset
                        0x0000000001010000, // Address
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

                "ClusterPD"
            }
        })
        Device (MUX0)
        {
            Name (_HID, "CIXHA016")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04170000,         // Address Base
                    0x00001000,         // Address Length
                    )
                PinGroup ("pinctrl_sndcard", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x02, 0x00, 0x00, 0x24, 0x02, 0x04, 0x00, 0x24, 
                        0x02, 0x08, 0x00, 0x24, 0x02, 0x0C, 0x00, 0x24
                    })
                    {   // Pin list
                        0x0080,
                        0x0081,
                        0x0082,
                        0x0083
                    }
                PinGroup ("pinctrl_fch_pwm0", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x50, 0x00, 0x07
                    })
                    {   // Pin list
                        0x0014
                    }
                PinGroup ("pinctrl_fch_pwm1", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x01, 0x3C, 0x00, 0xB7
                    })
                    {   // Pin list
                        0x004F
                    }
                PinGroup ("pinctrl_edp0", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x48, 0x00, 0x24, 0x00, 0x4C, 0x00, 0x24
                    })
                    {   // Pin list
                        0x0012,
                        0x0013
                    }
                PinGroup ("pinctrl_cam0_hw", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x01, 0x94, 0x00, 0x3C, 0x01, 0x1C, 0x00, 0x9C, 
                        0x01, 0x28, 0x00, 0x1C, 0x01, 0x2C, 0x00, 0x0C, 
                        0x01, 0x34, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0065,
                        0x0047,
                        0x004A,
                        0x004B,
                        0x004D
                    }
                PinGroup ("pinctrl_cam1_hw", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x01, 0x98, 0x00, 0x3C, 0x01, 0x30, 0x00, 0x1C, 
                        0x01, 0x38, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0066,
                        0x004C,
                        0x004E
                    }
                PinGroup ("pinctrl_cam2_hw", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x01, 0x9C, 0x00, 0x3C, 0x01, 0x0C, 0x00, 0x9C, 
                        0x01, 0x18, 0x00, 0xBC, 0x01, 0x14, 0x00, 0xBC, 
                        0x01, 0x08, 0x00, 0xBC
                    })
                    {   // Pin list
                        0x0067,
                        0x0043,
                        0x0046,
                        0x0045,
                        0x0042
                    }
                PinGroup ("pinctrl_cam3_hw", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x01, 0xA0, 0x00, 0x3C, 0x01, 0x20, 0x00, 0xBC, 
                        0x01, 0x24, 0x00, 0xBC
                    })
                    {   // Pin list
                        0x0068,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_lt7911_hw", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x01, 0x1C, 0x00, 0x8C, 0x01, 0x28, 0x00, 0x0C, 
                        0x01, 0x2C, 0x00, 0x0C, 0x01, 0x34, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0047,
                        0x004A,
                        0x004B,
                        0x004D
                    }
                PinGroup ("gmac0", ResourceProducer, ,
                    RawDataBuffer (0x3C)  // Vendor Data
                    {
                        0x01, 0xA4, 0x00, 0x9C, 0x01, 0xA8, 0x00, 0x9C, 
                        0x01, 0xAC, 0x00, 0x9C, 0x01, 0xB0, 0x00, 0x9C, 
                        0x01, 0xB4, 0x00, 0x9C, 0x01, 0xB8, 0x00, 0x9C, 
                        0x01, 0xBC, 0x00, 0x94, 0x01, 0xC0, 0x00, 0x94, 
                        0x01, 0xC4, 0x00, 0x94, 0x01, 0xC8, 0x00, 0x94, 
                        0x01, 0xCC, 0x00, 0x94, 0x01, 0xD0, 0x00, 0x94, 
                        0x01, 0xD4, 0x00, 0x94, 0x01, 0xD8, 0x00, 0x9C, 
                        0x01, 0xDC, 0x00, 0x9C
                    })
                    {   // Pin list
                        0x0069,
                        0x006A,
                        0x006B,
                        0x006C,
                        0x006D,
                        0x006E,
                        0x006F,
                        0x0070,
                        0x0071,
                        0x0072,
                        0x0073,
                        0x0074,
                        0x0075,
                        0x0076,
                        0x0077
                    }
                PinGroup ("gmac0-init", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x01, 0xD8, 0x00, 0x9C, 0x01, 0xDC, 0x00, 0x9C
                    })
                    {   // Pin list
                        0x0076,
                        0x0077
                    }
                PinGroup ("pinctrl_fch_i2c0", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x78, 0x00, 0x47, 0x00, 0x7C, 0x00, 0x47
                    })
                    {   // Pin list
                        0x001E,
                        0x001F
                    }
                PinGroup ("pinctrl_fch_i2c2", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x88, 0x00, 0x5C, 0x00, 0x8C, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0022,
                        0x0023
                    }
                PinGroup ("pinctrl_fch_spi1", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x01, 0xE8, 0x01, 0x5C, 0x01, 0xEC, 0x01, 0x5C, 
                        0x01, 0xF0, 0x01, 0x5C, 0x01, 0xF4, 0x01, 0x5C, 
                        0x01, 0xF8, 0x01, 0x1C
                    })
                    {   // Pin list
                        0x007A,
                        0x007B,
                        0x007C,
                        0x007D,
                        0x007E
                    }
                PinGroup ("pinctrl_fch_uart0", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x01, 0x3C, 0x00, 0x37, 0x01, 0x40, 0x00, 0x37, 
                        0x01, 0x44, 0x00, 0x37, 0x01, 0x48, 0x00, 0x37
                    })
                    {   // Pin list
                        0x004F,
                        0x0050,
                        0x0051,
                        0x0052
                    }
                PinGroup ("pinctrl_fch_uart1", ResourceProducer, ,
                    RawDataBuffer (0x10)  // Vendor Data
                    {
                        0x01, 0x4C, 0x00, 0x37, 0x01, 0x50, 0x00, 0x37, 
                        0x01, 0x54, 0x00, 0x37, 0x01, 0x58, 0x00, 0x37
                    })
                    {   // Pin list
                        0x0053,
                        0x0054,
                        0x0055,
                        0x0056
                    }
                PinGroup ("pinctrl_fch_uart2", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x01, 0x5C, 0x00, 0x27, 0x01, 0x60, 0x00, 0x27
                    })
                    {   // Pin list
                        0x0057,
                        0x0058
                    }
                PinGroup ("pinctrl_hda", ResourceProducer, ,
                    RawDataBuffer (0x1C)  // Vendor Data
                    {
                        0x00, 0xA8, 0x00, 0x3C, 0x00, 0xAC, 0x00, 0x3C, 
                        0x00, 0xB0, 0x00, 0x3C, 0x00, 0xB4, 0x00, 0x5C, 
                        0x00, 0xB8, 0x00, 0x5C, 0x00, 0xBC, 0x00, 0x3C, 
                        0x00, 0xC0, 0x00, 0x3C
                    })
                    {   // Pin list
                        0x002A,
                        0x002B,
                        0x002C,
                        0x002D,
                        0x002E,
                        0x002F,
                        0x0030
                    }
                PinGroup ("pinctrl_substrate_i2s0", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x00, 0xA8, 0x00, 0xBC, 0x00, 0xAC, 0x00, 0xBC, 
                        0x00, 0xB0, 0x00, 0xBC, 0x00, 0xB4, 0x00, 0xDC, 
                        0x00, 0xB8, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x002A,
                        0x002B,
                        0x002C,
                        0x002D,
                        0x002E
                    }
                PinGroup ("pinctrl_substrate_i2s1", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x00, 0xC4, 0x00, 0x3C, 0x00, 0xC8, 0x00, 0x3C, 
                        0x00, 0xCC, 0x00, 0x5C, 0x00, 0xD0, 0x00, 0x3C, 
                        0x00, 0xD4, 0x00, 0x3C
                    })
                    {   // Pin list
                        0x0031,
                        0x0032,
                        0x0033,
                        0x0034,
                        0x0035
                    }
                PinGroup ("pinctrl_substrate_i2s2", ResourceProducer, ,
                    RawDataBuffer (0x2C)  // Vendor Data
                    {
                        0x00, 0xD8, 0x00, 0x3C, 0x00, 0xDC, 0x00, 0x3C, 
                        0x00, 0xE0, 0x00, 0x5C, 0x00, 0xE4, 0x00, 0x3C, 
                        0x00, 0xE8, 0x00, 0x5C, 0x00, 0xEC, 0x00, 0x3C, 
                        0x00, 0xF0, 0x00, 0x3C, 0x00, 0xF4, 0x00, 0x5C, 
                        0x00, 0xF8, 0x00, 0x5C, 0x00, 0xFC, 0x00, 0x5C, 
                        0x01, 0x00, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0036,
                        0x0037,
                        0x0038,
                        0x0039,
                        0x003A,
                        0x003B,
                        0x003C,
                        0x003D,
                        0x003E,
                        0x003F,
                        0x0040
                    }
                PinGroup ("pinctrl_substrate_i2s3", ResourceProducer, ,
                    RawDataBuffer (0x24)  // Vendor Data
                    {
                        0x01, 0x04, 0x00, 0x3C, 0x01, 0x08, 0x00, 0x3C, 
                        0x01, 0x0C, 0x00, 0x5C, 0x01, 0x10, 0x00, 0x3C, 
                        0x01, 0x14, 0x00, 0x5C, 0x01, 0x18, 0x00, 0x3C, 
                        0x01, 0x1C, 0x00, 0x3C, 0x01, 0x20, 0x00, 0x5C, 
                        0x01, 0x24, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x0041,
                        0x0042,
                        0x0043,
                        0x0044,
                        0x0045,
                        0x0046,
                        0x0047,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_substrate_i2s4", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x01, 0x28, 0x00, 0x9C, 0x01, 0x2C, 0x00, 0x9C, 
                        0x01, 0x30, 0x00, 0x9C, 0x01, 0x34, 0x00, 0x9C, 
                        0x01, 0x38, 0x00, 0x9C
                    })
                    {   // Pin list
                        0x004A,
                        0x004B,
                        0x004C,
                        0x004D,
                        0x004E
                    }
                PinGroup ("pinctrl_substrate_i2s5", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x00, 0xDC, 0x01, 0x3C, 0x00, 0xE0, 0x01, 0x5C, 
                        0x00, 0xE4, 0x01, 0x3C, 0x00, 0xE8, 0x01, 0x3C, 
                        0x00, 0xEC, 0x01, 0x3C, 0x00, 0xF0, 0x01, 0x3C, 
                        0x00, 0xF4, 0x01, 0x5C, 0x00, 0xF8, 0x01, 0x5C
                    })
                    {   // Pin list
                        0x0037,
                        0x0038,
                        0x0039,
                        0x003A,
                        0x003B,
                        0x003C,
                        0x003D,
                        0x003E
                    }
                PinGroup ("pinctrl_substrate_i2s6", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x00, 0xDC, 0x01, 0xBC, 0x00, 0xE0, 0x01, 0xDC, 
                        0x00, 0xE4, 0x01, 0xBC, 0x00, 0xE8, 0x01, 0xBC, 
                        0x00, 0xEC, 0x01, 0xBC, 0x00, 0xF0, 0x01, 0xBC, 
                        0x00, 0xF4, 0x01, 0xDC, 0x00, 0xF8, 0x01, 0xDC
                    })
                    {   // Pin list
                        0x0037,
                        0x0038,
                        0x0039,
                        0x003A,
                        0x003B,
                        0x003C,
                        0x003D,
                        0x003E
                    }
                PinGroup ("pinctrl_substrate_i2s7", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x01, 0x08, 0x01, 0x3C, 0x01, 0x0C, 0x01, 0x5C, 
                        0x01, 0x10, 0x01, 0x3C, 0x01, 0x14, 0x01, 0x5C, 
                        0x01, 0x18, 0x01, 0x3C, 0x01, 0x1C, 0x01, 0x3C, 
                        0x01, 0x20, 0x01, 0x5C, 0x01, 0x24, 0x01, 0x5C
                    })
                    {   // Pin list
                        0x0042,
                        0x0043,
                        0x0044,
                        0x0045,
                        0x0046,
                        0x0047,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_substrate_i2s8", ResourceProducer, ,
                    RawDataBuffer (0x20)  // Vendor Data
                    {
                        0x01, 0x08, 0x01, 0xBC, 0x01, 0x0C, 0x01, 0xDC, 
                        0x01, 0x10, 0x01, 0xBC, 0x01, 0x14, 0x01, 0xDC, 
                        0x01, 0x18, 0x01, 0xBC, 0x01, 0x1C, 0x01, 0xBC, 
                        0x01, 0x20, 0x01, 0xDC, 0x01, 0x24, 0x01, 0xDC
                    })
                    {   // Pin list
                        0x0042,
                        0x0043,
                        0x0044,
                        0x0045,
                        0x0046,
                        0x0047,
                        0x0048,
                        0x0049
                    }
                PinGroup ("pinctrl_alc5682_irq", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x02, 0x14, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x0085
                    }
                PinGroup ("pinctrl_fch_i3c0", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x00, 0x88, 0x00, 0xDC, 0x00, 0x8C, 0x00, 0xDC, 
                        0x00, 0x90, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x0022,
                        0x0023,
                        0x0024
                    }
                PinGroup ("pinctrl_fch_i3c1", ResourceProducer, ,
                    RawDataBuffer (0x0C)  // Vendor Data
                    {
                        0x00, 0x94, 0x00, 0xDC, 0x00, 0x98, 0x00, 0xDC, 
                        0x00, 0x9C, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x0025,
                        0x0026,
                        0x0027
                    }
            })
        }

        Device (MUX1)
        {
            Name (_HID, "CIXHA017")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16007000,         // Address Base
                    0x00001000,         // Address Length
                    )
                PinGroup ("wifi_vbat_gpio", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x30, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x000C
                    }
                PinGroup ("i2c0_grp", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x70, 0x00, 0x5C, 0x00, 0x74, 0x00, 0x5C
                    })
                    {   // Pin list
                        0x001C,
                        0x001D
                    }
                PinGroup ("i2c1_grp", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0x78, 0x00, 0x57, 0x00, 0x7C, 0x00, 0x57
                    })
                    {   // Pin list
                        0x001E,
                        0x001F
                    }
                PinGroup ("pinctrl_fch_spi0", ResourceProducer, ,
                    RawDataBuffer (0x14)  // Vendor Data
                    {
                        0x00, 0xA8, 0x00, 0x5C, 0x00, 0xAC, 0x00, 0x5C, 
                        0x00, 0xB0, 0x00, 0x5C, 0x00, 0xB4, 0x00, 0x5C, 
                        0x00, 0xB8, 0x00, 0x1C
                    })
                    {   // Pin list
                        0x002A,
                        0x002B,
                        0x002C,
                        0x002D,
                        0x002E
                    }
                PinGroup ("pinctrl_fch_xspi", ResourceProducer, ,
                    RawDataBuffer (0x18)  // Vendor Data
                    {
                        0x00, 0xF0, 0x00, 0xDC, 0x00, 0xF4, 0x00, 0xDC, 
                        0x00, 0xF8, 0x00, 0xDC, 0x00, 0xFC, 0x00, 0xDC, 
                        0x01, 0x00, 0x00, 0xDC, 0x01, 0x04, 0x00, 0xDC
                    })
                    {   // Pin list
                        0x003C,
                        0x003D,
                        0x003E,
                        0x003F,
                        0x0040,
                        0x0041
                    }
                PinGroup ("pinctrl_usb0", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xD4, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0035
                    }
                PinGroup ("pinctrl_usb1", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xD8, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0036
                    }
                PinGroup ("pinctrl_usb2", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xDC, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0037
                    }
                PinGroup ("pinctrl_usb3", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xE0, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0038
                    }
                PinGroup ("pinctrl_usb4", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0xCC, 0x00, 0x44, 0x00, 0xE8, 0x00, 0xA4
                    })
                    {   // Pin list
                        0x0033,
                        0x003A
                    }
                PinGroup ("pinctrl_usb5", ResourceProducer, ,
                    RawDataBuffer (0x08)  // Vendor Data
                    {
                        0x00, 0xD0, 0x00, 0x44, 0x00, 0xEC, 0x00, 0xA4
                    })
                    {   // Pin list
                        0x0034,
                        0x003B
                    }
                PinGroup ("pinctrl_usb6", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xBC, 0x00, 0x44
                    })
                    {   // Pin list
                        0x002F
                    }
                PinGroup ("pinctrl_usb7", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xC0, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0030
                    }
                PinGroup ("pinctrl_usb8", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xC4, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0031
                    }
                PinGroup ("pinctrl_usb9", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0xC8, 0x00, 0x44
                    })
                    {   // Pin list
                        0x0032
                    }
                PinGroup ("pinctrl_ra8900ce_irq", ResourceProducer, ,
                    RawDataBuffer (0x04)  // Vendor Data
                    {
                        0x00, 0x28, 0x00, 0x44
                    })
                    {   // Pin list
                        0x000A
                    }
            })
        }

        OperationRegion (DBGR, SystemMemory, 0x05040100, 0x20)
        Field (DBGR, DWordAcc, NoLock, Preserve)
        {
            UCLK,   32
        }

        Device (UCRU)
        {
            Name (_HID, "CIXHA018")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0416009C,         // Address Base
                    0x00000080,         // Address Length
                    )
            })
        }

        Device (COM0)
        {
            Name (_HID, "ARMH0011")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x040B0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000148,
                }
                FixedDMA (0x0000, 0x0002, Width32bit, )
                FixedDMA (0x0001, 0x0003, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_uart0", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "uartclk", 
                        UCLK
                    }, 

                    Package (0x02)
                    {
                        "timeout-value", 
                        0x2710
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x02)
                        {
                            "tx", 
                            "rx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "sky1,fch_cru", 
                        UCRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xF6, 
                    "apb_pclk", 
                    COM0
                }, 

                Package (0x03)
                {
                    0x0107, 
                    "uartclk", 
                    COM0
                }
            })
        }

        Device (COM1)
        {
            Name (_HID, "ARMH0011")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x040C0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000149,
                }
                FixedDMA (0x0002, 0x0004, Width32bit, )
                FixedDMA (0x0003, 0x0005, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_uart1", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "uartclk", 
                        UCLK
                    }, 

                    Package (0x02)
                    {
                        "timeout-value", 
                        0x2710
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x02)
                        {
                            "tx", 
                            "rx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "sky1,fch_cru", 
                        UCRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xF7, 
                    "apb_pclk", 
                    COM1
                }, 

                Package (0x03)
                {
                    0x0108, 
                    "uartclk", 
                    COM1
                }
            })
        }

        Device (COM2)
        {
            Name (_HID, "ARMH0011")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x040D0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000014A,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_uart2", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "uartclk", 
                        UCLK
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xF8, 
                    "apb_pclk", 
                    COM2
                }, 

                Package (0x03)
                {
                    0x0109, 
                    "uartclk", 
                    COM2
                }
            })
        }

        Device (COM3)
        {
            Name (_HID, "ARMH0011")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x040E0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000014B,
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xF9, 
                    "apb_pclk", 
                    COM3
                }, 

                Package (0x03)
                {
                    0x010A, 
                    "uartclk", 
                    COM3
                }
            })
        }

        Device (DSTD)
        {
            Name (_HID, "PRP0001")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x83000000,         // Address Base
                    0x00400000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x0C)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "cix,dst"
                    }, 

                    Package (0x02)
                    {
                        "ramlog_addr", 
                        0x83DA0000
                    }, 

                    Package (0x02)
                    {
                        "ramlog_size", 
                        0x00040000
                    }, 

                    Package (0x02)
                    {
                        "rdr-log-max-size", 
                        0x00800000
                    }, 

                    Package (0x02)
                    {
                        "rdr_area_num", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "rdr_area_sizes", 
                        Package (0x0F)
                        {
                            0x00100000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000, 
                            0x00010000
                        }
                    }, 

                    Package (0x02)
                    {
                        "rdr_area_sizes", 
                        0x00040000
                    }, 

                    Package (0x02)
                    {
                        "rdr-log-max-nums", 
                        0x06
                    }, 

                    Package (0x02)
                    {
                        "wait-dumplog-timeout", 
                        0x03E8
                    }, 

                    Package (0x02)
                    {
                        "unexpected-max-reboot-times", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "rdr-dumpctl", 
                        "1111111111"
                    }, 

                    Package (0x02)
                    {
                        "ramlog_size2", 
                        0x00040000
                    }
                }
            })
            Device (EXTR)
            {
                Name (_HID, "PRP0001")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "compatible", 
                            "rdr,exceptiontrace"
                        }, 

                        Package (0x02)
                        {
                            "area_num", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "area_sizes", 
                            0x1000
                        }
                    }
                })
            }

            Device (APAD)
            {
                Name (_HID, "PRP0001")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x83DE0000,         // Address Base
                        0x00020000,         // Address Length
                        )
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x13)
                    {
                        Package (0x02)
                        {
                            "compatible", 
                            "rdr,rdr_ap_adapter"
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_irq_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_task_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_cpu_idle_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_worker_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_time_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_cpu_on_off_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_syscall_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_hung_task_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_trace_tasklet_size", 
                            0x00010000
                        }, 

                        Package (0x02)
                        {
                            "ap_last_task_switch", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "mntndump_addr", 
                            0x83DE0000
                        }, 

                        Package (0x02)
                        {
                            "mntndump_size", 
                            0x00020000
                        }, 

                        Package (0x02)
                        {
                            "ap_dump_mem_modu_test_size", 
                            0x0400
                        }, 

                        Package (0x02)
                        {
                            "ap_dump_mem_modu_idm_size", 
                            0x1000
                        }, 

                        Package (0x02)
                        {
                            "ap_dump_mem_modu_tzc400_size", 
                            0x1000
                        }, 

                        Package (0x02)
                        {
                            "ap_dump_mem_modu_smmu_size", 
                            0x1000
                        }, 

                        Package (0x02)
                        {
                            "ap_dump_mem_modu_tfa_size", 
                            0x4000
                        }, 

                        Package (0x02)
                        {
                            "ap_dump_mem_modu_gap_size", 
                            0x0100
                        }
                    }
                })
            }
        }

        Device (PDC0)
        {
            Name (_HID, "CIXHA019")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16000000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
        }

        Device (MBX0)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x05060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000019A,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX1)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x05070000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000019B,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX2)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x080A0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001A8,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX3)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x08090000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001A7,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX4)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07100000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000109,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX5)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x070F0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000108,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX6)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x06590000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000018B,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (MBX7)
        {
            Name (_HID, "CIXHA001")  // _HID: Hardware ID
            Name (_CID, "CIXHA001")  // _CID: Compatible ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x065A0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000187,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix,mbox_dir", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "#mbox-cells", 
                        One
                    }
                }
            })
        }

        Device (CCLK)
        {
            Name (_HID, "CIXHA010")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (CLKT, Package (0x00){})
            Method (GCLK, 1, Serialized)
            {
                Return (^^PMMX.CLKG (Arg0))
            }

            Method (SCLK, 3, Serialized)
            {
                Return (^^PMMX.CLKS (Arg0, Arg1, Arg2))
            }

            Method (CLKD, 2, Serialized)
            {
                Return (^^PMMX.CLKD (Arg0, Arg1))
            }

            Method (CLKC, 2, Serialized)
            {
                Return (^^PMMX.CLKC (Arg0, Arg1))
            }
        }

        Device (REST)
        {
            Name (_HID, "CIXA1019")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (RSVL, Package (0x03)
            {
                Package (0x04)
                {
                    0xD0000000, 
                    0x00E00000, 
                    "no-map", 
                    DMA1
                }, 

                Package (0x04)
                {
                    0xD0000000, 
                    0x00E00000, 
                    "no-map", 
                    HDA
                }, 

                Package (0x04)
                {
                    0xCDE08000, 
                    0x00100000, 
                    "no-map", 
                    DSP
                }
            })
            Name (RSTL, Package (0x00){})
            Name (IRQL, Package (0x00){})
            Name (DLKL, Package (0x00){})
        }

        Device (RST0)
        {
            Name (_HID, "CIXHA020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16000000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
        }

        Device (RST1)
        {
            Name (_HID, "CIXHA021")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04160000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
        }

        Device (CRU0)
        {
            Name (_HID, "CIXHA018")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16000000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
        }

        Device (GCRU)
        {
            Name (_HID, "CIXHA018")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09310000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
        }

        Device (MAC0)
        {
            Name (_HID, "CIXH7020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09320000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000177,
                    0x00000178,
                    0x00000179,
                    0x0000017A,
                    0x0000017B,
                    0x0000017C,
                    0x0000017D,
                    0x0000017E,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "gmac0", ResourceConsumer, ,
                    RawDataBuffer (0x01)  // Vendor Data
                    {
                        0x00
                    })
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "gmac0-init", ResourceConsumer, ,
                    RawDataBuffer (0x01)  // Vendor Data
                    {
                        0x01
                    })
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            Device (PHY0)
            {
                Name (_ADR, One)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "compatible", 
                            "ethernet-phy-ieee802.3-c22"
                        }
                    }
                })
            }

            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x08)
                {
                    Package (0x02)
                    {
                        "port-id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "phy-mode", 
                        "rgmii-id"
                    }, 

                    Package (0x02)
                    {
                        "phy-handle", 
                        PHY0
                    }, 

                    Package (0x02)
                    {
                        "cix,gmac-ctrl", 
                        GCRU
                    }, 

                    Package (0x02)
                    {
                        "reset-gpio", 
                        Package (0x04)
                        {
                            MAC0, 
                            Zero, 
                            Zero, 
                            One
                        }
                    }, 

                    Package (0x02)
                    {
                        "reset-delay-us", 
                        0x4E20
                    }, 

                    Package (0x02)
                    {
                        "reset-post-delay-us", 
                        0x000186A0
                    }, 

                    Package (0x02)
                    {
                        "pinctrl-names", 
                        Package (0x02)
                        {
                            "default", 
                            "init"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x52, 
                    "aclk", 
                    MAC0
                }, 

                Package (0x03)
                {
                    0x5A, 
                    "pclk", 
                    MAC0
                }, 

                Package (0x03)
                {
                    0x55, 
                    "tx_clk", 
                    MAC0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x2C, 
                    MAC0, 
                    "gmac_rstn"
                }
            })
        }

        Device (MAC1)
        {
            Name (_HID, "CIXH7020")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09330000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000017F,
                    0x00000180,
                    0x00000181,
                    0x00000182,
                    0x00000183,
                    0x00000184,
                    0x00000185,
                    0x00000186,
                }
            })
            Device (PHY1)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "compatible", 
                            "ethernet-phy-ieee802.3-c22"
                        }
                    }
                })
            }

            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "port-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "phy-mode", 
                        "rgmii-id"
                    }, 

                    Package (0x02)
                    {
                        "phy-handle", 
                        PHY1
                    }, 

                    Package (0x02)
                    {
                        "cix,gmac-ctrl", 
                        GCRU
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x53, 
                    "aclk", 
                    MAC1
                }, 

                Package (0x03)
                {
                    0x5B, 
                    "pclk", 
                    MAC1
                }, 

                Package (0x03)
                {
                    0x58, 
                    "tx_clk", 
                    MAC1
                }
            })
        }

        Name (TEMP, 0x0BB8)
        Method (C2DK, 1, Serialized)
        {
            Local0 = (Arg0 * 0x0A)
            Local0 += 0x0AAC
            Return (Local0)
        }

        ThermalZone (TZ00)
        {
            Method (_PSV, 0, NotSerialized)  // _PSV: Passive Temperature
            {
                Return (0x0DFE)
            }

            Method (_TC1, 0, NotSerialized)  // _TC1: Thermal Constant 1
            {
                Return (0x04)
            }

            Method (_TC2, 0, NotSerialized)  // _TC2: Thermal Constant 2
            {
                Return (0x03)
            }

            Method (_TSP, 0, NotSerialized)  // _TSP: Thermal Sampling Period
            {
                Return (0xC8)
            }

            Method (_PSL, 0, NotSerialized)  // _PSL: Passive List
            {
                Return (Package (0x01)
                {
                    \_SB.CPU0
                })
            }

            Method (_TZD, 0, NotSerialized)  // _TZD: Thermal Zone Devices
            {
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                Local0 = ^^PMMX.SENG (0x0B, Zero)
                CreateDWordField (Local0, Zero, STAT)
                CreateQWordField (Local0, 0x04, TEMP)
                TEMP = ToInteger (TEMP)
                Return (C2DK (TEMP))
            }

            Method (_SCP, 1, Serialized)  // _SCP: Set Cooling Policy
            {
            }

            Method (_TZP, 0, NotSerialized)  // _TZP: Thermal Zone Polling
            {
                Return (0x012C)
            }
        }

        Mutex (MBXM, 0x00)
        Device (SHM0)
        {
            Name (_HID, "CIXHA004")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x06590000,         // Address Base
                    0x00000080,         // Address Length
                    )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "arm,scmi-shmem"
                    }
                }
            })
        }

        Device (SHM1)
        {
            Name (_HID, "CIXHA005")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x065A0000,         // Address Base
                    0x00000080,         // Address Length
                    )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "arm,scmi-shmem"
                    }
                }
            })
        }

        Device (SCMI)
        {
            Name (_HID, "CIXHA006")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "mboxes", 
                        Package (0x04)
                        {
                            MBX6, 
                            0x08, 
                            MBX7, 
                            0x08
                        }
                    }, 

                    Package (0x02)
                    {
                        "shmem", 
                        Package (0x02)
                        {
                            SHM0, 
                            SHM1
                        }
                    }
                }
            })
            Device (DVFS)
            {
                Name (_HID, "CIXHA008")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0B)  // _STA: Status
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x13
                        }
                    }
                })
            }

            Device (CLKS)
            {
                Name (_HID, "CIXHA009")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0B)  // _STA: Status
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x14
                        }
                    }
                })
            }
        }

        Device (PMMX)
        {
            Name (_HID, "CIXHA000")  // _HID: Hardware ID
            OperationRegion (MBXO, SystemMemory, 0x06590000, 0xA0)
            Field (MBXO, DWordAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                CFRE,   1, 
                CERR,   1, 
                Offset (0x0C), 
                SIGN,   32, 
                FLAG,   32, 
                LENG,   32, 
                MSID,   8, 
                MSTP,   2, 
                PRID,   8, 
                TOKN,   10, 
                Offset (0x1C), 
                MSGP,   256, 
                Offset (0x80), 
                BEEL,   1
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x03)
            }

            Name (BUFF, Buffer (0x20){})
            CreateDWordField (BUFF, Zero, DAT0)
            CreateDWordField (BUFF, 0x04, DAT1)
            CreateDWordField (BUFF, 0x08, DAT2)
            CreateDWordField (BUFF, 0x0C, DAT3)
            Name (RESP, Buffer (0x20){})
            Method (PRSS, 2, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                DAT0 = Zero
                DAT1 = Arg0
                DAT2 = Arg1
                LENG = 0x10
                MSID = 0x04
                PRID = 0x11
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Method (PRSG, 1, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                LENG = 0x08
                DAT0 = Arg0
                MSID = 0x05
                PRID = 0x11
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Method (CLKG, 1, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                DAT0 = Arg0
                LENG = 0x08
                MSID = 0x06
                PRID = 0x14
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Method (CLKS, 3, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                DAT0 = Zero
                DAT1 = Arg0
                DAT2 = Arg1
                DAT3 = Arg2
                LENG = 0x14
                MSID = 0x05
                PRID = 0x14
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Method (CLKD, 2, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                DAT0 = Arg0
                DAT1 = Arg1
                LENG = 0x0C
                MSID = 0x04
                PRID = 0x14
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Method (CLKC, 2, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                DAT0 = Arg0
                DAT1 = Arg1
                LENG = 0x0C
                MSID = 0x07
                PRID = 0x14
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Method (SENG, 2, Serialized)
            {
                Acquire (MBXM, 0xFFFF)
                CERR = Zero
                If ((CFRE == Zero))
                {
                    Local0 = 0x0190
                    While ((Local0 > Zero))
                    {
                        If ((CFRE == One))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local0 == Zero))
                    {
                        Release (MBXM)
                        Return (Buffer (One)
                        {
                             0x06                                             // .
                        })
                    }
                }

                SIGN = 0x50434303
                FLAG = Zero
                DAT0 = Arg0
                DAT1 = Arg1
                LENG = 0x0C
                MSID = 0x06
                PRID = 0x15
                MSGP = BUFF /* \_SB_.PMMX.BUFF */
                CFRE = Zero
                BEEL = One
                Local0 = 0x0190
                While ((Local0 > Zero))
                {
                    If ((CFRE == One))
                    {
                        Break
                    }

                    Sleep (One)
                    Local0--
                }

                If ((Local0 == Zero))
                {
                    Debug = "ASL Debug: SCMI Timeout\n"
                    Release (MBXM)
                    Return (Buffer (One)
                    {
                         0x0B                                             // .
                    })
                }

                RESP = MSGP /* \_SB_.PMMX.MSGP */
                Release (MBXM)
                Return (RESP) /* \_SB_.PMMX.RESP */
            }

            Device (MTXD)
            {
                Name (_HID, "CIXHA007")  // _HID: Hardware ID
                Name (_UID, 0x04)  // _UID: Unique ID
                Name (_STA, 0x0B)  // _STA: Status
                Name (_DLM, Package (0x01)  // _DLM: Device Lock Mutex
                {
                    Package (0x01)
                    {
                        MBXM
                    }
                })
            }
        }

        Device (ADSS)
        {
            Name (_HID, "CIXH6060")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07110000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
            Device (ACLK)
            {
                Name (_HID, "CIXH6061")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If (GETV (0x28))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "audss_cru", 
                            ACRU
                        }
                    }
                })
                Name (CLKA, Package (0x1E)
                {
                    Package (0x03)
                    {
                        0x10, 
                        "hst", 
                        I2S0
                    }, 

                    Package (0x03)
                    {
                        0x11, 
                        "hst", 
                        I2S1
                    }, 

                    Package (0x03)
                    {
                        0x12, 
                        "hst", 
                        I2S2
                    }, 

                    Package (0x03)
                    {
                        0x13, 
                        "hst", 
                        I2S3
                    }, 

                    Package (0x03)
                    {
                        0x14, 
                        "hst", 
                        I2S4
                    }, 

                    Package (0x03)
                    {
                        0x15, 
                        "hst", 
                        I2S5
                    }, 

                    Package (0x03)
                    {
                        0x16, 
                        "hst", 
                        I2S6
                    }, 

                    Package (0x03)
                    {
                        0x17, 
                        "hst", 
                        I2S7
                    }, 

                    Package (0x03)
                    {
                        0x18, 
                        "hst", 
                        I2S8
                    }, 

                    Package (0x03)
                    {
                        0x19, 
                        "hst", 
                        I2S9
                    }, 

                    Package (0x03)
                    {
                        0x1A, 
                        "i2s", 
                        I2S0
                    }, 

                    Package (0x03)
                    {
                        0x1B, 
                        "i2s", 
                        I2S1
                    }, 

                    Package (0x03)
                    {
                        0x1C, 
                        "i2s", 
                        I2S2
                    }, 

                    Package (0x03)
                    {
                        0x1D, 
                        "i2s", 
                        I2S3
                    }, 

                    Package (0x03)
                    {
                        0x1E, 
                        "i2s", 
                        I2S4
                    }, 

                    Package (0x03)
                    {
                        0x1F, 
                        "i2s", 
                        I2S5
                    }, 

                    Package (0x03)
                    {
                        0x20, 
                        "i2s", 
                        I2S6
                    }, 

                    Package (0x03)
                    {
                        0x21, 
                        "i2s", 
                        I2S7
                    }, 

                    Package (0x03)
                    {
                        0x22, 
                        "i2s", 
                        I2S8
                    }, 

                    Package (0x03)
                    {
                        0x23, 
                        "i2s", 
                        I2S9
                    }, 

                    Package (0x03)
                    {
                        0x24, 
                        "mclk", 
                        I2S0
                    }, 

                    Package (0x03)
                    {
                        0x09, 
                        "", 
                        DMA1
                    }, 

                    Package (0x03)
                    {
                        0x07, 
                        "sysclk", 
                        HDA
                    }, 

                    Package (0x03)
                    {
                        0x08, 
                        "clk48m", 
                        HDA
                    }, 

                    Package (0x03)
                    {
                        0x03, 
                        "clk", 
                        DSP
                    }, 

                    Package (0x03)
                    {
                        0x04, 
                        "bclk", 
                        DSP
                    }, 

                    Package (0x03)
                    {
                        0x05, 
                        "pbclk", 
                        DSP
                    }, 

                    Package (0x03)
                    {
                        0x06, 
                        "sramclk", 
                        DSP
                    }, 

                    Package (0x03)
                    {
                        0x0E, 
                        "mb0clk", 
                        DSP
                    }, 

                    Package (0x03)
                    {
                        0x0F, 
                        "mb1clk", 
                        DSP
                    }
                })
                Name (CLKT, Package (0x06)
                {
                    Package (0x03)
                    {
                        0x4C, 
                        "audio_clk0", 
                        ACLK
                    }, 

                    Package (0x03)
                    {
                        0x4D, 
                        "audio_clk1", 
                        ACLK
                    }, 

                    Package (0x03)
                    {
                        0x4E, 
                        "audio_clk2", 
                        ACLK
                    }, 

                    Package (0x03)
                    {
                        0x4F, 
                        "audio_clk3", 
                        ACLK
                    }, 

                    Package (0x03)
                    {
                        0x46, 
                        "audio_clk4", 
                        ACLK
                    }, 

                    Package (0x03)
                    {
                        0x47, 
                        "audio_clk5", 
                        ACLK
                    }
                })
                Name (RSTL, Package (0x01)
                {
                    Package (0x04)
                    {
                        RST0, 
                        0x1F, 
                        ACLK, 
                        "noc"
                    }
                })
                PowerResource (PPRS, 0x00, 0x0000)
                {
                    OperationRegion (OPR0, SystemMemory, 0x07000020, 0x04)
                    Field (OPR0, DWordAcc, NoLock, Preserve)
                    {
                        MSK0,   32
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Local0 = MSK0 /* \_SB_.ADSS.ACLK.PPRS.MSK0 */
                        Local1 = MSK0 /* \_SB_.ADSS.ACLK.PPRS.MSK0 */
                        Local0 &= One
                        If ((Local0 > Zero))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        Local0 = MSK0 /* \_SB_.ADSS.ACLK.PPRS.MSK0 */
                        Local0 = ((Local0 | One) | 0x0FFC)
                        MSK0 = Local0
                        DMRP (One, 0x06, 0x07000000, One)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                        Local0 = MSK0 /* \_SB_.ADSS.ACLK.PPRS.MSK0 */
                        Local0 &= 0xFFFFFFFFFFFFFFFE
                        MSK0 = Local0
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    PPRS
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    PPRS
                })
            }

            Device (ARST)
            {
                Name (_HID, "CIXH6062")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If (GETV (0x28))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "audss_cru", 
                            ACRU
                        }
                    }
                })
            }
        }

        Device (ACRU)
        {
            Name (_HID, "CIXHA018")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07110000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
        }

        Device (GPI0)
        {
            Name (_HID, "CIXH1002")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04120000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000150,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "ngpios", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "id", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "gpio-io-mask", 
                        Zero
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0106, 
                    "", 
                    GPI0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x1A, 
                    GPI0, 
                    "apb_reset"
                }
            })
        }

        Device (GPI1)
        {
            Name (_HID, "CIXH1003")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04130000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000151,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "ngpios", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "id", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "gpio-io-mask", 
                        Zero
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0106, 
                    "", 
                    GPI1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x1A, 
                    GPI1, 
                    "apb_reset"
                }
            })
        }

        Device (GPI2)
        {
            Name (_HID, "CIXH1003")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04140000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000152,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "ngpios", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "id", 
                        0x05
                    }, 

                    Package (0x02)
                    {
                        "gpio-io-mask", 
                        Zero
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0106, 
                    "", 
                    GPI2
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x1A, 
                    GPI2, 
                    "apb_reset"
                }
            })
        }

        Device (GPI3)
        {
            Name (_HID, "CIXH1003")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04150000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000153,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "ngpios", 
                        0x11
                    }, 

                    Package (0x02)
                    {
                        "id", 
                        0x06
                    }, 

                    Package (0x02)
                    {
                        "gpio-io-mask", 
                        0x00018000
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0106, 
                    "", 
                    GPI3
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x1A, 
                    GPI3, 
                    "apb_reset"
                }
            })
        }

        Device (GPI4)
        {
            Name (_HID, "CIXH1003")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16004000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000194,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "ngpios", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "gpio-io-mask", 
                        Zero
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0106, 
                    "", 
                    GPI4
                }
            })
        }

        Device (GPI5)
        {
            Name (_HID, "CIXH1003")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x16005000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000195,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "ngpios", 
                        0x0A
                    }, 

                    Package (0x02)
                    {
                        "id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "gpio-io-mask", 
                        Zero
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0106, 
                    "", 
                    GPI5
                }
            })
        }

        Device (PWM0)
        {
            Name (_HID, "CIXH2011")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04110000,         // Address Base
                    0x00001000,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_pwm0", ResourceConsumer, ,)
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x0105, 
                    "fch_pwm_apb_clk", 
                    PWM0
                }, 

                Package (0x03)
                {
                    0xF2, 
                    "fch_pwm_func_clk", 
                    PWM0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x08, 
                    PWM0, 
                    "func_reset"
                }
            })
        }

        Device (PWM1)
        {
            Name (_HID, "CIXH2011")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04111000,         // Address Base
                    0x00001000,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_pwm1", ResourceConsumer, ,)
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x0105, 
                    "fch_pwm_apb_clk", 
                    PWM1
                }, 

                Package (0x03)
                {
                    0xF2, 
                    "fch_pwm_func_clk", 
                    PWM1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x08, 
                    PWM1, 
                    "func_reset"
                }
            })
        }

        Device (TMR0)
        {
            Name (_HID, "CIXH1007")  // _HID: Hardware ID
            Name (_CID, "CIXH1007")  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04116000,         // Address Base
                    0x00002000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001F6,
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x0105, 
                    "fch_timer_apb_clk", 
                    TMR0
                }, 

                Package (0x03)
                {
                    0xF2, 
                    "fch_timer_func_clk", 
                    TMR0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x08, 
                    TMR0, 
                    "func_reset"
                }
            })
        }

        Device (HDA)
        {
            Name (_HID, "CIXH6020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x070C0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000010A,
                }
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI3", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0005
                    }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_hda", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "pdb-gpios", 
                        Package (0x04)
                        {
                            HDA, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x0E, 
                    HDA, 
                    "hda"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    DMA1, 
                    HDA, 
                    Zero
                }
            })
        }

        Device (DCRU)
        {
            Name (_HID, "CIXHA018")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07110000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
        }

        Device (DSP)
        {
            Name (_HID, "CIXH6000")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07000000,         // Address Base
                    0x01000000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000105,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "firmware-name", 
                        "dsp_fw.bin"
                    }, 

                    Package (0x02)
                    {
                        "mbox-names", 
                        Package (0x02)
                        {
                            "tx0", 
                            "rx0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "mboxes", 
                        Package (0x04)
                        {
                            MBX5, 
                            0x09, 
                            MBX4, 
                            0x09
                        }
                    }, 

                    Package (0x02)
                    {
                        "cix,dsp-ctrl", 
                        DCRU
                    }
                }
            })
            Name (RSTL, Package (0x03)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x0C, 
                    DSP, 
                    "mb0"
                }, 

                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x0D, 
                    DSP, 
                    "mb1"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x1E, 
                    DSP, 
                    "dsp"
                }
            })
            Name (DLKL, Package (0x02)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    DSP, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    DSP, 
                    Zero
                }
            })
        }

        Device (DMA0)
        {
            Name (_HID, "CIXHA014")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04190000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000014F,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "dma-channels", 
                        0x08
                    }, 

                    Package (0x02)
                    {
                        "dma-requests", 
                        0x08
                    }
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x0B, 
                    DMA0, 
                    "dma_reset"
                }
            })
        }

        Device (DMA1)
        {
            Name (_HID, "CIXH1006")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07010000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000106,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "dma-channels", 
                        0x08
                    }, 

                    Package (0x02)
                    {
                        "dma-requests", 
                        0x14
                    }, 

                    Package (0x02)
                    {
                        "arm,clk-enable-atomic", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "arm,reg-map", 
                        Package (0x02)
                        {
                            0x07010000, 
                            0x20000000
                        }
                    }, 

                    Package (0x02)
                    {
                        "arm,ram-map", 
                        Package (0x02)
                        {
                            0xC0000000, 
                            0x30000000
                        }
                    }, 

                    Package (0x02)
                    {
                        "arm,remote-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0xEF, 
                    "", 
                    DMA0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x0F, 
                    DMA1, 
                    "dma_reset"
                }
            })
            Name (DLKL, Package (0x02)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    DMA1, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    DMA1, 
                    Zero
                }
            })
        }

        Device (XSPI)
        {
            Name (_HID, "CIXH2002")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04180000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00010000,         // Address Base
                    0x04000000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000014E,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_fch_xspi", ResourceConsumer, ,)
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0xFC, 
                    "pclk", 
                    XSPI
                }, 

                Package (0x03)
                {
                    0xF1, 
                    "maclk", 
                    XSPI
                }, 

                Package (0x03)
                {
                    0xF0, 
                    "funcclk", 
                    XSPI
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST1, 
                    0x1B, 
                    XSPI, 
                    "xspi_reg_reset"
                }, 

                Package (0x04)
                {
                    RST1, 
                    0x1C, 
                    XSPI, 
                    "xspi_sys_reset"
                }
            })
        }

        Device (I2C0)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x05))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04010000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000013E,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_i2c0", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c0_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x00061A80
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0xFD, 
                    "", 
                    I2C0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x12, 
                    I2C0, 
                    "i2c_reset"
                }
            })
            Device (UXC0)
            {
                Name (_HID, "CIXH302C")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0043, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_lt7911_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x00
                        })
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_lt7911_hw", ResourceConsumer, ,
                        RawDataBuffer (0x01)  // Vendor Data
                        {
                            0x01
                        })
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000F
                        }
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0010,
                            0x0012,
                            0x000C
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power1-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                DPR1, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }, 

                        Package (0x02)
                        {
                            "data-lanes", 
                            Package (0x01)
                            {
                                0x04
                            }
                        }, 

                        Package (0x02)
                        {
                            "clock-lanes", 
                            Package (0x01)
                            {
                                Zero
                            }
                        }
                    }
                })
            }

            Device (UXC1)
            {
                Name (_HID, "CIXH302C")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, Zero)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x000D, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power1-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                DPR2, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }, 

                        Package (0x02)
                        {
                            "data-lanes", 
                            Package (0x01)
                            {
                                0x04
                            }
                        }, 

                        Package (0x02)
                        {
                            "clock-lanes", 
                            Package (0x01)
                            {
                                Zero
                            }
                        }
                    }
                })
            }

            Device (UXC2)
            {
                Name (_HID, "CIXH302C")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_STA, Zero)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x001D, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power1-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                DPR4, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }, 

                        Package (0x02)
                        {
                            "data-lanes", 
                            Package (0x01)
                            {
                                0x04
                            }
                        }, 

                        Package (0x02)
                        {
                            "clock-lanes", 
                            Package (0x01)
                            {
                                Zero
                            }
                        }
                    }
                })
            }

            Device (UXC3)
            {
                Name (_HID, "CIXH302C")  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (_STA, Zero)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x002D, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "power1-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                UXC0, 
                                One, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pinctrl-names", 
                            Package (0x02)
                            {
                                "default", 
                                "gpio"
                            }
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x03)
                            {
                                DPR5, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }, 

                        Package (0x02)
                        {
                            "data-lanes", 
                            Package (0x01)
                            {
                                0x04
                            }
                        }, 

                        Package (0x02)
                        {
                            "clock-lanes", 
                            Package (0x01)
                            {
                                Zero
                            }
                        }
                    }
                })
            }
        }

        Device (I2C1)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x06))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04020000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000013F,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c1_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x000186A0
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0xFE, 
                    "", 
                    I2C1
                }
            })
        }

        Device (I2C2)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x07))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04030000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000140,
                }
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x000C,
                        0x000D
                    }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_i2c2", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c2_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x00061A80
                    }, 

                    Package (0x02)
                    {
                        "scl-gpios", 
                        Package (0x04)
                        {
                            I2C2, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "sda-gpios", 
                        Package (0x04)
                        {
                            I2C2, 
                            Zero, 
                            One, 
                            Zero
                        }
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0xFF, 
                    "", 
                    I2C2
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x14, 
                    I2C2, 
                    "i2c_reset"
                }
            })
        }

        Device (I2C3)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x08))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04040000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000141,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c3_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x00061A80
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0100, 
                    "", 
                    I2C3
                }
            })
        }

        Device (I2C4)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x09))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04050000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000142,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c4_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x00061A80
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0101, 
                    "", 
                    I2C4
                }
            })
        }

        Device (I2C5)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0A))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000143,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c5_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x00061A80
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0102, 
                    "", 
                    I2C5
                }
            })
        }

        Device (I2C7)
        {
            Name (_HID, "CIXH200B")  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0C))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04080000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000145,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "ClockName", 
                        "fch_i2c7_apb"
                    }, 

                    Package (0x02)
                    {
                        "clock-frequency", 
                        0x000186A0
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x0104, 
                    "", 
                    I2C7
                }
            })
        }

        Device (SPI0)
        {
            Name (_HID, "CIXH2001")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04090000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000146,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_fch_spi0", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "fifo-width", 
                        0x20
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xFA, 
                    "pclk", 
                    SPI0
                }, 

                Package (0x03)
                {
                    0xFA, 
                    "ref_clk", 
                    SPI0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x10, 
                    SPI0, 
                    "spi_reset"
                }
            })
        }

        Device (SPI1)
        {
            Name (_HID, "CIXH2001")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x040A0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000147,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_spi1", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "fifo-width", 
                        0x20
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xFB, 
                    "pclk", 
                    SPI1
                }, 

                Package (0x03)
                {
                    0xFB, 
                    "ref_clk", 
                    SPI1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST1, 
                    0x11, 
                    SPI1, 
                    "spi_reset"
                }
            })
        }

        Device (I3C0)
        {
            Name (_HID, "CIXH200C")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x040F0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000014C,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_i3c0", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "i3c-scl-hz", 
                        0x000186A0
                    }, 

                    Package (0x02)
                    {
                        "i2c-scl-hz", 
                        0x000186A0
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xF4, 
                    "pclk", 
                    I3C0
                }, 

                Package (0x03)
                {
                    0xED, 
                    "sysclk", 
                    I3C0
                }
            })
        }

        Device (I3C1)
        {
            Name (_HID, "CIXH200C")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x04100000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000014D,
                }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_fch_i3c1", ResourceConsumer, ,)
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xF5, 
                    "pclk", 
                    I3C1
                }, 

                Package (0x03)
                {
                    0xEE, 
                    "sysclk", 
                    I3C1
                }
            })
        }

        Device (PCI0)
        {
            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0xC0)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0D))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                        0x0000,             // Granularity
                        0x00C0,             // Range Minimum
                        0x00FF,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0040,             // Length
                        ,, )
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x60000000,         // Range Minimum
                        0x7FFFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x20000000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000001800000000, // Range Minimum
                        0x0000001BFFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000400000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
                Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
            }

            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01B7
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01B8
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01B9
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01BA
                }
            })
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x10
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }
        }

        Device (PCI1)
        {
            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 1 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0x90)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0E))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                        0x0000,             // Granularity
                        0x0090,             // Range Minimum
                        0x00AF,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0020,             // Length
                        ,, )
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x50000000,         // Range Minimum
                        0x5FFFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x10000000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000001400000000, // Range Minimum
                        0x00000017FFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000400000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
                Return (RBUF) /* \_SB_.PCI1._CRS.RBUF */
            }

            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01C1
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01C2
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01C3
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01C4
                }
            })
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    SUPP = CDW2 /* \_SB_.PCI1._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI1._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x10
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI1.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }
        }

        Device (PCI2)
        {
            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 2 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0x60)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0F))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                        0x0000,             // Granularity
                        0x0060,             // Range Minimum
                        0x007F,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0020,             // Length
                        ,, )
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x40000000,         // Range Minimum
                        0x4FFFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x10000000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000001000000000, // Range Minimum
                        0x00000013FFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000400000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
                Return (RBUF) /* \_SB_.PCI2._CRS.RBUF */
            }

            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01CB
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01CC
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01CD
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01CE
                }
            })
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    SUPP = CDW2 /* \_SB_.PCI2._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI2._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x10
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI2.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }
        }

        Device (PCI3)
        {
            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 3 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0x30)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x10))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                        0x0000,             // Granularity
                        0x0030,             // Range Minimum
                        0x004F,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0020,             // Length
                        ,, )
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x38000000,         // Range Minimum
                        0x3FFFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x08000000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000000C00000000, // Range Minimum
                        0x0000000FFFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000400000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
                Return (RBUF) /* \_SB_.PCI3._CRS.RBUF */
            }

            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01DD
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01DE
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01DF
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01E0
                }
            })
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    SUPP = CDW2 /* \_SB_.PCI3._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI3._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x10
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI3.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }
        }

        Device (PCI4)
        {
            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 4 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x11))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                        0x0000,             // Granularity
                        0x0000,             // Range Minimum
                        0x001F,             // Range Maximum
                        0x0000,             // Translation Offset
                        0x0020,             // Length
                        ,, )
                    DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x00000000,         // Granularity
                        0x30000000,         // Range Minimum
                        0x37FFFFFF,         // Range Maximum
                        0x00000000,         // Translation Offset
                        0x08000000,         // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000000800000000, // Range Minimum
                        0x0000000BFFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000400000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })
                Return (RBUF) /* \_SB_.PCI4._CRS.RBUF */
            }

            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01D4
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01D5
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01D6
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01D7
                }
            })
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    CreateDWordField (Arg3, Zero, CDW1)
                    CreateDWordField (Arg3, 0x04, CDW2)
                    CreateDWordField (Arg3, 0x08, CDW3)
                    SUPP = CDW2 /* \_SB_.PCI4._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI4._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x10
                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI4.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }
        }

        Device (RES0)
        {
            Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                QWordMemory (ResourceConsumer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000000020000000, // Range Minimum
                    0x000000002FFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000010000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
        }

        Device (PRC0)
        {
            Name (_HID, "CIXH2020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0xC0)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0D))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A010000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x0A000000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x2C000000,         // Address Base
                    0x04000000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x60000000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001B2,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001B3,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001B4,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001B5,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001B6,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001BB,
                }
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x00C0,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0020,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x60100000,         // Range Minimum
                    0x601FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00100000,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x60200000,         // Range Minimum
                    0x6FFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0FE00000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000001800000000, // Range Minimum
                    0x0000001BFFFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000400000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x0C)
                {
                    Package (0x02)
                    {
                        "device_type", 
                        "pci"
                    }, 

                    Package (0x02)
                    {
                        "vendor-id", 
                        0x1F6C
                    }, 

                    Package (0x02)
                    {
                        "device-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "bus-range", 
                        Package (0x02)
                        {
                            0xC0, 
                            0xFF
                        }
                    }, 

                    Package (0x02)
                    {
                        "max-link-speed", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "num-lanes", 
                        0x08
                    }, 

                    Package (0x02)
                    {
                        "cdns,no-inbound-bar", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,pcie-ctrl-id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,local-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-uncor-panic", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pcie-phy", 
                        ^PCP0.PX8P
                    }
                }
            })
            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01B7
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01B8
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01B9
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01BA
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0xAB, 
                    "axi_clk", 
                    PRC0
                }, 

                Package (0x03)
                {
                    0xA2, 
                    "apb_clk", 
                    PRC0
                }, 

                Package (0x03)
                {
                    0xDD, 
                    "refclk_b", 
                    PRC0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x2E, 
                    PRC0, 
                    "pcie_reset"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    PCP0, 
                    PRC0, 
                    Zero
                }
            })
            Name (RSNL, Package (0x0A)
            {
                Package (0x04)
                {
                    PRC0, 
                    0x0200, 
                    Zero, 
                    "reg"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0200, 
                    One, 
                    "app"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0200, 
                    0x02, 
                    "cfg"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0200, 
                    0x03, 
                    "msg"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0400, 
                    Zero, 
                    "aer_c"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0400, 
                    One, 
                    "aer_f"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0400, 
                    0x02, 
                    "aer_nf"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0400, 
                    0x03, 
                    "local"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0400, 
                    0x04, 
                    "phy_int"
                }, 

                Package (0x04)
                {
                    PRC0, 
                    0x0400, 
                    0x05, 
                    "phy_sta"
                }
            })
        }

        Device (PCP0)
        {
            Name (_HID, "CIXH2023")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0D))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A020000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xA7, 
                    "pclk", 
                    PCP0
                }, 

                Package (0x03)
                {
                    0xE2, 
                    "refclk", 
                    PCP0
                }
            })
            Device (PX8P)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "num-lanes", 
                            0x08
                        }
                    }
                })
            }
        }

        Device (PRC1)
        {
            Name (_HID, "CIXH2020")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 1 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0x90)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0E))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A070000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x0A060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x29000000,         // Address Base
                    0x03000000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x50000000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001BC,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001BD,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001BE,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001BF,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001C0,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001C5,
                }
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0090,             // Range Minimum
                    0x00AF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0020,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x50100000,         // Range Minimum
                    0x501FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00100000,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x50200000,         // Range Minimum
                    0x5FFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0FE00000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000001400000000, // Range Minimum
                    0x00000017FFFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000400000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x0C)
                {
                    Package (0x02)
                    {
                        "device_type", 
                        "pci"
                    }, 

                    Package (0x02)
                    {
                        "vendor-id", 
                        0x1F6C
                    }, 

                    Package (0x02)
                    {
                        "device-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "bus-range", 
                        Package (0x02)
                        {
                            0x90, 
                            0xBF
                        }
                    }, 

                    Package (0x02)
                    {
                        "max-link-speed", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "num-lanes", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,no-inbound-bar", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,pcie-ctrl-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "sky1,local-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-uncor-panic", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pcie-phy", 
                        ^PCP1.PX4P
                    }
                }
            })
            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01C1
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01C2
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01C3
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01C4
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0xAC, 
                    "axi_clk", 
                    PRC1
                }, 

                Package (0x03)
                {
                    0xA3, 
                    "apb_clk", 
                    PRC1
                }, 

                Package (0x03)
                {
                    0xDE, 
                    "refclk_b", 
                    PRC1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x2F, 
                    PRC1, 
                    "pcie_reset"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    PCP1, 
                    PRC1, 
                    Zero
                }
            })
            Name (RSNL, Package (0x0A)
            {
                Package (0x04)
                {
                    PRC1, 
                    0x0200, 
                    Zero, 
                    "reg"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0200, 
                    One, 
                    "app"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0200, 
                    0x02, 
                    "cfg"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0200, 
                    0x03, 
                    "msg"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0400, 
                    Zero, 
                    "aer_c"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0400, 
                    One, 
                    "aer_f"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0400, 
                    0x02, 
                    "aer_nf"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0400, 
                    0x03, 
                    "local"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0400, 
                    0x04, 
                    "phy_int"
                }, 

                Package (0x04)
                {
                    PRC1, 
                    0x0400, 
                    0x05, 
                    "phy_sta"
                }
            })
        }

        Device (PCP1)
        {
            Name (_HID, "CIXH2023")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0E))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A080000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xA8, 
                    "pclk", 
                    PCP1
                }, 

                Package (0x03)
                {
                    0xE3, 
                    "refclk", 
                    PCP1
                }
            })
            Device (PX4P)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "num-lanes", 
                            0x04
                        }
                    }
                })
            }
        }

        Device (PRC2)
        {
            Name (_HID, "CIXH2020")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 2 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0x60)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0F))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A0C0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x0A060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x26000000,         // Address Base
                    0x03000000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x40000000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001C6,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001C7,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001C8,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001C9,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001CA,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E3,
                }
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0060,             // Range Minimum
                    0x008F,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0020,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x40100000,         // Range Minimum
                    0x401FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00100000,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x40200000,         // Range Minimum
                    0x4FFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0FE00000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000001000000000, // Range Minimum
                    0x00000013FFFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000400000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x0C)
                {
                    Package (0x02)
                    {
                        "device_type", 
                        "pci"
                    }, 

                    Package (0x02)
                    {
                        "vendor-id", 
                        0x1F6C
                    }, 

                    Package (0x02)
                    {
                        "device-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "bus-range", 
                        Package (0x02)
                        {
                            0x60, 
                            0x8F
                        }
                    }, 

                    Package (0x02)
                    {
                        "max-link-speed", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "num-lanes", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "cdns,no-inbound-bar", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,pcie-ctrl-id", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "sky1,local-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-uncor-panic", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pcie-phy", 
                        ^PCP2.PX2P
                    }
                }
            })
            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01CB
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01CC
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01CD
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01CE
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0xAD, 
                    "axi_clk", 
                    PRC2
                }, 

                Package (0x03)
                {
                    0xA4, 
                    "apb_clk", 
                    PRC2
                }, 

                Package (0x03)
                {
                    0xDF, 
                    "refclk_b", 
                    PRC2
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x30, 
                    PRC2, 
                    "pcie_reset"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    PCP2, 
                    PRC2, 
                    Zero
                }
            })
            Name (RSNL, Package (0x0A)
            {
                Package (0x04)
                {
                    PRC2, 
                    0x0200, 
                    Zero, 
                    "reg"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0200, 
                    One, 
                    "app"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0200, 
                    0x02, 
                    "cfg"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0200, 
                    0x03, 
                    "msg"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0400, 
                    Zero, 
                    "aer_c"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0400, 
                    One, 
                    "aer_f"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0400, 
                    0x02, 
                    "aer_nf"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0400, 
                    0x03, 
                    "local"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0400, 
                    0x04, 
                    "phy_int"
                }, 

                Package (0x04)
                {
                    PRC2, 
                    0x0400, 
                    0x05, 
                    "phy_sta"
                }
            })
        }

        Device (PRC3)
        {
            Name (_HID, "CIXH2020")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 3 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, 0x30)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x10))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A0E0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x0A060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x23000000,         // Address Base
                    0x03000000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x38000000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001D8,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001D9,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001DA,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001DB,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001DC,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E2,
                }
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0030,             // Range Minimum
                    0x005F,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0020,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x38100000,         // Range Minimum
                    0x381FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00100000,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x38200000,         // Range Minimum
                    0x3FFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0FE00000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000000C00000000, // Range Minimum
                    0x0000000FFFFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000400000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x0C)
                {
                    Package (0x02)
                    {
                        "device_type", 
                        "pci"
                    }, 

                    Package (0x02)
                    {
                        "vendor-id", 
                        0x1F6C
                    }, 

                    Package (0x02)
                    {
                        "device-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "bus-range", 
                        Package (0x02)
                        {
                            0x30, 
                            0x5F
                        }
                    }, 

                    Package (0x02)
                    {
                        "max-link-speed", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "num-lanes", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "cdns,no-inbound-bar", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,pcie-ctrl-id", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "sky1,local-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-uncor-panic", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pcie-phy", 
                        ^PCP2.PX11
                    }
                }
            })
            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01DD
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01DE
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01DF
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01E0
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0xAC, 
                    "axi_clk", 
                    PRC3
                }, 

                Package (0x03)
                {
                    0xA3, 
                    "apb_clk", 
                    PRC3
                }, 

                Package (0x03)
                {
                    0xDE, 
                    "refclk_b", 
                    PRC3
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x32, 
                    PRC3, 
                    "pcie_reset"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    PCP2, 
                    PRC3, 
                    Zero
                }
            })
            Name (RSNL, Package (0x0A)
            {
                Package (0x04)
                {
                    PRC3, 
                    0x0200, 
                    Zero, 
                    "reg"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0200, 
                    One, 
                    "app"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0200, 
                    0x02, 
                    "cfg"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0200, 
                    0x03, 
                    "msg"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0400, 
                    Zero, 
                    "aer_c"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0400, 
                    One, 
                    "aer_f"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0400, 
                    0x02, 
                    "aer_nf"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0400, 
                    0x03, 
                    "local"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0400, 
                    0x04, 
                    "phy_int"
                }, 

                Package (0x04)
                {
                    PRC3, 
                    0x0400, 
                    0x05, 
                    "phy_sta"
                }
            })
        }

        Device (PRC4)
        {
            Name (_HID, "CIXH2020")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STR, Unicode ("PCIe 4 Device"))  // _STR: Description String
            Name (_SEG, Zero)  // _SEG: PCI Segment
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x11))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A0D0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x0A060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x20000000,         // Address Base
                    0x03000000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x30000000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001CF,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001D0,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001D1,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001D2,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001D3,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E1,
                }
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x002F,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0020,             // Length
                    ,, )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x30100000,         // Range Minimum
                    0x301FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00100000,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x30200000,         // Range Minimum
                    0x37FFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0FE00000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x0000000000000000, // Granularity
                    0x0000000800000000, // Range Minimum
                    0x0000000BFFFFFFFF, // Range Maximum
                    0x0000000000000000, // Translation Offset
                    0x0000000400000000, // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x0C)
                {
                    Package (0x02)
                    {
                        "device_type", 
                        "pci"
                    }, 

                    Package (0x02)
                    {
                        "vendor-id", 
                        0x1F6C
                    }, 

                    Package (0x02)
                    {
                        "device-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "bus-range", 
                        Package (0x02)
                        {
                            Zero, 
                            0x2F
                        }
                    }, 

                    Package (0x02)
                    {
                        "max-link-speed", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "num-lanes", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "cdns,no-inbound-bar", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,pcie-ctrl-id", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "sky1,local-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-interrupt", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "sky1,aer-uncor-panic", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pcie-phy", 
                        ^PCP2.PX10
                    }
                }
            })
            Name (_PRT, Package (0x04)  // _PRT: PCI Routing Table
            {
                Package (0x04)
                {
                    0xFFFF, 
                    Zero, 
                    Zero, 
                    0x01D4
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    One, 
                    Zero, 
                    0x01D5
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    Zero, 
                    0x01D6
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    Zero, 
                    0x01D7
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0xAC, 
                    "axi_clk", 
                    PRC4
                }, 

                Package (0x03)
                {
                    0xA3, 
                    "apb_clk", 
                    PRC4
                }, 

                Package (0x03)
                {
                    0xDE, 
                    "refclk_b", 
                    PRC4
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x31, 
                    PRC4, 
                    "pcie_reset"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    PCP2, 
                    PRC4, 
                    Zero
                }
            })
            Name (RSNL, Package (0x0A)
            {
                Package (0x04)
                {
                    PRC4, 
                    0x0200, 
                    Zero, 
                    "reg"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0200, 
                    One, 
                    "app"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0200, 
                    0x02, 
                    "cfg"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0200, 
                    0x03, 
                    "msg"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0400, 
                    Zero, 
                    "aer_c"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0400, 
                    One, 
                    "aer_f"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0400, 
                    0x02, 
                    "aer_nf"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0400, 
                    0x03, 
                    "local"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0400, 
                    0x04, 
                    "phy_int"
                }, 

                Package (0x04)
                {
                    PRC4, 
                    0x0400, 
                    0x05, 
                    "phy_sta"
                }
            })
        }

        Device (PCP2)
        {
            Name (_HID, "CIXH2023")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x0F))
                {
                    Return (0x0F)
                }
                ElseIf (GETV (0x10))
                {
                    Return (0x0F)
                }
                ElseIf (GETV (0x11))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x0A0F0000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0xA9, 
                    "pclk", 
                    PCP2
                }, 

                Package (0x03)
                {
                    0xE4, 
                    "refclk", 
                    PCP2
                }
            })
            Device (PX10)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If (GETV (0x11))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Name (_ADR, Zero)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "num-lanes", 
                            One
                        }
                    }
                })
            }

            Device (PX11)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If (GETV (0x10))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Name (_ADR, One)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "num-lanes", 
                            One
                        }
                    }
                })
            }

            Device (PX2P)
            {
                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    If (GETV (0x0F))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Name (_ADR, 0x02)  // _ADR: Address
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }, 

                        Package (0x02)
                        {
                            "num-lanes", 
                            0x02
                        }
                    }
                })
            }
        }

        Device (VPU0)
        {
            Name (_HID, "CIXH3010")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14230000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x14240000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000166,
                }
            })
            PowerResource (PPRS, 0x00, 0x0000)
            {
                OperationRegion (OPR0, SystemMemory, 0x1423021C, 0x04)
                Field (OPR0, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.VPU0.PPRS.MSK0 */
                    Local0 &= 0x1000
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.VPU0.PPRS.MSK0 */
                    Local0 = ((Local0 | 0x1000) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x08, 0x14230000, One)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.VPU0.PPRS.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFEFFF
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PPRS
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PPRS
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x43, 
                    "vpu_clk", 
                    VPU0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x0E, 
                    VPU0, 
                    "vpu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x8E, 
                    VPU0, 
                    "vpu_rcsu_reset"
                }
            })
            Device (CRE0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_STA, 0x0E)  // _STA: Status
                PowerResource (PRS0, 0x00, 0x0000)
                {
                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Return (Zero)
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        DMRP (One, 0x08, 0x14230000, 0x02)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    PRS0
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    PRS0
                })
                Method (REPR, 0, Serialized)
                {
                    DMRP (One, 0x08, 0x14230000, 0x02)
                }
            }

            Device (CRE1)
            {
                Name (_ADR, One)  // _ADR: Address
                Name (_STA, 0x0E)  // _STA: Status
                PowerResource (PRS1, 0x00, 0x0000)
                {
                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Return (Zero)
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        DMRP (One, 0x08, 0x14230000, 0x04)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    PRS1
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    PRS1
                })
                Method (REPR, 0, Serialized)
                {
                    DMRP (One, 0x08, 0x14230000, 0x04)
                }
            }

            Device (CRE2)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                Name (_STA, 0x0E)  // _STA: Status
                PowerResource (PRS2, 0x00, 0x0000)
                {
                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Return (Zero)
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        DMRP (One, 0x08, 0x14230000, 0x08)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    PRS2
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    PRS2
                })
                Method (REPR, 0, Serialized)
                {
                    DMRP (One, 0x08, 0x14230000, 0x10)
                }
            }

            Device (CRE3)
            {
                Name (_ADR, 0x03)  // _ADR: Address
                Name (_STA, 0x0E)  // _STA: Status
                PowerResource (PRS3, 0x00, 0x0000)
                {
                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Return (Zero)
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        DMRP (One, 0x08, 0x14230000, 0x10)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    PRS3
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    PRS3
                })
                Method (REPR, 0, Serialized)
                {
                    DMRP (One, 0x08, 0x14230000, 0x10)
                }
            }
        }

        Device (VDP0)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU0, 
                            "pipepline0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
        }

        Device (VDP1)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU0, 
                            "pipepline1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (VDP2)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU1, 
                            "pipepline0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
        }

        Device (VDP3)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU1, 
                            "pipepline1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (VDP4)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU2, 
                            "pipeline@0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
        }

        Device (VDP5)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU2, 
                            "pipeline@1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (VDP6)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU3, 
                            "pipepline0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
        }

        Device (VDP7)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU3, 
                            "pipepline1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (VDP8)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU4, 
                            "pipepline0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
        }

        Device (VDP9)
        {
            Name (_HID, "CIXH503F")  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU4, 
                            "pipepline1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (DP00)
        {
            Name (_HID, "CIXH502F")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x23))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14064000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x14068000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x1406FF00,         // Address Base
                    0x00000100,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000016C,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "dp_phy", 
                        ^UCP0.UDPP
                    }, 

                    Package (0x02)
                    {
                        "edp-panel", 
                        ""
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU0, 
                            "pipeline@0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU0, 
                            "pipeline@1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x31, 
                    "vid_clk0", 
                    DP00
                }, 

                Package (0x03)
                {
                    0x32, 
                    "vid_clk1", 
                    DP00
                }, 

                Package (0x03)
                {
                    0x3B, 
                    "apb_clk", 
                    DP00
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x18, 
                    DP00, 
                    "dp_reset"
                }
            })
        }

        Device (DP01)
        {
            Name (_HID, "CIXH502F")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x24))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x140D4000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x140D8000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x140DFF00,         // Address Base
                    0x00000100,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000016D,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "dp_phy", 
                        ^UCP1.UDPP
                    }, 

                    Package (0x02)
                    {
                        "edp-panel", 
                        ""
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU1, 
                            "pipeline@0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU1, 
                            "pipeline@1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x33, 
                    "vid_clk0", 
                    DP01
                }, 

                Package (0x03)
                {
                    0x34, 
                    "vid_clk1", 
                    DP01
                }, 

                Package (0x03)
                {
                    0x3C, 
                    "apb_clk", 
                    DP01
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x19, 
                    DP01, 
                    "dp_reset"
                }
            })
        }

        Device (DP02)
        {
            Name (_HID, "CIXH502F")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x25))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14144000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x14148000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x1414C000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000016E,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "dp_phy", 
                        ""
                    }, 

                    Package (0x02)
                    {
                        "edp-panel", 
                        EDP0
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU2, 
                            "pipeline@0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU2, 
                            "pipeline@1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x35, 
                    "vid_clk0", 
                    DP02
                }, 

                Package (0x03)
                {
                    0x36, 
                    "vid_clk1", 
                    DP02
                }, 

                Package (0x03)
                {
                    0x3D, 
                    "apb_clk", 
                    DP02
                }
            })
            Name (RSTL, Package (0x03)
            {
                Package (0x04)
                {
                    RST0, 
                    0x1A, 
                    DP02, 
                    "dp_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x1D, 
                    DP02, 
                    "phy_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x6B, 
                    DP02, 
                    "dp_rcsu_reset"
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    EDP0, 
                    DP02, 
                    Zero
                }
            })
        }

        Device (DP03)
        {
            Name (_HID, "CIXH502F")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x26))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x141B4000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x141B8000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x141BFF00,         // Address Base
                    0x00000100,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000016F,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "dp_phy", 
                        ^UCP2.UDPP
                    }, 

                    Package (0x02)
                    {
                        "edp-panel", 
                        ""
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU3, 
                            "pipeline@0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU3, 
                            "pipeline@1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x37, 
                    "vid_clk0", 
                    DP03
                }, 

                Package (0x03)
                {
                    0x38, 
                    "vid_clk1", 
                    DP03
                }, 

                Package (0x03)
                {
                    0x3E, 
                    "apb_clk", 
                    DP03
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x1B, 
                    DP03, 
                    "dp_reset"
                }
            })
        }

        Device (DP04)
        {
            Name (_HID, "CIXH502F")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x27))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14224000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x14228000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x1422FF00,         // Address Base
                    0x00000100,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000170,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "dp_phy", 
                        ^UCP3.UDPP
                    }, 

                    Package (0x02)
                    {
                        "edp-panel", 
                        ""
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU4, 
                            "pipeline@0", 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            DPU4, 
                            "pipeline@1", 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x39, 
                    "vid_clk0", 
                    DP04
                }, 

                Package (0x03)
                {
                    0x3A, 
                    "vid_clk1", 
                    DP04
                }, 

                Package (0x03)
                {
                    0x3F, 
                    "apb_clk", 
                    DP04
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x1C, 
                    DP04, 
                    "dp_reset"
                }
            })
        }

        Device (DPU0)
        {
            Name (_HID, "CIXH5010")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x23))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14010000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000015C,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "aclk_freq_fixed", 
                        0x2FAF0800
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "pipeline@0", 
                        "PIP0"
                    }, 

                    Package (0x02)
                    {
                        "pipeline@1", 
                        "PIP1"
                    }
                }
            })
            Name (PIP0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x10)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_aoutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_boutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ben", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_arqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_outstdcapb", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_awqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_l0_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l1_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l2_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l3_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_lw_arcache", 
                        0x03
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP00, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PIP1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP00, 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            PowerResource (PRS0, 0x00, 0x0000)
            {
                OperationRegion (OPR0, SystemMemory, 0x14000210, 0x04)
                Field (OPR0, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.DPU0.PRS0.MSK0 */
                    Local1 = MSK0 /* \_SB_.DPU0.PRS0.MSK0 */
                    Local0 &= 0x02
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.DPU0.PRS0.MSK0 */
                    Local0 = ((Local0 | 0x02) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x03, 0x14000000, One)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.DPU0.PRS0.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PRS0
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PRS0
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x2C, 
                    "aclk", 
                    DPU0
                }, 

                Package (0x03)
                {
                    0x21, 
                    "pipeline@0", 
                    DPU0
                }, 

                Package (0x03)
                {
                    0x22, 
                    "pipeline@1", 
                    DPU0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x6E, 
                    DPU0, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x13, 
                    DPU0, 
                    "ip_reset"
                }
            })
        }

        Device (DPU1)
        {
            Name (_HID, "CIXH5010")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x24))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14080000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000015E,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "aclk_freq_fixed", 
                        0x2FAF0800
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "pipeline@0", 
                        "PIP0"
                    }, 

                    Package (0x02)
                    {
                        "pipeline@1", 
                        "PIP1"
                    }
                }
            })
            Name (PIP0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x10)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_aoutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_boutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ben", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_arqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_outstdcapb", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_awqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_l0_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l1_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l2_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l3_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_lw_arcache", 
                        0x03
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP01, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PIP1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP01, 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            PowerResource (PRS1, 0x00, 0x0000)
            {
                OperationRegion (OPR1, SystemMemory, 0x14070210, 0x04)
                Field (OPR1, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.DPU1.PRS1.MSK0 */
                    Local1 = MSK0 /* \_SB_.DPU1.PRS1.MSK0 */
                    Local0 &= 0x02
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.DPU1.PRS1.MSK0 */
                    Local0 = ((Local0 | 0x02) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x03, 0x14000000, 0x02)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.DPU1.PRS1.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PRS1
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PRS1
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x2D, 
                    "aclk", 
                    DPU1
                }, 

                Package (0x03)
                {
                    0x23, 
                    "pipeline@0", 
                    DPU1
                }, 

                Package (0x03)
                {
                    0x24, 
                    "pipeline@1", 
                    DPU1
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x6F, 
                    DPU1, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x14, 
                    DPU1, 
                    "ip_reset"
                }
            })
        }

        Device (DPU2)
        {
            Name (_HID, "CIXH5010")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x25))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x140F0000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000160,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "aclk_freq_fixed", 
                        0x2FAF0800
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "pipeline@0", 
                        "PIP0"
                    }, 

                    Package (0x02)
                    {
                        "pipeline@1", 
                        "PIP1"
                    }
                }
            })
            Name (PIP0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x10)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_aoutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_boutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ben", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_arqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_outstdcapb", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_awqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_l0_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l1_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l2_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l3_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_lw_arcache", 
                        0x03
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP02, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PIP1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP02, 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            PowerResource (PRS2, 0x00, 0x0000)
            {
                OperationRegion (OPR2, SystemMemory, 0x140E0210, 0x04)
                Field (OPR2, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.DPU2.PRS2.MSK0 */
                    Local1 = MSK0 /* \_SB_.DPU2.PRS2.MSK0 */
                    Local0 &= 0x02
                    Debug = Concatenate (Concatenate (Concatenate (Concatenate ("CIX Debug: DPU2 get current state=", Local0), ":"), Local1
                        ), "\n")
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.DPU2.PRS2.MSK0 */
                    Debug = Concatenate (Concatenate ("CIX Debug: DPU2 power on, mask1=", Local0), "\n")
                    Local0 = ((Local0 | 0x02) | 0x0FFC)
                    MSK0 = Local0
                    Debug = Concatenate (Concatenate ("CIX Debug: DPU2 power on, mask2=", MSK0), "\n")
                    DMRP (One, 0x03, 0x14000000, 0x04)
                    Debug = "CIX Debug: Call do_mem_repair end.\n"
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.DPU2.PRS2.MSK0 */
                    Debug = Concatenate (Concatenate ("CIX Debug: DPU2 power off, mask1=", Local0), "\n")
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    MSK0 = Local0
                    Debug = Concatenate (Concatenate ("CIX Debug: DPU2 power off, mask2=", MSK0), "\n")
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PRS2
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PRS2
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x2E, 
                    "aclk", 
                    DPU2
                }, 

                Package (0x03)
                {
                    0x25, 
                    "pipeline@0", 
                    DPU2
                }, 

                Package (0x03)
                {
                    0x26, 
                    "pipeline@1", 
                    DPU2
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x70, 
                    DPU2, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x15, 
                    DPU2, 
                    "ip_reset"
                }
            })
        }

        Device (DPU3)
        {
            Name (_HID, "CIXH5010")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x26))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14160000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000162,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "aclk_freq_fixed", 
                        0x2FAF0800
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "pipeline@0", 
                        "PIP0"
                    }, 

                    Package (0x02)
                    {
                        "pipeline@1", 
                        "PIP1"
                    }
                }
            })
            Name (PIP0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x10)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_aoutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_boutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ben", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_arqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_outstdcapb", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_awqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_l0_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l1_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l2_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l3_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_lw_arcache", 
                        0x03
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP03, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PIP1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP03, 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            PowerResource (PRS3, 0x00, 0x0000)
            {
                OperationRegion (OPR3, SystemMemory, 0x14150210, 0x04)
                Field (OPR3, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.DPU3.PRS3.MSK0 */
                    Local1 = MSK0 /* \_SB_.DPU3.PRS3.MSK0 */
                    Local0 &= 0x02
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.DPU3.PRS3.MSK0 */
                    Local0 = ((Local0 | 0x02) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x03, 0x14000000, 0x08)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.DPU3.PRS3.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PRS3
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PRS3
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x2F, 
                    "aclk", 
                    DPU3
                }, 

                Package (0x03)
                {
                    0x27, 
                    "pipeline@0", 
                    DPU3
                }, 

                Package (0x03)
                {
                    0x28, 
                    "pipeline@1", 
                    DPU3
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x71, 
                    DPU3, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x16, 
                    DPU3, 
                    "ip_reset"
                }
            })
        }

        Device (DPU4)
        {
            Name (_HID, "CIXH5010")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x27))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x141D0000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000164,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "aclk_freq_fixed", 
                        0x2FAF0800
                    }, 

                    Package (0x02)
                    {
                        "enabled_by_gop", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "pipeline@0", 
                        "PIP0"
                    }, 

                    Package (0x02)
                    {
                        "pipeline@1", 
                        "PIP1"
                    }
                }
            })
            Name (PIP0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x10)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_aoutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_boutstdcapb", 
                        0x20
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ben", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_arqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_raxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_outstdcapb", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_burstlen", 
                        0x10
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_awqos", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "lpu_waxi_ord", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "lpu_l0_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l1_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l2_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_l3_arcache", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "lpu_lw_arcache", 
                        0x03
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP04, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PIP1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DP04, 
                            "port@1", 
                            "endpoint@1"
                        }
                    }
                }
            })
            PowerResource (PRS4, 0x00, 0x0000)
            {
                OperationRegion (OPR4, SystemMemory, 0x141C0210, 0x04)
                Field (OPR4, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.DPU4.PRS4.MSK0 */
                    Local1 = MSK0 /* \_SB_.DPU4.PRS4.MSK0 */
                    Local0 &= 0x02
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.DPU4.PRS4.MSK0 */
                    Local0 = ((Local0 | 0x02) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x03, 0x14000000, 0x10)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.DPU4.PRS4.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PRS4
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PRS4
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x30, 
                    "aclk", 
                    DPU4
                }, 

                Package (0x03)
                {
                    0x29, 
                    "pipeline@0", 
                    DPU4
                }, 

                Package (0x03)
                {
                    0x2A, 
                    "pipeline@1", 
                    DPU4
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x72, 
                    DPU4, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x17, 
                    DPU4, 
                    "ip_reset"
                }
            })
        }

        Device (AEU0)
        {
            Name (_HID, "CIXH5011")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x23))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14030000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000015D,
                }
            })
        }

        Device (AEU1)
        {
            Name (_HID, "CIXH5011")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x24))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x140A0000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000015F,
                }
            })
        }

        Device (AEU2)
        {
            Name (_HID, "CIXH5011")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x25))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14110000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000161,
                }
            })
        }

        Device (AEU3)
        {
            Name (_HID, "CIXH5011")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x26))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14180000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000163,
                }
            })
        }

        Device (AEU4)
        {
            Name (_HID, "CIXH5011")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x27))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x141F0000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000165,
                }
            })
        }

        Device (DPBL)
        {
            Name (_HID, "CIXH5041")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI3", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x000F
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "enable-gpios", 
                        Package (0x04)
                        {
                            DPBL, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "pwms", 
                        Package (0x03)
                        {
                            PWM0, 
                            Zero, 
                            0x000186A0
                        }
                    }, 

                    Package (0x02)
                    {
                        "default-brightness-level", 
                        0xC8
                    }, 

                    Package (0x02)
                    {
                        "brightness-levels", 
                        Package (0xFF)
                        {
                            Zero, 
                            One, 
                            0x02, 
                            0x03, 
                            0x04, 
                            0x05, 
                            0x06, 
                            0x07, 
                            0x08, 
                            0x09, 
                            0x0A, 
                            0x0B, 
                            0x0C, 
                            0x0D, 
                            0x0E, 
                            0x0F, 
                            0x10, 
                            0x11, 
                            0x12, 
                            0x13, 
                            0x14, 
                            0x15, 
                            0x16, 
                            0x17, 
                            0x18, 
                            0x19, 
                            0x1A, 
                            0x1B, 
                            0x1C, 
                            0x1D, 
                            0x1E, 
                            0x1F, 
                            0x20, 
                            0x21, 
                            0x22, 
                            0x23, 
                            0x24, 
                            0x25, 
                            0x26, 
                            0x27, 
                            0x28, 
                            0x29, 
                            0x2A, 
                            0x2B, 
                            0x2C, 
                            0x2D, 
                            0x2E, 
                            0x2F, 
                            0x30, 
                            0x31, 
                            0x32, 
                            0x33, 
                            0x34, 
                            0x35, 
                            0x36, 
                            0x37, 
                            0x38, 
                            0x39, 
                            0x3A, 
                            0x3B, 
                            0x3C, 
                            0x3D, 
                            0x3E, 
                            0x3F, 
                            0x40, 
                            0x41, 
                            0x42, 
                            0x43, 
                            0x44, 
                            0x45, 
                            0x46, 
                            0x47, 
                            0x48, 
                            0x49, 
                            0x4A, 
                            0x4B, 
                            0x4C, 
                            0x4D, 
                            0x4E, 
                            0x4F, 
                            0x50, 
                            0x51, 
                            0x52, 
                            0x53, 
                            0x54, 
                            0x55, 
                            0x56, 
                            0x57, 
                            0x58, 
                            0x59, 
                            0x5A, 
                            0x5B, 
                            0x5C, 
                            0x5D, 
                            0x5E, 
                            0x5F, 
                            0x60, 
                            0x61, 
                            0x62, 
                            0x63, 
                            0x64, 
                            0x65, 
                            0x66, 
                            0x67, 
                            0x68, 
                            0x69, 
                            0x6A, 
                            0x6B, 
                            0x6C, 
                            0x6D, 
                            0x6E, 
                            0x6F, 
                            0x70, 
                            0x71, 
                            0x72, 
                            0x73, 
                            0x74, 
                            0x75, 
                            0x76, 
                            0x77, 
                            0x78, 
                            0x79, 
                            0x7A, 
                            0x7B, 
                            0x7C, 
                            0x7D, 
                            0x7E, 
                            0x7F, 
                            0x80, 
                            0x81, 
                            0x82, 
                            0x83, 
                            0x84, 
                            0x85, 
                            0x86, 
                            0x87, 
                            0x88, 
                            0x89, 
                            0x8A, 
                            0x8B, 
                            0x8C, 
                            0x8D, 
                            0x8E, 
                            0x8F, 
                            0x90, 
                            0x91, 
                            0x92, 
                            0x93, 
                            0x94, 
                            0x95, 
                            0x96, 
                            0x97, 
                            0x98, 
                            0x99, 
                            0x9A, 
                            0x9B, 
                            0x9C, 
                            0x9D, 
                            0x9E, 
                            0x9F, 
                            0xA0, 
                            0xA1, 
                            0xA2, 
                            0xA3, 
                            0xA4, 
                            0xA5, 
                            0xA6, 
                            0xA7, 
                            0xA8, 
                            0xA9, 
                            0xAA, 
                            0xAB, 
                            0xAC, 
                            0xAD, 
                            0xAE, 
                            0xAF, 
                            0xB0, 
                            0xB1, 
                            0xB2, 
                            0xB3, 
                            0xB4, 
                            0xB5, 
                            0xB6, 
                            0xB7, 
                            0xB8, 
                            0xB9, 
                            0xBA, 
                            0xBB, 
                            0xBC, 
                            0xBD, 
                            0xBE, 
                            0xBF, 
                            0xC0, 
                            0xC1, 
                            0xC2, 
                            0xC3, 
                            0xC4, 
                            0xC5, 
                            0xC6, 
                            0xC7, 
                            0xC8, 
                            0xC9, 
                            0xCA, 
                            0xCB, 
                            0xCC, 
                            0xCD, 
                            0xCE, 
                            0xCF, 
                            0xD0, 
                            0xD1, 
                            0xD2, 
                            0xD3, 
                            0xD4, 
                            0xD5, 
                            0xD6, 
                            0xD7, 
                            0xD8, 
                            0xD9, 
                            0xDA, 
                            0xDB, 
                            0xDC, 
                            0xDD, 
                            0xDE, 
                            0xDF, 
                            0xE0, 
                            0xE1, 
                            0xE2, 
                            0xE3, 
                            0xE4, 
                            0xE5, 
                            0xE6, 
                            0xE7, 
                            0xE8, 
                            0xE9, 
                            0xEA, 
                            0xEB, 
                            0xEC, 
                            0xED, 
                            0xEE, 
                            0xEF, 
                            0xF0, 
                            0xF1, 
                            0xF2, 
                            0xF3, 
                            0xF4, 
                            0xF5, 
                            0xF6, 
                            0xF7, 
                            0xF8, 
                            0xF9, 
                            0xFA, 
                            0xFB, 
                            0xFC, 
                            0xFD, 
                            0xFE
                        }
                    }
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    PWM0, 
                    DPBL, 
                    Zero
                }
            })
        }

        Device (EDP0)
        {
            Name (_HID, "CIXH5040")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_edp0", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI3", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0010
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x08)
                {
                    Package (0x02)
                    {
                        "prepare-delay-ms", 
                        0x78
                    }, 

                    Package (0x02)
                    {
                        "enable-delay-ms", 
                        0x78
                    }, 

                    Package (0x02)
                    {
                        "unprepare-delay-ms", 
                        0x01F4
                    }, 

                    Package (0x02)
                    {
                        "disable-delay-ms", 
                        0x78
                    }, 

                    Package (0x02)
                    {
                        "width-mm", 
                        0x81
                    }, 

                    Package (0x02)
                    {
                        "height-mm", 
                        0xAB
                    }, 

                    Package (0x02)
                    {
                        "enable-gpios", 
                        Package (0x04)
                        {
                            EDP0, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "backlight", 
                        DPBL
                    }
                }
            })
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    DPBL, 
                    EDP0, 
                    Zero
                }
            })
        }

        Device (PMA)
        {
            Name (_HID, "CIXHA012")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x03)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0xBCE00000,         // Address Base
                    0x01000000,         // Address Length
                    )
            })
        }

        Device (PMGM)
        {
            Name (_HID, "CIXHA013")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x03)  // _STA: Status
        }

        Device (GPU)
        {
            Name (_HID, "CIXH5000")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x15000000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x15010000,         // Address Base
                    0x00FF0000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000010D,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000010E,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x0000010F,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "protected-memory-allocator", 
                        PMA
                    }, 

                    Package (0x02)
                    {
                        "physical-memory-group-manager", 
                        PMGM
                    }, 

                    Package (0x02)
                    {
                        "power-domains", 
                        Package (0x02)
                        {
                            ^SCMI.DVFS, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "power-domain-names", 
                        Package (0x01)
                        {
                            "perf"
                        }
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "pbha", 
                        "IIOR"
                    }
                }
            })
            Name (IIOR, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "int_id_override", 
                        Package (0x12)
                        {
                            0x02, 
                            0x32, 
                            0x04, 
                            0x32, 
                            0x10, 
                            0x22, 
                            0x11, 
                            0x23, 
                            0x12, 
                            0x23, 
                            0x15, 
                            0x23, 
                            0x16, 
                            0x23, 
                            0x18, 
                            0x22, 
                            0x1C, 
                            0x23
                        }
                    }
                }
            })
            PowerResource (PPRS, 0x00, 0x0000)
            {
                OperationRegion (OPR0, SystemMemory, 0x15000218, 0x04)
                Field (OPR0, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.GPU_.PPRS.MSK0 */
                    Local0 &= 0x1000
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.GPU_.PPRS.MSK0 */
                    Local0 = ((Local0 | 0x1000) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x04, 0x15000000, One)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.GPU_.PPRS.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFEFFF
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PPRS
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PPRS
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x1F, 
                    "gpu_clk_core", 
                    GPU
                }, 

                Package (0x03)
                {
                    0x20, 
                    "gpu_clk_stacks", 
                    GPU
                }, 

                Package (0x03)
                {
                    0x0110, 
                    "gpu_clk_200M", 
                    GPU
                }, 

                Package (0x03)
                {
                    0x1E, 
                    "gpu_clk_400M", 
                    GPU
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x09, 
                    GPU, 
                    "gpu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x77, 
                    GPU, 
                    "gpu_rcsu_reset"
                }
            })
        }

        Device (NPU0)
        {
            Name (_HID, "CIXH4000")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Local0 = GETV (0x22)
                DerefOf (DerefOf (_DSD [One]) [0x02]) [One]
                     = Local0
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14260000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x90000000,         // Address Base
                    0x02000000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000167,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "cluster-partition", 
                        Package (0x02)
                        {
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "gm-policy", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "core_mask", 
                        0x03
                    }
                }
            })
            PowerResource (PPRS, 0x00, 0x0000)
            {
                OperationRegion (OPRT, SystemMemory, 0x1425020C, 0x04)
                Field (OPRT, DWordAcc, NoLock, Preserve)
                {
                    TMSK,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = TMSK /* \_SB_.NPU0.PPRS.TMSK */
                    Local1 = TMSK /* \_SB_.NPU0.PPRS.TMSK */
                    Local0 &= One
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = TMSK /* \_SB_.NPU0.PPRS.TMSK */
                    Local0 = ((Local0 | One) | 0x0FFC)
                    TMSK = Local0
                    DMRP (One, 0x05, 0x14250000, One)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = TMSK /* \_SB_.NPU0.PPRS.TMSK */
                    Local0 &= 0xFFFFFFFFFFFFFFFE
                    TMSK = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PPRS
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PPRS
            })
            Device (CRE0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                PowerResource (PRS0, 0x00, 0x0000)
                {
                    OperationRegion (OPR0, SystemMemory, 0x14250200, 0x04)
                    Field (OPR0, DWordAcc, NoLock, Preserve)
                    {
                        MSK0,   32
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Local0 = MSK0 /* \_SB_.NPU0.CRE0.PRS0.MSK0 */
                        Local1 = MSK0 /* \_SB_.NPU0.CRE0.PRS0.MSK0 */
                        Local0 &= One
                        If ((Local0 > Zero))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        Local0 = MSK0 /* \_SB_.NPU0.CRE0.PRS0.MSK0 */
                        Local0 = ((Local0 | One) | 0x0FFC)
                        MSK0 = Local0
                        DMRP (One, 0x05, 0x14250000, 0x02)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                        Local0 = MSK0 /* \_SB_.NPU0.CRE0.PRS0.MSK0 */
                        Local0 &= 0xFFFFFFFFFFFFFFFE
                        MSK0 = Local0
                    }
                }

                Name (_PR0, Package (0x02)  // _PR0: Power Resources for D0
                {
                    PRS0, 
                    PPRS
                })
                Name (_PR3, Package (0x02)  // _PR3: Power Resources for D3hot
                {
                    PRS0, 
                    PPRS
                })
            }

            Device (CRE1)
            {
                Name (_ADR, One)  // _ADR: Address
                PowerResource (PRS1, 0x00, 0x0000)
                {
                    OperationRegion (OPR1, SystemMemory, 0x14250204, 0x04)
                    Field (OPR1, DWordAcc, NoLock, Preserve)
                    {
                        MSK1,   32
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Local0 = MSK1 /* \_SB_.NPU0.CRE1.PRS1.MSK1 */
                        Local1 = MSK1 /* \_SB_.NPU0.CRE1.PRS1.MSK1 */
                        Local0 &= One
                        If ((Local0 > Zero))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        Local0 = MSK1 /* \_SB_.NPU0.CRE1.PRS1.MSK1 */
                        Local0 = ((Local0 | One) | 0x0FFC)
                        MSK1 = Local0
                        DMRP (One, 0x05, 0x14250000, 0x04)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                        Local0 = MSK1 /* \_SB_.NPU0.CRE1.PRS1.MSK1 */
                        Local0 &= 0xFFFFFFFFFFFFFFFE
                        MSK1 = Local0
                    }
                }

                Name (_PR0, Package (0x02)  // _PR0: Power Resources for D0
                {
                    PRS1, 
                    PPRS
                })
                Name (_PR3, Package (0x02)  // _PR3: Power Resources for D3hot
                {
                    PRS1, 
                    PPRS
                })
            }

            Device (CRE2)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                PowerResource (PRS2, 0x00, 0x0000)
                {
                    OperationRegion (OPR2, SystemMemory, 0x14250208, 0x04)
                    Field (OPR2, DWordAcc, NoLock, Preserve)
                    {
                        MSK2,   32
                    }

                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        Local0 = MSK2 /* \_SB_.NPU0.CRE2.PRS2.MSK2 */
                        Local1 = MSK2 /* \_SB_.NPU0.CRE2.PRS2.MSK2 */
                        Local0 &= One
                        If ((Local0 > Zero))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        Local0 = MSK2 /* \_SB_.NPU0.CRE2.PRS2.MSK2 */
                        Local0 = ((Local0 | One) | 0x0FFC)
                        MSK2 = Local0
                        DMRP (One, 0x05, 0x14250000, 0x08)
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                        Local0 = MSK2 /* \_SB_.NPU0.CRE2.PRS2.MSK2 */
                        Local0 &= 0xFFFFFFFFFFFFFFFE
                        MSK2 = Local0
                    }
                }

                Name (_PR0, Package (0x02)  // _PR0: Power Resources for D0
                {
                    PRS2, 
                    PPRS
                })
                Name (_PR3, Package (0x02)  // _PR3: Power Resources for D3hot
                {
                    PRS2, 
                    PPRS
                })
            }
        }

        Device (I2S0)
        {
            Name (_HID, "CIXH6010")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07020000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000000FB,
                }
                FixedDMA (0x0020, 0x0000, Width32bit, )
                FixedDMA (0x0021, 0x0001, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s0", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x02)
                        {
                            "tx", 
                            "rx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,mclk-idx", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S0
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    Zero, 
                    I2S0, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S0, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S0, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S0, 
                    Zero
                }
            })
        }

        Device (I2S1)
        {
            Name (_HID, "CIXH6010")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07030000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000000FC,
                }
                FixedDMA (0x0022, 0x0002, Width32bit, )
                FixedDMA (0x0023, 0x0003, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s1", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x02)
                        {
                            "tx", 
                            "rx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S1
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    One, 
                    I2S1, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S1, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S1, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S1, 
                    Zero
                }
            })
        }

        Device (I2S2)
        {
            Name (_HID, "CIXH6010")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07040000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000000FD,
                }
                FixedDMA (0x0025, 0x0004, Width32bit, )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "rx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S2
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S2
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x02, 
                    I2S2, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S2, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S2, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S2, 
                    Zero
                }
            })
        }

        Device (I2S3)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07050000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000000FE,
                }
                FixedDMA (0x0026, 0x0005, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s2", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "tx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x06
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        0x3C
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S3
                }, 

                Package (0x03)
                {
                    0x4D, 
                    "audio_clk1", 
                    I2S3
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S3
                }, 

                Package (0x03)
                {
                    0x4F, 
                    "audio_clk3", 
                    I2S3
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x03, 
                    I2S3, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S3, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S3, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S3, 
                    Zero
                }
            })
        }

        Device (I2S4)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07060000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000000FF,
                }
                FixedDMA (0x0029, 0x0006, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s3", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "rx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S4
                }, 

                Package (0x03)
                {
                    0x4D, 
                    "audio_clk1", 
                    I2S4
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S4
                }, 

                Package (0x03)
                {
                    0x4F, 
                    "audio_clk3", 
                    I2S4
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x04, 
                    I2S4, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S4, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S4, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S4, 
                    Zero
                }
            })
        }

        Device (I2S5)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07070000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000100,
                }
                FixedDMA (0x002A, 0x0007, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s5_dbg", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x05
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "tx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S5
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S5
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x05, 
                    I2S5, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S5, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S5, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S5, 
                    Zero
                }
            })
        }

        Device (I2S6)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07080000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000101,
                }
                FixedDMA (0x002C, 0x0007, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s6_dbg", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x06
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "tx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S6
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S6
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x06, 
                    I2S6, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S6, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S6, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S6, 
                    Zero
                }
            })
        }

        Device (I2S7)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x07090000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000102,
                }
                FixedDMA (0x002E, 0x0007, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s7_dbg", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "tx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S7
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S7
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x07, 
                    I2S7, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S7, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S7, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S7, 
                    Zero
                }
            })
        }

        Device (I2S8)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x070A0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000103,
                }
                FixedDMA (0x0030, 0x0007, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s8_dbg", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x08
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "tx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S8
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S8
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x08, 
                    I2S8, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S8, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S8, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S8, 
                    Zero
                }
            })
        }

        Device (I2S9)
        {
            Name (_HID, "CIXH6011")  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (Zero)
                If (GETV (0x28))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x070B0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000104,
                }
                FixedDMA (0x0032, 0x0007, Width32bit, )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_substrate_i2s9_dbg", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x09
                    }, 

                    Package (0x02)
                    {
                        "dma-names", 
                        Package (0x01)
                        {
                            "tx"
                        }
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-out-num", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-rx-mask", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cdns,pin-tx-mask", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "cdns,cru-ctrl", 
                        ACRU
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x4C, 
                    "audio_clk0", 
                    I2S9
                }, 

                Package (0x03)
                {
                    0x4E, 
                    "audio_clk2", 
                    I2S9
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    ^ADSS.ARST, 
                    0x09, 
                    I2S9, 
                    "i2s"
                }
            })
            Name (DLKL, Package (0x03)
            {
                Package (0x03)
                {
                    ^ADSS.ACLK, 
                    I2S9, 
                    Zero
                }, 

                Package (0x03)
                {
                    ^ADSS.ARST, 
                    I2S9, 
                    Zero
                }, 

                Package (0x03)
                {
                    DMA1, 
                    I2S9, 
                    Zero
                }
            })
        }

        Device (XHC0)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((GETV (0x12) && (GETV (0x1C) == Zero)))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x09018000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000126,
                    }
                })
                Return (RBUF) /* \_SB_.XHC0._CRS.RBUF */
            }
        }

        Device (XHC1)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x13))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x09088000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000012C,
                    }
                })
                Return (RBUF) /* \_SB_.XHC1._CRS.RBUF */
            }
        }

        Device (XHC2)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x16))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x090F8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000132,
                    }
                })
                Return (RBUF) /* \_SB_.XHC2._CRS.RBUF */
            }
        }

        Device (XHC3)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x15))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x09168000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000138,
                    }
                })
                Return (RBUF) /* \_SB_.XHC3._CRS.RBUF */
            }
        }

        Device (XHC4)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((GETV (0x17) && (GETV (0x1D) == Zero)))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x091D8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000011C,
                    }
                })
                Return (RBUF) /* \_SB_.XHC4._CRS.RBUF */
            }
        }

        Device (XHC5)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((GETV (0x18) && (GETV (0x1E) == Zero)))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x091E8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000121,
                    }
                })
                Return (RBUF) /* \_SB_.XHC5._CRS.RBUF */
            }
        }

        Device (USB0)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x14))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x09268000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000110,
                    }
                })
                Return (RBUF) /* \_SB_.USB0._CRS.RBUF */
            }
        }

        Device (USB1)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x1B))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x09298000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000113,
                    }
                })
                Return (RBUF) /* \_SB_.USB1._CRS.RBUF */
            }
        }

        Device (USB2)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x1A))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x092C8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000116,
                    }
                })
                Return (RBUF) /* \_SB_.USB2._CRS.RBUF */
            }
        }

        Device (USB3)
        {
            Name (_HID, "PNP0D10" /* XHCI USB Controller with debug */)  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x19))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x092F8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000119,
                    }
                })
                Return (RBUF) /* \_SB_.USB3._CRS.RBUF */
            }
        }

        Device (SUB0)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x12))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09000310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x09000400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb0", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0019
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }, 

                    Package (0x02)
                    {
                        "oc-gpio", 
                        Package (0x04)
                        {
                            SUB0, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x83, 
                    "sof_clk", 
                    SUB0
                }, 

                Package (0x03)
                {
                    0x68, 
                    "usb_aclk", 
                    SUB0
                }, 

                Package (0x03)
                {
                    0x8D, 
                    "lpm_clk", 
                    SUB0
                }, 

                Package (0x03)
                {
                    0x69, 
                    "usb_pclk", 
                    SUB0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x47, 
                    SUB0, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x4D, 
                    SUB0, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    SUB0, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    SUB0, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB0)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x09010000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09014000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09018000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000126,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000126,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000127,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000126,
                    }
                })
                Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "super-speed-plus"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "otg"
                        }, 

                        Package (0x02)
                        {
                            "cdnsp,usb3-phy", 
                            ^^UCP0.USBP
                        }
                    }, 

                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usb-role-switch", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x04)
                            {
                                \_SB.I2C7.PD00, 
                                "usbc_con0", 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        SUB0, 
                        CUB0, 
                        Zero
                    }
                })
            }
        }

        Device (U2P4)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x41, 
                    U2P4, 
                    "preset"
                }
            })
        }

        Device (UCP0)
        {
            Name (_HID, "CIXH2033")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09030000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cix,usbphy_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "svid", 
                        0xFF01
                    }, 

                    Package (0x02)
                    {
                        "default_conf", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "phy-status", 
                        "usb"
                    }
                }, 

                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "orientation-switch", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "mode-switch", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }, 

                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            \_SB.I2C7.PD00, 
                            "usbc_con0", 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            \_SB.I2C7.PD00, 
                            "port@2", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x6B, 
                    "pclk", 
                    UCP0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x33, 
                    UCP0, 
                    "preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x37, 
                    UCP0, 
                    "reset"
                }
            })
            Device (USBP)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (UDPP)
            {
                Name (_ADR, One)  // _ADR: Address
            }
        }

        Device (SUB1)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x13))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09070310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x09070400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb1", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x001A
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }, 

                    Package (0x02)
                    {
                        "oc-gpio", 
                        Package (0x04)
                        {
                            SUB1, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x84, 
                    "sof_clk", 
                    SUB1
                }, 

                Package (0x03)
                {
                    0x6C, 
                    "usb_aclk", 
                    SUB1
                }, 

                Package (0x03)
                {
                    0x8E, 
                    "lpm_clk", 
                    SUB1
                }, 

                Package (0x03)
                {
                    0x6D, 
                    "usb_pclk", 
                    SUB1
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x48, 
                    SUB1, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x4E, 
                    SUB1, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    SUB1, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    SUB1, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB1)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x09080000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09084000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09088000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000012C,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000012C,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000012D,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x0000012C,
                    }
                })
                Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "super-speed-plus"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "otg"
                        }, 

                        Package (0x02)
                        {
                            "cdnsp,usb3-phy", 
                            ^^UCP1.USBP
                        }
                    }, 

                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usb-role-switch", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x04)
                            {
                                \_SB.I2C7.PD01, 
                                "usbc_con0", 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        SUB1, 
                        CUB1, 
                        Zero
                    }
                })
            }
        }

        Device (U2P5)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x42, 
                    U2P5, 
                    "preset"
                }
            })
        }

        Device (UCP1)
        {
            Name (_HID, "CIXH2033")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x090A0000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "cix,usbphy_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "svid", 
                        0xFF01
                    }, 

                    Package (0x02)
                    {
                        "default_conf", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "phy-status", 
                        "usb"
                    }
                }, 

                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "orientation-switch", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "mode-switch", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }, 

                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            \_SB.I2C7.PD01, 
                            "usbc_con0", 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            \_SB.I2C7.PD01, 
                            "port@2", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x6F, 
                    "pclk", 
                    UCP1
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x34, 
                    UCP1, 
                    "preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x38, 
                    UCP1, 
                    "reset"
                }
            })
            Device (USBP)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (UDPP)
            {
                Name (_ADR, One)  // _ADR: Address
            }
        }

        Device (SUB2)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x16))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x090E0310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x090E0400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb2", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x001B
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }, 

                    Package (0x02)
                    {
                        "oc-gpio", 
                        Package (0x04)
                        {
                            SUB2, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x85, 
                    "sof_clk", 
                    SUB2
                }, 

                Package (0x03)
                {
                    0x70, 
                    "usb_aclk", 
                    SUB2
                }, 

                Package (0x03)
                {
                    0x8F, 
                    "lpm_clk", 
                    SUB2
                }, 

                Package (0x03)
                {
                    0x71, 
                    "usb_pclk", 
                    SUB2
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x4B, 
                    SUB2, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x51, 
                    SUB2, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    SUB2, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    SUB2, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB2)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x090F0000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x090F4000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x090F8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000132,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000132,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000133,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000132,
                    }
                })
                Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "super-speed-plus"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "otg"
                        }, 

                        Package (0x02)
                        {
                            "cdnsp,usb3-phy", 
                            ^^UCP2.USBP
                        }
                    }, 

                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usb-role-switch", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x04)
                            {
                                \_SB.I2C1.PD10, 
                                "usbc_con0", 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        SUB2, 
                        CUB2, 
                        Zero
                    }
                })
            }
        }

        Device (U2P8)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x45, 
                    U2P8, 
                    "preset"
                }
            })
        }

        Device (UCP2)
        {
            Name (_HID, "CIXH2033")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09110000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "cix,usbphy_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "svid", 
                        0xFF01
                    }, 

                    Package (0x02)
                    {
                        "default_conf", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "phy-status", 
                        "usb"
                    }
                }, 

                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "orientation-switch", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "mode-switch", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }, 

                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            \_SB.I2C1.PD10, 
                            "usbc_con0", 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            \_SB.I2C1.PD10, 
                            "port@2", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x73, 
                    "pclk", 
                    UCP2
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x35, 
                    UCP2, 
                    "preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x39, 
                    UCP2, 
                    "reset"
                }
            })
            Device (USBP)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (UDPP)
            {
                Name (_ADR, One)  // _ADR: Address
            }
        }

        Device (SUB3)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CCA, 0x0F)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x15))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09150310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x09150400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb3", ResourceConsumer, ,)
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x001C
                    }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x06)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }, 

                    Package (0x02)
                    {
                        "oc-gpio", 
                        Package (0x04)
                        {
                            SUB3, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x86, 
                    "sof_clk", 
                    SUB3
                }, 

                Package (0x03)
                {
                    0x74, 
                    "usb_aclk", 
                    SUB3
                }, 

                Package (0x03)
                {
                    0x90, 
                    "lpm_clk", 
                    SUB3
                }, 

                Package (0x03)
                {
                    0x75, 
                    "usb_pclk", 
                    SUB3
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x4C, 
                    SUB3, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x52, 
                    SUB3, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    SUB3, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    SUB3, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB3)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x09160000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09164000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09168000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000138,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000138,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000139,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000138,
                    }
                })
                Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "super-speed-plus"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "otg"
                        }, 

                        Package (0x02)
                        {
                            "cdnsp,usb3-phy", 
                            ^^UCP3.USBP
                        }
                    }, 

                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usb-role-switch", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "port@0", 
                            "PRT0"
                        }
                    }
                })
                Name (PRT0, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@0", 
                            "EP00"
                        }
                    }
                })
                Name (EP00, Package (0x02)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "remote-endpoint", 
                            Package (0x04)
                            {
                                \_SB.I2C1.PD11, 
                                "usbc_con0", 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        SUB3, 
                        CUB3, 
                        Zero
                    }
                })
            }
        }

        Device (U2P9)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x46, 
                    U2P9, 
                    "preset"
                }
            })
        }

        Device (UCP3)
        {
            Name (_HID, "CIXH2033")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09180000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x06)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "cix,usbphy_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "svid", 
                        0xFF01
                    }, 

                    Package (0x02)
                    {
                        "default_conf", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "phy-status", 
                        "usb"
                    }
                }, 

                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "orientation-switch", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "mode-switch", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }, 

                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP01"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x04)
                        {
                            \_SB.I2C1.PD11, 
                            "usbc_con0", 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (EP01, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            \_SB.I2C1.PD11, 
                            "port@2", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x01)
            {
                Package (0x03)
                {
                    0x77, 
                    "pclk", 
                    UCP3
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x36, 
                    UCP3, 
                    "preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x3A, 
                    UCP3, 
                    "reset"
                }
            })
            Device (USBP)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (UDPP)
            {
                Name (_ADR, One)  // _ADR: Address
            }
        }

        Device (SUB4)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x17))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x091C0314,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x091C0400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb4", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x87, 
                    "sof_clk", 
                    SUB4
                }, 

                Package (0x03)
                {
                    0x78, 
                    "usb_aclk", 
                    SUB4
                }, 

                Package (0x03)
                {
                    0x91, 
                    "lpm_clk", 
                    SUB4
                }, 

                Package (0x03)
                {
                    0x79, 
                    "usb_pclk", 
                    SUB4
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x49, 
                    SUB4, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x4F, 
                    SUB4, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    SUB4, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    SUB4, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB4)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, 0x04)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x091D0000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x091D4000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x091D8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000011C,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000011C,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000011D,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x0000011C,
                    }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "super-speed-plus"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "cdnsp,usb3-phy", 
                            ^^U3P4.USB0
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB4, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB4, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB4, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB4, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB4, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB4, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB4, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        SUB4, 
                        CUB4, 
                        Zero
                    }
                })
            }
        }

        Device (SUB5)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x18))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x091C0324,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x091C0410,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb5", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x05
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x88, 
                    "sof_clk", 
                    SUB5
                }, 

                Package (0x03)
                {
                    0x7B, 
                    "usb_aclk", 
                    SUB5
                }, 

                Package (0x03)
                {
                    0x92, 
                    "lpm_clk", 
                    SUB5
                }, 

                Package (0x03)
                {
                    0x7C, 
                    "usb_pclk", 
                    SUB5
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x4A, 
                    SUB5, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x50, 
                    SUB5, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    SUB5, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    SUB5, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB5)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, 0x05)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x091E0000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x091E4000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x091E8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000121,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000121,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000122,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000121,
                    }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "super-speed-plus"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "cdnsp,usb3-phy", 
                            ^^U3P4.USB1
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB5, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB5, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB5, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB5, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB5, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB5, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB5, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        SUB5, 
                        CUB5, 
                        Zero
                    }
                })
            }
        }

        Device (U2P6)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x43, 
                    U2P6, 
                    "preset"
                }
            })
        }

        Device (U2P7)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x44, 
                    U2P7, 
                    "preset"
                }
            })
        }

        Device (U3P4)
        {
            Name (_HID, "CIXH2034")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09210000,         // Address Base
                    0x00040000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "cix,usbphy_syscon", 
                        CRU0
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x7E, 
                    "apb_clk", 
                    U3P4
                }, 

                Package (0x03)
                {
                    0xA1, 
                    "ref_clk", 
                    U3P4
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x3B, 
                    U3P4, 
                    "preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x3C, 
                    U3P4, 
                    "reset"
                }
            })
            Device (USB0)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (USB1)
            {
                Name (_ADR, One)  // _ADR: Address
            }
        }

        Device (HUB0)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x14))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09250310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x09250400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb6", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x06
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x7F, 
                    "sof_clk", 
                    HUB0
                }, 

                Package (0x03)
                {
                    0x5C, 
                    "usb_aclk", 
                    HUB0
                }, 

                Package (0x03)
                {
                    0x89, 
                    "lpm_clk", 
                    HUB0
                }, 

                Package (0x03)
                {
                    0x5D, 
                    "usb_pclk", 
                    HUB0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x53, 
                    HUB0, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x57, 
                    HUB0, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    HUB0, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    HUB0, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB0)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x09260000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09264000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09268000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000110,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000110,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000111,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000110,
                    }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "high-speed"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "host"
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB0, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        HUB0, 
                        CUB0, 
                        Zero
                    }
                })
            }
        }

        Device (HUB1)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x1B))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x09280310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x09280400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb7", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x80, 
                    "sof_clk", 
                    HUB1
                }, 

                Package (0x03)
                {
                    0x5E, 
                    "usb_aclk", 
                    HUB1
                }, 

                Package (0x03)
                {
                    0x8A, 
                    "lpm_clk", 
                    HUB1
                }, 

                Package (0x03)
                {
                    0x5F, 
                    "usb_pclk", 
                    HUB1
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x54, 
                    HUB1, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x58, 
                    HUB1, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    HUB1, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    HUB1, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB1)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x09290000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09294000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x09298000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000113,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000113,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000114,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000113,
                    }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "high-speed"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "host"
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB1, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        HUB1, 
                        CUB1, 
                        Zero
                    }
                })
            }
        }

        Device (U2P0)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x3D, 
                    U2P0, 
                    "preset"
                }
            })
        }

        Device (U2P1)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x3E, 
                    U2P1, 
                    "preset"
                }
            })
        }

        Device (HUB2)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x1A))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x092B0310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x092B0400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb8", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x08
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x81, 
                    "sof_clk", 
                    HUB2
                }, 

                Package (0x03)
                {
                    0x60, 
                    "usb_aclk", 
                    HUB2
                }, 

                Package (0x03)
                {
                    0x8B, 
                    "lpm_clk", 
                    HUB2
                }, 

                Package (0x03)
                {
                    0x61, 
                    "usb_pclk", 
                    HUB2
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x55, 
                    HUB2, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x59, 
                    HUB2, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    HUB2, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    HUB2, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB2)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x092C0000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x092C4000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x092C8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000116,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000116,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000117,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000116,
                    }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "high-speed"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "host"
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB2, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        HUB2, 
                        CUB2, 
                        Zero
                    }
                })
            }
        }

        Device (U2P2)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x3F, 
                    U2P2, 
                    "preset"
                }
            })
        }

        Device (HUB3)
        {
            Name (_HID, "CIXH2030")  // _HID: Hardware ID
            Name (_UID, 0x09)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (GETV (0x19))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x092E0310,         // Address Base
                    0x00000004,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x092E0400,         // Address Base
                    0x00000004,         // Address Length
                    )
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "pinctrl_usb9", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x05)
                {
                    Package (0x02)
                    {
                        "id", 
                        0x09
                    }, 

                    Package (0x02)
                    {
                        "axi_bmax_value", 
                        0x07
                    }, 

                    Package (0x02)
                    {
                        "cix,usb_syscon", 
                        CRU0
                    }, 

                    Package (0x02)
                    {
                        "sof_clk_freq", 
                        0x007A1200
                    }, 

                    Package (0x02)
                    {
                        "lpm_clk_freq", 
                        0x7D00
                    }
                }
            })
            Name (CLKT, Package (0x04)
            {
                Package (0x03)
                {
                    0x82, 
                    "sof_clk", 
                    HUB3
                }, 

                Package (0x03)
                {
                    0x62, 
                    "usb_aclk", 
                    HUB3
                }, 

                Package (0x03)
                {
                    0x8C, 
                    "lpm_clk", 
                    HUB3
                }, 

                Package (0x03)
                {
                    0x63, 
                    "usb_pclk", 
                    HUB3
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x56, 
                    HUB3, 
                    "usb_preset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x5A, 
                    HUB3, 
                    "usb_reset"
                }
            })
            Name (RSNL, Package (0x02)
            {
                Package (0x04)
                {
                    HUB3, 
                    0x0200, 
                    Zero, 
                    "axi_property"
                }, 

                Package (0x04)
                {
                    HUB3, 
                    0x0200, 
                    One, 
                    "controller_status"
                }
            })
            Device (CUB3)
            {
                Name (_HID, "CIXH2031")  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0B)
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0x092F0000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x092F4000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x092F8000,         // Address Base
                        0x00008000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000119,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000119,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x0000011A,
                    }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, 0x00, "\\_SB.PDC0", )
                    {
                        0x00000119,
                    }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x02)
                    {
                        Package (0x02)
                        {
                            "maximum-speed", 
                            "high-speed"
                        }, 

                        Package (0x02)
                        {
                            "dr_mode", 
                            "host"
                        }
                    }
                })
                Name (RSNL, Package (0x07)
                {
                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        Zero, 
                        "host"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        One, 
                        "peripheral"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        0x02, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0400, 
                        0x03, 
                        "wakeup"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0200, 
                        Zero, 
                        "otg"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0200, 
                        One, 
                        "dev"
                    }, 

                    Package (0x04)
                    {
                        CUB3, 
                        0x0200, 
                        0x02, 
                        "xhci"
                    }
                })
                Name (DLKL, Package (0x01)
                {
                    Package (0x03)
                    {
                        HUB3, 
                        CUB3, 
                        Zero
                    }
                })
            }
        }

        Device (U2P3)
        {
            Name (_HID, "CIXH2032")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_STA, 0x0B)  // _STA: Status
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x40, 
                    U2P3, 
                    "preset"
                }
            })
        }

        Device (V4L2)
        {
            Name (_HID, "CIXH3020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x29))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000168,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x00000169,
                }
            })
        }

        Device (ISP0)
        {
            Name (_HID, "CIXH3021")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x29))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14340000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x14360000,         // Address Base
                    0x00050000,         // Address Length
                    )
            })
        }

        Device (ISP1)
        {
            Name (_HID, "CIXH3022")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
        }

        Device (ISP2)
        {
            Name (_HID, "CIXH3022")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
        }

        Device (ISP3)
        {
            Name (_HID, "CIXH3022")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
        }

        Device (ISPM)
        {
            Name (_HID, "CIXH3025")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x29))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x08)
                {
                    Package (0x02)
                    {
                        "ahb-pmctrl-res-base", 
                        0x16000404
                    }, 

                    Package (0x02)
                    {
                        "ahb-pmctrl-res-size", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "ahb-rcsuisp0-res-base", 
                        0x14330000
                    }, 

                    Package (0x02)
                    {
                        "ahb-rcsuisp0-res-size", 
                        0x1000
                    }, 

                    Package (0x02)
                    {
                        "ahb-rcsuisp1-res-base", 
                        0x14350000
                    }, 

                    Package (0x02)
                    {
                        "ahb-rcsuisp1-res-size", 
                        0x1000
                    }, 

                    Package (0x02)
                    {
                        "qos-read-priority", 
                        0x0F
                    }, 

                    Package (0x02)
                    {
                        "qos-write-priority", 
                        0x0F
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x44, 
                    "isp_aclk", 
                    ISPM
                }, 

                Package (0x03)
                {
                    0x45, 
                    "isp_sclk", 
                    ISPM
                }
            })
            Name (RSTL, Package (0x05)
            {
                Package (0x04)
                {
                    RST0, 
                    0x0F, 
                    ISPM, 
                    "isp_sreset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x10, 
                    ISPM, 
                    "isp_areset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x11, 
                    ISPM, 
                    "isp_hreset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x12, 
                    ISPM, 
                    "isp_gdcreset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x78, 
                    ISPM, 
                    "rcsu_reset"
                }
            })
            PowerResource (PRS0, 0x00, 0x0000)
            {
                OperationRegion (OPR0, SystemMemory, 0x14330020, 0x04)
                Field (OPR0, DWordAcc, NoLock, Preserve)
                {
                    MSK0,   32
                }

                Method (_STA, 0, Serialized)  // _STA: Status
                {
                    Local0 = MSK0 /* \_SB_.ISPM.PRS0.MSK0 */
                    Local1 = MSK0 /* \_SB_.ISPM.PRS0.MSK0 */
                    Local0 &= One
                    If ((Local0 > Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Local0 = MSK0 /* \_SB_.ISPM.PRS0.MSK0 */
                    Local0 = ((Local0 | One) | 0x0FFC)
                    MSK0 = Local0
                    DMRP (One, 0x07, 0x14330000, One)
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Local0 = MSK0 /* \_SB_.ISPM.PRS0.MSK0 */
                    Local0 &= 0xFFFFFFFFFFFFFFFE
                    MSK0 = Local0
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PRS0
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PRS0
            })
        }

        Device (VIHW)
        {
            Name (_HID, "CIXH3026")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (GETV (0x29))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E4,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E5,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E6,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E7,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E8,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E9,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EA,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EB,
                }
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x18)
                {
                    Package (0x02)
                    {
                        "ahb-dphy0-base", 
                        0x142A0000
                    }, 

                    Package (0x02)
                    {
                        "ahb-dphy0-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-dphy1-base", 
                        0x14300000
                    }, 

                    Package (0x02)
                    {
                        "ahb-dphy1-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi0-base", 
                        0x14280000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi0-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi1-base", 
                        0x14290000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi1-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi2-base", 
                        0x142E0000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi2-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi3-base", 
                        0x142F0000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csi3-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma0-base", 
                        0x142B0000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma0-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma1-base", 
                        0x142C0000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma1-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma2-base", 
                        0x14310000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma2-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma3-base", 
                        0x14320000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csidma3-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csircsu0-base", 
                        0x14270000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csircsu0-size", 
                        0x00010000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csircsu1-base", 
                        0x142D0000
                    }, 

                    Package (0x02)
                    {
                        "ahb-csircsu1-size", 
                        0x00010000
                    }
                }
            })
            Name (CLKT, Package (0x1A)
            {
                Package (0x03)
                {
                    0x19, 
                    "phy0_psmclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x1A, 
                    "phy1_psmclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x1B, 
                    "phy0_apbclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x1C, 
                    "phy1_apbclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x11, 
                    "csi0_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x12, 
                    "csi1_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x13, 
                    "csi2_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x14, 
                    "csi3_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB0, 
                    "csi0_sclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB1, 
                    "csi1_sclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB2, 
                    "csi2_sclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB3, 
                    "csi3_sclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB4, 
                    "csi0_p0clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB5, 
                    "csi0_p1clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB6, 
                    "csi0_p2clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB7, 
                    "csi0_p3clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB8, 
                    "csi1_p0clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xB9, 
                    "csi2_p0clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xBA, 
                    "csi2_p1clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xBB, 
                    "csi2_p2clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xBC, 
                    "csi2_p3clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0xBD, 
                    "csi3_p0clk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x15, 
                    "dma0_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x16, 
                    "dma1_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x17, 
                    "dma2_pclk", 
                    VIHW
                }, 

                Package (0x03)
                {
                    0x18, 
                    "dma3_pclk", 
                    VIHW
                }
            })
            Name (RSTL, Package (0x0E)
            {
                Package (0x04)
                {
                    RST0, 
                    0x20, 
                    VIHW, 
                    "phy0_prst"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x21, 
                    VIHW, 
                    "phy0_cmnrst"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x23, 
                    VIHW, 
                    "phy1_prst"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x24, 
                    VIHW, 
                    "phy1_cmnrst"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x5D, 
                    VIHW, 
                    "rcsu0_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x5E, 
                    VIHW, 
                    "rcsu1_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x22, 
                    VIHW, 
                    "csi0_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x25, 
                    VIHW, 
                    "csi1_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x26, 
                    VIHW, 
                    "csi2_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x27, 
                    VIHW, 
                    "csi3_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x28, 
                    VIHW, 
                    "csibridge0_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x29, 
                    VIHW, 
                    "csibridge1_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x2A, 
                    VIHW, 
                    "csibridge2_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x2B, 
                    VIHW, 
                    "csibridge3_reset"
                }
            })
        }

        Device (CSI0)
        {
            Name (_HID, "CIXH3027")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14270000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
        }

        Device (CSI1)
        {
            Name (_HID, "CIXH3027")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x142D0000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
        }

        Device (CBD0)
        {
            Name (_HID, "CIXH3028")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x142B0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EC,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "interface", 
                        Package (0x02)
                        {
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "axi-uid", 
                        0x21
                    }, 

                    Package (0x02)
                    {
                        "csi-dma-id", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        CSI0
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC0, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x15, 
                    "dma_pclk", 
                    CBD0
                }, 

                Package (0x03)
                {
                    0x45, 
                    "dma_sclk", 
                    CBD0
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x28, 
                    CBD0, 
                    "csibridge_reset"
                }
            })
        }

        Device (CBD1)
        {
            Name (_HID, "CIXH3028")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x142C0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001ED,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "interface", 
                        Package (0x02)
                        {
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "axi-uid", 
                        0x21
                    }, 

                    Package (0x02)
                    {
                        "csi-dma-id", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        CSI0
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC1, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x16, 
                    "dma_pclk", 
                    CBD1
                }, 

                Package (0x03)
                {
                    0x45, 
                    "dma_sclk", 
                    CBD1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x29, 
                    CBD1, 
                    "csibridge_reset"
                }
            })
        }

        Device (CBD2)
        {
            Name (_HID, "CIXH3028")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14310000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EE,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "interface", 
                        Package (0x02)
                        {
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "axi-uid", 
                        0x22
                    }, 

                    Package (0x02)
                    {
                        "csi-dma-id", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        CSI1
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC2, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x17, 
                    "dma_pclk", 
                    CBD2
                }, 

                Package (0x03)
                {
                    0x45, 
                    "dma_sclk", 
                    CBD2
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x2A, 
                    CBD2, 
                    "csibridge_reset"
                }
            })
        }

        Device (CBD3)
        {
            Name (_HID, "CIXH3028")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14320000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EF,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "interface", 
                        Package (0x02)
                        {
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "axi-uid", 
                        0x21
                    }, 

                    Package (0x02)
                    {
                        "csi-dma-id", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        CSI1
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC3, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x18, 
                    "dma_pclk", 
                    CBD3
                }, 

                Package (0x03)
                {
                    0x45, 
                    "dma_sclk", 
                    CBD3
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x2B, 
                    CBD3, 
                    "csibridge_reset"
                }
            })
        }

        Device (MPC0)
        {
            Name (_HID, "CIXH3029")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14280000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E4,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E5,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "lanes", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cix-csi", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DPR1, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            CBD0, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x06)
            {
                Package (0x03)
                {
                    0x11, 
                    "csi_pclk", 
                    MPC0
                }, 

                Package (0x03)
                {
                    0xB0, 
                    "csi_sclk", 
                    MPC0
                }, 

                Package (0x03)
                {
                    0xB4, 
                    "csi_p0clk", 
                    MPC0
                }, 

                Package (0x03)
                {
                    0xB5, 
                    "csi_p1clk", 
                    MPC0
                }, 

                Package (0x03)
                {
                    0xB6, 
                    "csi_p2clk", 
                    MPC0
                }, 

                Package (0x03)
                {
                    0xB7, 
                    "csi_p3clk", 
                    MPC0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x5D, 
                    MPC0, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x22, 
                    MPC0, 
                    "csi_reset"
                }
            })
        }

        Device (MPC1)
        {
            Name (_HID, "CIXH3029")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14290000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E6,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E7,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "lanes", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cix-csi", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DPR2, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            CBD1, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x12, 
                    "csi_pclk", 
                    MPC1
                }, 

                Package (0x03)
                {
                    0xB1, 
                    "csi_sclk", 
                    MPC1
                }, 

                Package (0x03)
                {
                    0xB8, 
                    "csi_p0clk", 
                    MPC1
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x25, 
                    MPC1, 
                    "csi_reset"
                }
            })
        }

        Device (MPC2)
        {
            Name (_HID, "CIXH3029")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x142E0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E8,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001E9,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "lanes", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cix-csi", 
                        0x02
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DPR4, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            CBD2, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x06)
            {
                Package (0x03)
                {
                    0x13, 
                    "csi_pclk", 
                    MPC2
                }, 

                Package (0x03)
                {
                    0xB2, 
                    "csi_sclk", 
                    MPC2
                }, 

                Package (0x03)
                {
                    0xB9, 
                    "csi_p0clk", 
                    MPC2
                }, 

                Package (0x03)
                {
                    0xBA, 
                    "csi_p1clk", 
                    MPC2
                }, 

                Package (0x03)
                {
                    0xBB, 
                    "csi_p2clk", 
                    MPC2
                }, 

                Package (0x03)
                {
                    0xBC, 
                    "csi_p3clk", 
                    MPC2
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x5E, 
                    MPC2, 
                    "rcsu_reset"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x26, 
                    MPC2, 
                    "csi_reset"
                }
            })
        }

        Device (MPC3)
        {
            Name (_HID, "CIXH3029")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x142F0000,         // Address Base
                    0x00010000,         // Address Length
                    )
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EA,
                }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                {
                    0x000001EB,
                }
            })
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "lanes", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cix-csi", 
                        0x03
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            DPR5, 
                            "port@1", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            CBD3, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }
                }
            })
            Name (CLKT, Package (0x03)
            {
                Package (0x03)
                {
                    0x14, 
                    "csi_pclk", 
                    MPC3
                }, 

                Package (0x03)
                {
                    0xB3, 
                    "csi_sclk", 
                    MPC3
                }, 

                Package (0x03)
                {
                    0xBD, 
                    "csi_p0clk", 
                    MPC3
                }
            })
            Name (RSTL, Package (0x01)
            {
                Package (0x04)
                {
                    RST0, 
                    0x27, 
                    MPC3, 
                    "csi_reset"
                }
            })
        }

        Device (DPH0)
        {
            Name (_HID, "CIXH302A")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x142A0000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "cix-dphy-hw", 
                        Zero
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x19, 
                    "phy_psmclk", 
                    DPH0
                }, 

                Package (0x03)
                {
                    0x1B, 
                    "phy_apbclk", 
                    DPH0
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x20, 
                    DPH0, 
                    "phy_prst"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x21, 
                    DPH0, 
                    "phy_cmnrst"
                }
            })
        }

        Device (DPH1)
        {
            Name (_HID, "CIXH302A")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0x14300000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "cix-dphy-hw", 
                        One
                    }
                }
            })
            Name (CLKT, Package (0x02)
            {
                Package (0x03)
                {
                    0x1A, 
                    "phy_psmclk", 
                    DPH1
                }, 

                Package (0x03)
                {
                    0x1C, 
                    "phy_apbclk", 
                    DPH1
                }
            })
            Name (RSTL, Package (0x02)
            {
                Package (0x04)
                {
                    RST0, 
                    0x23, 
                    DPH1, 
                    "phy_prst"
                }, 

                Package (0x04)
                {
                    RST0, 
                    0x24, 
                    DPH1, 
                    "phy_cmnrst"
                }
            })
        }

        Device (DPR0)
        {
            Name (_HID, "CIXH302B")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix-dphy", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        DPH0
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            ^I2C0.UXC0, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "data-lanes", 
                        Package (0x04)
                        {
                            One, 
                            0x02, 
                            0x03, 
                            0x04
                        }
                    }, 

                    Package (0x02)
                    {
                        "clock-lanes", 
                        Package (0x01)
                        {
                            Zero
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC0, 
                            "port@0", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (DPR1)
        {
            Name (_HID, "CIXH302B")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix-dphy", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        DPH0
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            ^I2C0.UXC0, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "data-lanes", 
                        Package (0x04)
                        {
                            One, 
                            0x02, 
                            0x03, 
                            0x04
                        }
                    }, 

                    Package (0x02)
                    {
                        "clock-lanes", 
                        Package (0x01)
                        {
                            Zero
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC0, 
                            "port@0", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (DPR2)
        {
            Name (_HID, "CIXH302B")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix-dphy", 
                        0x02
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        DPH0
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            ^I2C0.UXC1, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "data-lanes", 
                        Package (0x04)
                        {
                            One, 
                            0x02, 
                            0x03, 
                            0x04
                        }
                    }, 

                    Package (0x02)
                    {
                        "clock-lanes", 
                        Package (0x01)
                        {
                            Zero
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC1, 
                            "port@0", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (DPR3)
        {
            Name (_HID, "CIXH302B")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix-dphy", 
                        0x03
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        DPH1
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            ^I2C0.UXC0, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "data-lanes", 
                        Package (0x04)
                        {
                            One, 
                            0x02, 
                            0x03, 
                            0x04
                        }
                    }, 

                    Package (0x02)
                    {
                        "clock-lanes", 
                        Package (0x01)
                        {
                            Zero
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC2, 
                            "port@0", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (DPR4)
        {
            Name (_HID, "CIXH302B")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix-dphy", 
                        0x04
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        DPH1
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            ^I2C0.UXC2, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "data-lanes", 
                        Package (0x04)
                        {
                            One, 
                            0x02, 
                            0x03, 
                            0x04
                        }
                    }, 

                    Package (0x02)
                    {
                        "clock-lanes", 
                        Package (0x01)
                        {
                            Zero
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC2, 
                            "port@0", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Device (DPR5)
        {
            Name (_HID, "CIXH302B")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
            Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "cix-dphy", 
                        0x05
                    }, 

                    Package (0x02)
                    {
                        "cix,hw", 
                        DPH1
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "port@0", 
                        "PRT0"
                    }, 

                    Package (0x02)
                    {
                        "port@1", 
                        "PRT1"
                    }
                }
            })
            Name (PRT0, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@1", 
                        "EP00"
                    }
                }
            })
            Name (EP00, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x04)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            ^I2C0.UXC3, 
                            "port@0", 
                            "endpoint@0"
                        }
                    }, 

                    Package (0x02)
                    {
                        "data-lanes", 
                        Package (0x04)
                        {
                            One, 
                            0x02, 
                            0x03, 
                            0x04
                        }
                    }, 

                    Package (0x02)
                    {
                        "clock-lanes", 
                        Package (0x01)
                        {
                            Zero
                        }
                    }
                }
            })
            Name (PRT1, Package (0x04)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "reg", 
                        One
                    }
                }, 

                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "endpoint@0", 
                        "EP10"
                    }
                }
            })
            Name (EP10, Package (0x02)
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "reg", 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        "remote-endpoint", 
                        Package (0x03)
                        {
                            MPC3, 
                            "port@0", 
                            "endpoint@1"
                        }
                    }
                }
            })
        }

        Name (GNVA, 0xFFFE0000)
        Name (GNVL, 0x002A)
        Method (GETV, 1, Serialized)
        {
            If ((Arg0 >= 0x2A))
            {
                Return (Zero)
            }

            Local0 = (Arg0 + GNVA) /* \_SB_.GNVA */
            OperationRegion (GPNV, SystemMemory, Local0, One)
            Field (GPNV, ByteAcc, NoLock, Preserve)
            {
                VARV,   8
            }

            Return (VARV) /* \_SB_.GETV.VARV */
        }

        Method (MVCK, 1, Serialized)
        {
            OperationRegion (S5R1, SystemMemory, 0x16000504, 0x04)
            Field (S5R1, DWordAcc, NoLock, Preserve)
            {
                MSK0,   32
            }

            Local0 = Arg0
            Local1 = MSK0 /* \_SB_.MVCK.MSK0 */
            Local1 = ((Local1 >> Local0) & One)
            Debug = Concatenate (Concatenate (Concatenate (Concatenate ("ACPI debug:arg0=", Arg0), ", MVCK.valid = "), Local1
                ), "\n")
            Return (Local1)
        }

        Method (DMRP, 4, Serialized)
        {
            Debug = Concatenate (Concatenate (Concatenate (Concatenate (Concatenate (Concatenate (Concatenate (Concatenate ("ACPI debug: Arg0:Arg1:Arg2:Arg3 = ", Arg0
                ), ":"), Arg1), ":"), Arg2), ":"), Arg3), 
                "\n")
            If ((Arg0 && MVCK (Arg1)))
            {
                OperationRegion (PDRG, SystemMemory, Arg2, 0x20)
                Field (PDRG, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    PASS,   32, 
                    ENBL,   32, 
                    BUSY,   32
                }

                Local0 = 0x00989680
                Local1 = BUSY /* \_SB_.DMRP.BUSY */
                Local1 = ((Local1 >> 0x10) & 0xFFFF)
                While (((Local1 != Zero) && (Local0 != Zero)))
                {
                    Local0--
                    If ((Local0 == Zero))
                    {
                        Debug = Concatenate (Concatenate ("Do memory busy, status = ", Local1), "!\n")
                    }

                    Local1 = BUSY /* \_SB_.DMRP.BUSY */
                    Local1 = ((Local1 >> 0x10) & 0xFFFF)
                }

                ENBL = Arg3
                Debug = Concatenate (Concatenate ("group_en = 0x", ENBL), "!\n")
                Local1 = PASS /* \_SB_.DMRP.PASS */
                Local1 = ((Local1 >> One) & 0x03)
                While (((Local1 != 0x03) && (Local0 != Zero)))
                {
                    Local0--
                    If ((Local0 == Zero))
                    {
                        Debug = Concatenate (Concatenate ("Done and pass failed, status = ", Local1), "!\n")
                    }

                    Local1 = PASS /* \_SB_.DMRP.PASS */
                    Local1 = ((Local1 >> One) & 0x03)
                }

                ENBL = Zero
                Debug = Concatenate (Concatenate ("group_en = 0x", ENBL), "!\n")
                Return (ENBL) /* \_SB_.DMRP.ENBL */
            }

            Return (Zero)
        }

        Device (TEE0)
        {
            Name (_HID, "CIXHA022")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CID, "PRP0001")  // _CID: Compatible ID
            Name (_STA, 0x0B)  // _STA: Status
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x02)
                {
                    Package (0x02)
                    {
                        "compatible", 
                        "linaro,optee-tz"
                    }, 

                    Package (0x02)
                    {
                        "method", 
                        "smc"
                    }
                }
            })
        }
    }
}

