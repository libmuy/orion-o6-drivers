/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ssdt1.dat
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00002D93 (11667)
 *     Revision         0x05
 *     Checksum         0xCF
 *     OEM ID           "CIXTEK"
 *     OEM Table ID     "SKY1EDK2"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 5, "CIXTEK", "SKY1EDK2", 0x00000001)
{
    External (_SB_.GPI4, DeviceObj)
    External (_SB_.HDA_, UnknownObj)
    External (_SB_.I2C0, DeviceObj)
    External (_SB_.I2C1, DeviceObj)
    External (_SB_.I2C2, DeviceObj)
    External (_SB_.I2C3, DeviceObj)
    External (_SB_.I2C4, DeviceObj)
    External (_SB_.I2C7, DeviceObj)
    External (_SB_.I3C0, DeviceObj)
    External (_SB_.ISP0, UnknownObj)
    External (_SB_.SPI0, DeviceObj)
    External (_SB_.SPI1, DeviceObj)
    External (_SB_.SUB0.CUB0, UnknownObj)
    External (_SB_.SUB1.CUB1, UnknownObj)
    External (_SB_.SUB2.CUB2, UnknownObj)
    External (_SB_.SUB3.CUB3, UnknownObj)
    External (_SB_.UCP0, UnknownObj)
    External (_SB_.UCP1, UnknownObj)
    External (_SB_.UCP2, UnknownObj)
    External (_SB_.UCP3, UnknownObj)
    External (_SB_.UDBG, MethodObj)    // 1 Arguments

    Scope (_SB)
    {
        Device (HDAC)
        {
            Name (_HID, "CIXH6030")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (DLKL, Package (0x01)
            {
                Package (0x03)
                {
                    \_SB.HDA, 
                    \_SB.HDAC, 
                    Zero
                }
            })
        }

        Scope (\_SB.I2C2)
        {
            Device (RTL5)
            {
                Name (_HID, "RTL5682")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x0000,
                        "\\_SB.GPI3", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000A
                        }
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_alc5682_irq", ResourceConsumer, ,)
                    I2cSerialBusV2 (0x001A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C2",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x04)
                    {
                        Package (0x02)
                        {
                            "realtek,dmic1-data-pin", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "realtek,dmic-clk-pin", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "realtek,dmic-clk-rate-hz", 
                            0x001F4000
                        }, 

                        Package (0x02)
                        {
                            "realtek,jd-src", 
                            One
                        }
                    }
                })
            }
        }

        Device (SNDC)
        {
            Name (_HID, "CIXH6070")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, 0x0F)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                    "pinctrl_sndcard", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "sndcard-idx", 
                        0x03
                    }
                }
            })
        }

        Scope (\_SB.SPI0)
        {
            Device (TP1)
            {
                Name (_HID, "SPT0001")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        SpiSerialBusV2 (0x0000, PolarityLow, FourWireMode, 0x08,
                            ControllerInitiated, 0x0007A120, ClockPolarityLow,
                            ClockPhaseFirst, "\\_SB.SPI0",
                            0x00, ResourceConsumer, , Exclusive,
                            )
                    })
                    Return (RBUF) /* \_SB_.SPI0.TP1_._CRS.RBUF */
                }
            }
        }

        Scope (\_SB.I2C3)
        {
            Device (RTC0)
            {
                Name (_HID, "RX8900")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0032, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C3",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                        "pinctrl_ra8900ce_irq", ResourceConsumer, ,)
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000A
                        }
                })
            }
        }

        Scope (\_SB.I2C2)
        {
            Device (MMC0)
            {
                Name (_HID, "CIXHA011")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0030, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C2",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
            }
        }

        Scope (\_SB.I3C0)
        {
            Device (MMC1)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0030, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I3C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
            }
        }

        Scope (\_SB.I2C0)
        {
            Device (IIS0)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0034, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam0_hw", ResourceConsumer, ,)
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0012,
                            0x0010,
                            0x000C,
                            0x000F
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x07)
                    {
                        Package (0x02)
                        {
                            "actuator-src", 
                            \_SB.I2C0.MTR0
                        }, 

                        Package (0x02)
                        {
                            "isp-src", 
                            \_SB.ISP0
                        }, 

                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            Zero
                        }, 

                        Package (0x02)
                        {
                            "pwren-gpios", 
                            Package (0x04)
                            {
                                ^IIS0, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwren0-gpios", 
                            Package (0x04)
                            {
                                ^IIS0, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS0, 
                                Zero, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS0, 
                                Zero, 
                                0x03, 
                                Zero
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x48, 
                        "mclk", 
                        \_SB.I2C0.IIS0
                    }
                })
            }

            Device (MTR0)
            {
                Name (_HID, "CIXH3023")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0040, ControllerInitiated, 0x0773593F,
                        AddressingMode7Bit, "\\_SB.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "pi-max-frequency", 
                            0x0773593F
                        }
                    }
                })
            }
        }

        Scope (\_SB.I2C1)
        {
            Device (IIS2)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_STA, Zero)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0038, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C1",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam2_hw", ResourceConsumer, ,)
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000B,
                            0x0008,
                            0x000A,
                            0x0007
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            0x02
                        }, 

                        Package (0x02)
                        {
                            "pwren-gpios", 
                            Package (0x04)
                            {
                                ^IIS2, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwren0-gpios", 
                            Package (0x04)
                            {
                                ^IIS2, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS2, 
                                Zero, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS2, 
                                Zero, 
                                0x03, 
                                Zero
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x4A, 
                        "mclk", 
                        \_SB.I2C1.IIS2
                    }
                })
            }
        }

        Scope (\_SB.I2C3)
        {
            Device (IIS1)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0036, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C3",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam1_hw", ResourceConsumer, ,)
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0012,
                            0x0010,
                            0x0011,
                            0x0013
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            One
                        }, 

                        Package (0x02)
                        {
                            "pwren-gpios", 
                            Package (0x04)
                            {
                                ^IIS1, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwren0-gpios", 
                            Package (0x04)
                            {
                                ^IIS1, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS1, 
                                Zero, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS1, 
                                Zero, 
                                0x03, 
                                Zero
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x49, 
                        "mclk", 
                        \_SB.I2C3.IIS1
                    }
                })
            }
        }

        Scope (\_SB.I2C4)
        {
            Device (IIS3)
            {
                Name (_HID, "CIXH3024")  // _HID: Hardware ID
                Name (_UID, 0x03)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CCA, Zero)  // _CCA: Cache Coherency Attribute
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x003A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.I2C4",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX0", 0x00,
                        "pinctrl_cam3_hw", ResourceConsumer, ,)
                    GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                        "\\_SB.GPI1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000B,
                            0x0008,
                            0x000D,
                            0x000E
                        }
                })
                Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x05)
                    {
                        Package (0x02)
                        {
                            "cix,camera-module-index", 
                            0x03
                        }, 

                        Package (0x02)
                        {
                            "pwren-gpios", 
                            Package (0x04)
                            {
                                ^IIS3, 
                                Zero, 
                                Zero, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwren0-gpios", 
                            Package (0x04)
                            {
                                ^IIS3, 
                                Zero, 
                                One, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "reset-gpios", 
                            Package (0x04)
                            {
                                ^IIS3, 
                                Zero, 
                                0x02, 
                                Zero
                            }
                        }, 

                        Package (0x02)
                        {
                            "pwdn-gpios", 
                            Package (0x04)
                            {
                                ^IIS3, 
                                Zero, 
                                0x03, 
                                Zero
                            }
                        }
                    }
                })
                Name (CLKT, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x4B, 
                        "mclk", 
                        \_SB.I2C4.IIS3
                    }
                })
            }
        }

        Device (RFKL)
        {
            Name (_HID, "CIXH7000")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_STA, Zero)  // _STA: Status
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x000A,
                        0x000C
                    }
                GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone, 0x0000,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0019
                    }
                PinGroupFunction (Exclusive, 0x0000, "\\_SB.MUX1", 0x00,
                    "wifi_vbat_gpio", ResourceConsumer, ,)
            })
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                Package (0x03)
                {
                    Package (0x02)
                    {
                        "poweren-gpios", 
                        Package (0x04)
                        {
                            ^RFKL, 
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "vbat-gpios", 
                        Package (0x04)
                        {
                            ^RFKL, 
                            Zero, 
                            One, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        "wakehost-gpios", 
                        Package (0x04)
                        {
                            ^RFKL, 
                            One, 
                            Zero, 
                            Zero
                        }
                    }
                }
            })
        }

        Device (EC0)
        {
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_HID, "CIXHA015")  // _HID: Hardware ID
            Mutex (ECMX, 0x00)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x03)
            }

            OperationRegion (I2CA, SystemMemory, 0x04070000, 0x0100)
            Field (I2CA, DWordAcc, NoLock, Preserve)
            {
                CR,     32, 
                SR,     32, 
                AR,     32, 
                DR,     32, 
                ISR,    32, 
                TSR,    32, 
                SMPR,   32, 
                TOR,    32, 
                IMR,    32, 
                IER,    32, 
                IDR,    32, 
                GFCR,   32
            }

            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                REST ()
            }

            Method (REST, 0, Serialized)
            {
                IDR = 0x02FF
                Local0 = CR /* \_SB_.EC0_.CR__ */
                Local0 &= 0xFFFFFFFFFFFFFFEF
                Local0 |= 0x40
                CR = Local0
                TSR = Zero
                Local0 = ISR /* \_SB_.EC0_.ISR_ */
                ISR = Local0
                Local0 = SR /* \_SB_.EC0_.SR__ */
                SR = Local0
            }

            Method (STAT, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                If (!(Local0 & 0x04))
                {
                    CR = (Local0 | 0x04)
                }

                CLRB ()
                Local1 = 0x00989680
                While (Local1)
                {
                    Local0 = SR /* \_SB_.EC0_.SR__ */
                    If (!(Local0 & 0x0100))
                    {
                        Break
                    }

                    Local1--
                }

                If ((Local1 == Zero))
                {
                    Return (0x02)
                }

                SETB ()
                Return (Zero)
            }

            Method (STOP, 0, Serialized)
            {
                CLRB ()
                CLRF ()
            }

            Method (READ, 4, Serialized)
            {
                If ((Arg1 == Zero))
                {
                    Return (Zero)
                }

                If ((Arg1 > 0x10))
                {
                    TSR = 0x11
                }
                Else
                {
                    TSR = Arg1
                }

                Local0 = CR /* \_SB_.EC0_.CR__ */
                Local0 |= One
                CR = Local0
                AR = (Arg0 & 0x03FF)
                Local3 = Zero
                While ((Arg1 != Zero))
                {
                    Local0 = ISR /* \_SB_.EC0_.ISR_ */
                    ISR = Local0
                    If ((Local0 & 0x08))
                    {
                        Return (0x02)
                    }

                    If ((Local0 & 0x04))
                    {
                        Return (One)
                    }

                    Local0 &= 0xFFFFFFFFFFFFFFFD
                    Local0 &= 0xFFFFFFFFFFFFFFFE
                    If ((Local0 != Zero))
                    {
                        Return (One)
                    }

                    If ((Arg1 <= 0x10))
                    {
                        Local1 = One
                    }
                    Else
                    {
                        Local1 = Zero
                    }

                    If ((Local1 == One))
                    {
                        If ((SR & 0x20))
                        {
                            Arg2 [Local3] = DR /* \_SB_.EC0_.DR__ */
                            Local3 += One
                            Arg1 -= One
                        }

                        Continue
                    }

                    Local4 = TSR /* \_SB_.EC0_.TSR_ */
                    If ((Local4 != One))
                    {
                        Continue
                    }

                    Local5 = (Arg1 - 0x10)
                    If ((Local5 > 0x10))
                    {
                        TSR = 0x11
                    }
                    Else
                    {
                        TSR = Local5
                    }

                    Local5 = 0x10
                    While ((Local5 != Zero))
                    {
                        Arg2 [Local3] = DR /* \_SB_.EC0_.DR__ */
                        Local3 += One
                        Arg1 -= One
                        Local5 -= One
                    }
                }

                Return (Zero)
            }

            Method (WRIT, 4, Serialized)
            {
                If ((Arg1 == Zero))
                {
                    Return (Zero)
                }

                Local0 = IER /* \_SB_.EC0_.IER_ */
                Local0 |= One
                IER = Local0
                Local0 = CR /* \_SB_.EC0_.CR__ */
                Local0 &= 0xFFFFFFFFFFFFFFFE
                CR = Local0
                Local0 = ISR /* \_SB_.EC0_.ISR_ */
                ISR = Local0
                TSR = Zero
                AR = (Arg0 & 0x03FF)
                Local0 = Zero
                Local1 = Arg1
                DR = DerefOf (Arg2 [Local0])
                Local0++
                Local1--
                While (One)
                {
                    If ((Local1 <= 0x0F))
                    {
                        Local2 = One
                        Local3 = Local1
                    }
                    Else
                    {
                        Local2 = Zero
                        Local3 = 0x0F
                    }

                    Local4 = Local3
                    While ((Local4 > Zero))
                    {
                        DR = DerefOf (Arg2 [Local0])
                        Local1--
                        Local4--
                        Local0++
                    }

                    If (Local2)
                    {
                        TSR = (Local3 + One)
                    }
                    Else
                    {
                        TSR = Local3
                    }

                    Local5 = 0x00989680
                    While (One)
                    {
                        Local6 = ISR /* \_SB_.EC0_.ISR_ */
                        ISR = Local6
                        Local6 &= 0xFFFFFFFFFFFFFFFD
                        Local5--
                        If (((Local5 == Zero) || (Local6 != Zero)))
                        {
                            Break
                        }
                    }

                    If ((Local5 == Zero))
                    {
                        Return (0x02)
                    }

                    If ((Local6 & 0xFFFFFFFFFFFFFFFE))
                    {
                        If ((Local6 & 0x08))
                        {
                            Return (0x02)
                        }

                        If ((Local6 & 0x40))
                        {
                            CLRF ()
                        }

                        Return (One)
                    }

                    If (Local2)
                    {
                        Return (Zero)
                    }
                }

                Return (Zero)
            }

            Method (CKSB, 1, Serialized)
            {
                Local0 = SizeOf (Arg0)
                Local1 = Zero
                Local2 = Zero
                While ((Local1 < Local0))
                {
                    If ((Local1 != One))
                    {
                        Mid (Arg0, Local1, One, Local3)
                        Local2 += ToInteger (Local3)
                    }

                    Local1++
                }

                Return ((0x0100 - (Local2 & 0xFF)))
            }

            Method (CLRB, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                If ((Local0 & 0x10))
                {
                    CR = (Local0 & 0xFFFFFFFFFFFFFFEF)
                }
            }

            Method (SETB, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                If (!(Local0 & 0x10))
                {
                    CR = (Local0 | 0x10)
                }
            }

            Method (CLRF, 0, Serialized)
            {
                Local0 = CR /* \_SB_.EC0_.CR__ */
                CR = (Local0 | 0x40)
                While ((CR & 0x40)){}
            }

            Method (TRAS, 4, Serialized)
            {
                Acquire (ECMX, 0xFFFF)
                Local0 = Zero
                While (One)
                {
                    If ((STAT () != Zero))
                    {
                        Break
                    }

                    CLRF ()
                    Local1 = ISR /* \_SB_.EC0_.ISR_ */
                    ISR = Local1
                    If ((WRIT (0x76, Arg1, Arg0, Zero) != Zero))
                    {
                        Break
                    }

                    If ((READ (0x76, Arg3, Arg2, One) != Zero))
                    {
                        Break
                    }

                    Local0 = One
                    Break
                }

                If ((Local0 == Zero))
                {
                    REST ()
                    STOP ()
                    Return (One)
                }

                Release (ECMX)
                CreateByteField (Arg2, One, LENG)
                If ((LENG != Arg3))
                {
                    Return (One)
                }

                CreateByteField (Arg2, 0x03, CSUM)
                Mid (Arg2, 0x02, (LENG - 0x02), Local1)
                If ((CSUM != (CKSB (Local1) & 0xFF)))
                {
                    Return (One)
                }

                Return (Zero)
            }

            Method (EVNT, 0, Serialized)
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0xA8, 0x00, 0x55, 0x00, 0x00, 0x00,  // ....U...
                    /* 0008 */  0x00                                             // .
                })
                Name (BUF1, Buffer (0x0F){})
                If ((TRAS (BUF0, SizeOf (BUF0), BUF1, 0x0F) == Zero))
                {
                    CreateByteField (BUF1, 0x0A, TYPE)
                    CreateDWordField (BUF1, 0x0B, DATA)
                    Local0 = DATA /* \_SB_.EC0_.EVNT.DATA */
                    Local0 = (((((Local0 & 0xFF) << 0x18) | (
                        (Local0 & 0xFF00) << 0x08)) | ((Local0 & 0x00FF0000) >> 0x08
                        )) | ((Local0 & 0xFF000000) >> 0x18))
                    NTII (Local0)
                }
            }

            Method (NTII, 1, Serialized)
            {
                If ((Arg0 & 0x02))
                {
                    Notify (\_SB.PWRB, 0x80) // Status Change
                }

                If ((Arg0 & 0x0C))
                {
                    Notify (\_SB.AC, 0x80) // Status Change
                    Notify (\_SB.BAT0, 0x80) // Status Change
                }

                If ((Arg0 & 0x4000))
                {
                    Notify (\_SB.AC, 0x80) // Status Change
                    Notify (\_SB.BAT0, 0x81) // Information Change
                }

                If ((Arg0 & 0x0100))
                {
                    Notify (\_SB.LID, 0x80) // Status Change
                }

                If ((Arg0 & 0x0200)){}
                If ((Arg0 & 0x0400)){}
                If ((Arg0 & 0x0800)){}
            }

            Method (WRGP, 2, Serialized)
            {
                Name (BUF0, Buffer (0x0B)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x92, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x02, 0x00, 0x00                                 // ...
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, GNUM)
                CreateByteField (BUF0, 0x0A, GVAL)
                GNUM = Arg0
                GVAL = Arg1
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0B){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (RDGP, 1, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x93, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, GNUM)
                GNUM = Arg0
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0B){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                Sleep (0x14)
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                CreateByteField (BUF1, 0x0A, GVAL)
                Return (GVAL) /* \_SB_.EC0_.RDGP.GVAL */
            }

            Method (GKBL, 0, Serialized)
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x22, 0x00, 0x00, 0x00,  // ...."...
                    /* 0008 */  0x00                                             // .
                })
                CreateByteField (BUF0, 0x02, CSUM)
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0C){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                CreateByteField (BUF1, 0x0A, KBLP)
                CreateByteField (BUF1, 0x0B, KBLE)
                Return (Package (0x02)
                {
                    KBLP, 
                    KBLE
                })
            }

            Method (SKBL, 1, Serialized)
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00,  // ....#...
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                CreateByteField (BUF0, 0x02, CSUM)
                CreateByteField (BUF0, 0x09, KBLP)
                KBLP = Arg0
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0B){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
            }

            Method (GLSS, 0, Serialized)
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00,  // ....2...
                    /* 0008 */  0x00                                             // .
                })
                CreateByteField (BUF0, 0x02, CSUM)
                Mid (BUF0, One, (SizeOf (BUF0) - One), Local0)
                CSUM = (CKSB (Local0) & 0xFF)
                Name (BUF1, Buffer (0x0F){})
                TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1))
                CreateByteField (BUF1, 0x0A, LSST)
                CreateDWordField (BUF1, 0x0B, LSSV)
                Return (Package (0x02)
                {
                    LSST, 
                    LSSV
                })
            }
        }

        Scope (\_SB.GPI4)
        {
            Name (_AEI, ResourceTemplate ()  // _AEI: ACPI Event Interrupts
            {
                GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                    "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0006
                    }
            })
            Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
            {
                \_SB.EC0.EVNT ()
            }
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_PCL, 0, NotSerialized)  // _PCL: Power Consumer List
            {
                Return (Package (0x01)
                {
                    _SB
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xF5, 0x06, 0x01, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                Name (BUF1, Buffer (0x18){})
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, 0x18) == Zero))
                {
                    CreateWordField (BUF1, 0x12, FLAG)
                    Local0 = FLAG /* \_SB_.BAT0._STA.FLAG */
                    FLAG = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    If ((FLAG & 0x02))
                    {
                        Return (0x1F)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Return (0x0F)
            }

            Name (BIXP, Package (0x15)
            {
                One, 
                One, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                One, 
                0xFFFFFFFF, 
                Zero, 
                Zero, 
                0x64, 
                0x00017318, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0x0100, 
                0x40, 
                "BASE-BAT", 
                "123456789", 
                "LiP", 
                "Simplo", 
                One
            })
            Method (_BIX, 0, Serialized)  // _BIX: Battery Information Extended
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xF6, 0x06, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                Name (BUF1, Buffer (0x32){})
                Name (BUF2, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xF5, 0x06, 0x01, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                Name (BUF3, Buffer (0x18){})
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, 0x32) == Zero))
                {
                    CreateWordField (BUF1, 0x0A, CAPB)
                    CreateWordField (BUF1, 0x0C, DSNV)
                    CreateDWordField (BUF1, 0x2E, CYCC)
                    Local0 = CAPB /* \_SB_.BAT0._BIX.CAPB */
                    CAPB = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    Local0 = (CAPB / 0x0A)
                    BIXP [0x06] = Local0
                    Local0 = (CAPB / 0x19)
                    BIXP [0x07] = Local0
                    Local0 = DSNV /* \_SB_.BAT0._BIX.DSNV */
                    DSNV = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    Local0 = CYCC /* \_SB_.BAT0._BIX.CYCC */
                    CYCC = (((((Local0 & 0xFF) << 0x18) | (
                        (Local0 & 0xFF00) << 0x08)) | ((Local0 & 0x00FF0000) >> 0x08
                        )) | ((Local0 & 0xFF000000) >> 0x18))
                    BIXP [0x02] = CAPB /* \_SB_.BAT0._BIX.CAPB */
                    BIXP [0x05] = DSNV /* \_SB_.BAT0._BIX.DSNV */
                    BIXP [0x08] = CYCC /* \_SB_.BAT0._BIX.CYCC */
                    Mid (BUF1, 0x16, 0x08, BIXP [0x10])
                    Mid (BUF1, 0x1E, 0x08, BIXP [0x11])
                    Mid (BUF1, 0x26, 0x08, BIXP [0x12])
                    Mid (BUF1, 0x0E, 0x08, BIXP [0x13])
                }

                If ((\_SB.EC0.TRAS (BUF2, SizeOf (BUF2), BUF3, 0x18) == Zero))
                {
                    CreateWordField (BUF3, 0x10, FCAP)
                    Local0 = FCAP /* \_SB_.BAT0._BIX.FCAP */
                    FCAP = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    BIXP [0x03] = FCAP /* \_SB_.BAT0._BIX.FCAP */
                }

                Return (BIXP) /* \_SB_.BAT0.BIXP */
            }

            Name (BSTP, Package (0x04)
            {
                Zero, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0xFFFFFFFF
            })
            Method (_BST, 0, Serialized)  // _BST: Battery Status
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xF5, 0x06, 0x01, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                Name (BUF1, Buffer (0x18){})
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, 0x18) == Zero))
                {
                    CreateWordField (BUF1, 0x0A, ACUV)
                    CreateWordField (BUF1, 0x0C, ACUC)
                    CreateWordField (BUF1, 0x0E, REMC)
                    CreateWordField (BUF1, 0x12, FLAG)
                    Local0 = REMC /* \_SB_.BAT0._BST.REMC */
                    REMC = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    Local0 = ACUV /* \_SB_.BAT0._BST.ACUV */
                    ACUV = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    Local0 = FLAG /* \_SB_.BAT0._BST.FLAG */
                    FLAG = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    Local0 = ACUC /* \_SB_.BAT0._BST.ACUC */
                    ACUC = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    BSTP [One] = ACUC /* \_SB_.BAT0._BST.ACUC */
                    BSTP [0x02] = REMC /* \_SB_.BAT0._BST.REMC */
                    BSTP [0x03] = ACUV /* \_SB_.BAT0._BST.ACUV */
                    If ((FLAG & 0x08))
                    {
                        BSTP [Zero] = 0x02
                    }
                    ElseIf ((FLAG & 0x04))
                    {
                        BSTP [Zero] = One
                    }
                }

                Return (BSTP) /* \_SB_.BAT0.BSTP */
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                Name (BUF0, Buffer (0x09)
                {
                    /* 0000 */  0xDA, 0x03, 0x9F, 0x3E, 0x20, 0x00, 0x00, 0x00,  // ...> ...
                    /* 0008 */  0x00                                             // .
                })
                Name (BUF1, Buffer (0x0B){})
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, SizeOf (BUF1)) == Zero))
                {
                    CreateByteField (BUF1, 0x0A, LIDS)
                    If ((LIDS == One))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (One)
                    }
                }

                Return (One)
            }
        }

        Device (AC)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                \_SB
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                Name (BUF0, Buffer (0x0A)
                {
                    /* 0000 */  0xDA, 0x03, 0xF5, 0x06, 0x01, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x01, 0x00                                       // ..
                })
                Name (BUF1, Buffer (0x18){})
                If ((\_SB.EC0.TRAS (BUF0, SizeOf (BUF0), BUF1, 0x18) == Zero))
                {
                    CreateWordField (BUF1, 0x12, FLAG)
                    Local0 = FLAG /* \_SB_.AC__._PSR.FLAG */
                    FLAG = (((Local0 & 0xFF) << 0x08) | ((Local0 & 
                        0xFF00) >> 0x08))
                    If ((FLAG & One))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }
            }
        }

        Device (IKBD)
        {
            Name (_ADR, One)  // _ADR: Address
            Name (_HID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                {
                    If ((Arg2 == Zero))
                    {
                        If ((Arg1 == One))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                             // .
                            })
                        }
                        Else
                        {
                            Return (Buffer (One)
                            {
                                 0x00                                             // .
                            })
                        }
                    }

                    If ((Arg2 == One))
                    {
                        Return (One)
                    }
                }
                Else
                {
                    Return (Buffer (One)
                    {
                         0x00                                             // .
                    })
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x003A, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C5",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioIo (Shared, PullUp, 0x0000, 0x0000, IoRestrictionNone,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                    GpioInt (Level, ActiveLow, Shared, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0000
                        }
                })
                Return (RBUF) /* \_SB_.IKBD._CRS.RBUF */
            }
        }

        Scope (\_SB.SPI1)
        {
            Device (TP2)
            {
                Name (_HID, "SPT0002")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        SpiSerialBusV2 (0x0000, PolarityLow, FourWireMode, 0x08,
                            ControllerInitiated, 0x0007A120, ClockPolarityLow,
                            ClockPhaseFirst, "\\_SB.SPI1",
                            0x00, ResourceConsumer, , Exclusive,
                            )
                    })
                    Return (RBUF) /* \_SB_.SPI1.TP2_._CRS.RBUF */
                }
            }
        }

        Scope (\_SB.I2C1)
        {
            Device (PD10)
            {
                Name (_HID, "CIXH200D")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0030, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C1",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0008
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "id", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usbc_con2", 
                            "UC00"
                        }
                    }
                })
                Name (UC00, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "data-role", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "power-role", 
                            "source"
                        }, 

                        Package (0x02)
                        {
                            "try-power-role", 
                            "source"
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x03)
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
                        }, 

                        Package (0x02)
                        {
                            "port@2", 
                            "PRT2"
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
                                \_SB.SUB2.CUB2, 
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
                            "endpoint@0", 
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
                            Package (0x03)
                            {
                                \_SB.UCP2, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT2, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@1", 
                            "EP02"
                        }
                    }
                })
                Name (EP02, Package (0x02)
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
                                \_SB.UCP2, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }
                    }
                })
            }

            Device (PD11)
            {
                Name (_HID, "CIXH200D")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0031, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C1",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0008
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "id", 
                            0x03
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usbc_con3", 
                            "UC00"
                        }
                    }
                })
                Name (UC00, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "data-role", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "power-role", 
                            "source"
                        }, 

                        Package (0x02)
                        {
                            "try-power-role", 
                            "source"
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x03)
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
                        }, 

                        Package (0x02)
                        {
                            "port@2", 
                            "PRT2"
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
                                \_SB.SUB3.CUB3, 
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
                            "endpoint@0", 
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
                            Package (0x03)
                            {
                                \_SB.UCP3, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT2, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@1", 
                            "EP02"
                        }
                    }
                })
                Name (EP02, Package (0x02)
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
                                \_SB.UCP3, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }
                    }
                })
            }
        }

        Scope (\_SB.I2C7)
        {
            Device (PD00)
            {
                Name (_HID, "CIXH200D")  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0030, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C7",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0007
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "id", 
                            Zero
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usbc_con0", 
                            "UC00"
                        }
                    }
                })
                Name (UC00, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "data-role", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "power-role", 
                            "source"
                        }, 

                        Package (0x02)
                        {
                            "try-power-role", 
                            "source"
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x03)
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
                        }, 

                        Package (0x02)
                        {
                            "port@2", 
                            "PRT2"
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
                                \_SB.SUB0.CUB0, 
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
                            "endpoint@0", 
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
                            Package (0x03)
                            {
                                \_SB.UCP0, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT2, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@1", 
                            "EP02"
                        }
                    }
                })
                Name (EP02, Package (0x02)
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
                                \_SB.UCP0, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }
                    }
                })
            }

            Device (PD01)
            {
                Name (_HID, "CIXH200D")  // _HID: Hardware ID
                Name (_UID, 0x02)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    I2cSerialBusV2 (0x0031, ControllerInitiated, 0x000186A0,
                        AddressingMode7Bit, "\\_SB.I2C7",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                    GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                        "\\_SB.GPI4", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x0007
                        }
                })
                Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "id", 
                            One
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "usbc_con1", 
                            "UC00"
                        }
                    }
                })
                Name (UC00, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x03)
                    {
                        Package (0x02)
                        {
                            "data-role", 
                            "host"
                        }, 

                        Package (0x02)
                        {
                            "power-role", 
                            "source"
                        }, 

                        Package (0x02)
                        {
                            "try-power-role", 
                            "source"
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x03)
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
                        }, 

                        Package (0x02)
                        {
                            "port@2", 
                            "PRT2"
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
                                \_SB.SUB1.CUB1, 
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
                            "endpoint@0", 
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
                            Package (0x03)
                            {
                                \_SB.UCP1, 
                                "port@0", 
                                "endpoint@0"
                            }
                        }
                    }
                })
                Name (PRT2, Package (0x04)
                {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "reg", 
                            0x02
                        }
                    }, 

                    ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b") /* Hierarchical Data Extension */, 
                    Package (0x01)
                    {
                        Package (0x02)
                        {
                            "endpoint@1", 
                            "EP02"
                        }
                    }
                })
                Name (EP02, Package (0x02)
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
                                \_SB.UCP1, 
                                "port@0", 
                                "endpoint@1"
                            }
                        }
                    }
                })
            }
        }

        Device (WMIP)
        {
            Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, "CIX")  // _UID: Unique ID
            Method (UTOA, 2, Serialized)
            {
                Local0 = (Arg0 / 0x02)
                Local0++
                Name (BUF0, Buffer (Local0){})
                Local1 = Zero
                While ((Local1 < Arg0))
                {
                    Local2 = DerefOf (Arg1 [Local1])
                    BUF0 [(Local1 / 0x02)] = Local2
                    Local1 += 0x02
                }

                BUF0 [(Local1 / 0x02)] = Zero
                Return (BUF0) /* \_SB_.WMIP.UTOA.BUF0 */
            }

            Method (CI01, 1, NotSerialized)
            {
                UDBG (Debug = Concatenate ("CI01 ", Arg0))
                Return (Zero)
            }

            Method (CI02, 1, NotSerialized)
            {
                UDBG (Debug = Concatenate ("CI02 ", Arg0))
                Return (Zero)
            }

            Method (CIXL, 1, NotSerialized)
            {
                Local0 = DerefOf (Arg0 [Zero])
                Mid (Arg0, 0x02, Local0, Local1)
                Local2 = UTOA (Local0, Local1)
                UDBG (ToString (Local2, Ones))
                Return (Zero)
            }

            Name (_WDG, Buffer (0x28)
            {
                /* 0000 */  0x2A, 0x3D, 0x2B, 0x84, 0x1F, 0x1A, 0x71, 0x4D,  // *=+...qM
                /* 0008 */  0x98, 0x06, 0x74, 0x84, 0xF9, 0x09, 0x9B, 0xC0,  // ..t.....
                /* 0010 */  0x43, 0x49, 0x01, 0x02, 0x21, 0x12, 0x90, 0x05,  // CI..!...
                /* 0018 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f.......
                /* 0020 */  0xC9, 0x06, 0x29, 0x10, 0x4D, 0x4F, 0x01, 0x00   // ..).MO..
            })
            Method (WMCI, 3, NotSerialized)
            {
                CreateDWordField (Arg2, Zero, IIA0)
                If ((Arg0 == Zero))
                {
                    If ((Arg1 == One))
                    {
                        Return (CI01 (IIA0))
                    }
                    ElseIf ((Arg1 == 0x02))
                    {
                        Return (CI02 (IIA0))
                    }
                    ElseIf ((Arg1 == 0x8000))
                    {
                        Return (CIXL (Arg2))
                    }
                    Else
                    {
                        Return (One)
                    }
                }

                Return (One)
            }

            Name (WQMO, Buffer (0x02D4)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
                /* 0008 */  0xC4, 0x02, 0x00, 0x00, 0xD6, 0x0A, 0x00, 0x00,  // ........
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
                /* 0018 */  0xA8, 0x54, 0x85, 0x00, 0x01, 0x06, 0x18, 0x42,  // .T.....B
                /* 0020 */  0x20, 0xF4, 0x01, 0x89, 0xC0, 0xA1, 0x21, 0x14,  //  .....!.
                /* 0028 */  0x43, 0x01, 0x0C, 0x46, 0x02, 0x84, 0xE4, 0x40,  // C..F...@
                /* 0030 */  0xC8, 0x05, 0x13, 0x13, 0x20, 0x02, 0x42, 0x5E,  // .... .B^
                /* 0038 */  0x05, 0xD8, 0x14, 0x60, 0x12, 0x44, 0xFD, 0xFB,  // ...`.D..
                /* 0040 */  0x43, 0x94, 0x04, 0x87, 0x12, 0x02, 0x21, 0x89,  // C.....!.
                /* 0048 */  0x02, 0xCC, 0x0B, 0xD0, 0x2D, 0xC0, 0xB0, 0x00,  // ....-...
                /* 0050 */  0xDB, 0x02, 0x4C, 0x0B, 0x70, 0x0C, 0x49, 0xA5,  // ..L.p.I.
                /* 0058 */  0x81, 0x53, 0x02, 0x4B, 0x81, 0x90, 0x50, 0x01,  // .S.K..P.
                /* 0060 */  0xCA, 0x05, 0xF8, 0x16, 0xA0, 0x1D, 0x51, 0x92,  // ......Q.
                /* 0068 */  0x05, 0x58, 0x86, 0x11, 0x81, 0x47, 0x11, 0xD9,  // .X...G..
                /* 0070 */  0x68, 0x9C, 0xA0, 0x6C, 0x68, 0x94, 0x0C, 0x08,  // h..lh...
                /* 0078 */  0x79, 0x16, 0x60, 0x1D, 0x98, 0x10, 0xD8, 0xBD,  // y.`.....
                /* 0080 */  0x00, 0x71, 0xA3, 0x90, 0x32, 0x01, 0x8A, 0x05,  // .q..2...
                /* 0088 */  0x38, 0x43, 0x12, 0xC8, 0xB9, 0xB4, 0x25, 0xC0,  // 8C....%.
                /* 0090 */  0x18, 0x86, 0x20, 0x6A, 0x46, 0x11, 0x5A, 0xA8,  // .. jF.Z.
                /* 0098 */  0xDE, 0x60, 0x84, 0xD2, 0x1C, 0xA8, 0x84, 0x09,  // .`......
                /* 00A0 */  0xD0, 0x86, 0x22, 0xA0, 0x58, 0xA1, 0x0D, 0x18,  // ..".X...
                /* 00A8 */  0x2A, 0x52, 0x88, 0x08, 0xE1, 0xCF, 0x2B, 0x4A,  // *R....+J
                /* 00B0 */  0xFB, 0x83, 0x20, 0x91, 0x16, 0xAC, 0xA1, 0x3A,  // .. ....:
                /* 00B8 */  0xD2, 0x68, 0x50, 0xC3, 0x4B, 0x70, 0xB8, 0x1E,  // .hP.Kp..
                /* 00C0 */  0xEA, 0x39, 0x76, 0x2E, 0x40, 0xFA, 0x3C, 0x04,  // .9v.@.<.
                /* 00C8 */  0x12, 0xF9, 0xDC, 0xEA, 0x1C, 0x27, 0x01, 0x49,  // .....'.I
                /* 00D0 */  0x60, 0xAC, 0x04, 0x1D, 0x0C, 0x1C, 0x8A, 0x6B,  // `......k
                /* 00D8 */  0x40, 0xCD, 0xF8, 0x78, 0x99, 0x20, 0x38, 0xD4,  // @..x. 8.
                /* 00E0 */  0x10, 0x3D, 0xD0, 0x70, 0x27, 0x70, 0x88, 0x0C,  // .=.p'p..
                /* 00E8 */  0xD0, 0x23, 0x3A, 0x1A, 0xCC, 0x01, 0xC0, 0x0E,  // .#:.....
                /* 00F0 */  0x27, 0xA3, 0x7B, 0x40, 0xA9, 0x02, 0xCC, 0x8E,  // '.{@....
                /* 00F8 */  0x59, 0x16, 0x81, 0x34, 0x1E, 0x43, 0x9F, 0xEE,  // Y..4.C..
                /* 0100 */  0xF9, 0x9C, 0x70, 0x02, 0xCB, 0x1F, 0x04, 0x6A,  // ..p....j
                /* 0108 */  0x64, 0x86, 0xB6, 0xC1, 0x69, 0x09, 0x33, 0xE4,  // d...i.3.
                /* 0110 */  0xE1, 0x1F, 0x16, 0x13, 0x0B, 0xA1, 0x0F, 0x82,  // ........
                /* 0118 */  0xC7, 0x03, 0xEF, 0xFF, 0x3F, 0x1E, 0xF0, 0x8C,  // ....?...
                /* 0120 */  0xFC, 0x99, 0x20, 0xC2, 0x2B, 0x41, 0x6C, 0x0F,  // .. .+Al.
                /* 0128 */  0xE8, 0x11, 0x01, 0x0B, 0xEC, 0x01, 0xD9, 0xAF,  // ........
                /* 0130 */  0x00, 0x84, 0xE0, 0x65, 0x8E, 0x48, 0x4E, 0x11,  // ...e.HN.
                /* 0138 */  0x34, 0x02, 0x0F, 0xA9, 0xF8, 0x3B, 0x02, 0x25,  // 4....;.%
                /* 0140 */  0xB0, 0x48, 0x68, 0x94, 0x18, 0x68, 0xD4, 0x11,  // .Hh..h..
                /* 0148 */  0x20, 0xF2, 0xB1, 0x9C, 0x49, 0xE8, 0x63, 0x89,  //  ...I.c.
                /* 0150 */  0x12, 0xFB, 0x60, 0x7C, 0x5E, 0x30, 0xC2, 0x29,  // ..`|^0.)
                /* 0158 */  0x96, 0x7B, 0x6C, 0x20, 0x67, 0x83, 0xB3, 0x79,  // .{l g..y
                /* 0160 */  0x5A, 0x38, 0x9F, 0x37, 0x01, 0x13, 0xCC, 0xE3,  // Z8.7....
                /* 0168 */  0xE1, 0x2C, 0xC0, 0x52, 0x2C, 0x53, 0x36, 0x96,  // .,.R,S6.
                /* 0170 */  0xE9, 0x41, 0x50, 0x2D, 0x40, 0x1A, 0x0D, 0x6E,  // .AP-@..n
                /* 0178 */  0x7E, 0xD1, 0x8F, 0xDE, 0x04, 0xCE, 0x7F, 0x4C,  // ~......L
                /* 0180 */  0xD0, 0x39, 0xC3, 0x63, 0x76, 0x72, 0x12, 0x25,  // .9.cvr.%
                /* 0188 */  0x1F, 0x10, 0x85, 0x73, 0xD6, 0xE3, 0x06, 0x05,  // ...s....
                /* 0190 */  0x31, 0xA0, 0x83, 0x40, 0xC8, 0xC9, 0x31, 0x00,  // 1..@..1.
                /* 0198 */  0x75, 0xB4, 0x60, 0x13, 0x3A, 0xAA, 0x87, 0x05,  // u.`.:...
                /* 01A0 */  0x36, 0x89, 0x57, 0x0B, 0x26, 0xFA, 0xB4, 0x40,  // 6.W.&..@
                /* 01A8 */  0xC7, 0xE3, 0x73, 0x00, 0xD7, 0x00, 0xA1, 0x8B,  // ..s.....
                /* 01B0 */  0x81, 0xD1, 0xAD, 0x06, 0x90, 0x82, 0xF1, 0x4B,  // .......K
                /* 01B8 */  0xC0, 0x4B, 0x47, 0x02, 0xA6, 0xEB, 0x2E, 0x00,  // .KG.....
                /* 01C0 */  0xFD, 0xA0, 0xE1, 0x11, 0x1C, 0xCA, 0x53, 0xC6,  // ......S.
                /* 01C8 */  0x4B, 0xC6, 0x43, 0x89, 0xCE, 0x02, 0xA0, 0x00,  // K.C.....
                /* 01D0 */  0xF2, 0xFC, 0xAD, 0xF4, 0x0C, 0x40, 0xC7, 0x10,  // .....@..
                /* 01D8 */  0x22, 0x4C, 0x34, 0xA3, 0xF3, 0xF8, 0x93, 0x45,  // "L4....E
                /* 01E0 */  0x05, 0x9E, 0x2C, 0x05, 0xF9, 0xFF, 0x9F, 0x2C,  // ..,....,
                /* 01E8 */  0x0B, 0x33, 0x59, 0x28, 0x03, 0x38, 0xD2, 0x37,  // .3Y(.8.7
                /* 01F0 */  0x02, 0x43, 0x1C, 0x4A, 0x8C, 0x37, 0x02, 0x13,  // .C.J.7..
                /* 01F8 */  0x14, 0x7E, 0xD3, 0x80, 0x06, 0x78, 0x72, 0x8F,  // .~...xr.
                /* 0200 */  0x02, 0x9E, 0x87, 0xE1, 0x3C, 0x5B, 0x0E, 0xE7,  // ....<[..
                /* 0208 */  0xD9, 0xF2, 0xC1, 0xF8, 0x26, 0x01, 0x7F, 0xB8,  // ....&...
                /* 0210 */  0x58, 0x82, 0x02, 0xA7, 0x0B, 0x72, 0x78, 0x8C,  // X....rx.
                /* 0218 */  0xE0, 0xA1, 0x52, 0x59, 0xE3, 0x42, 0xDD, 0x0E,  // ..RY.B..
                /* 0220 */  0x7C, 0x74, 0x60, 0xD8, 0x4F, 0x09, 0xBE, 0x23,  // |t`.O..#
                /* 0228 */  0x9C, 0xA9, 0x07, 0xF5, 0xD4, 0xE1, 0xB1, 0x19,  // ........
                /* 0230 */  0xD6, 0x23, 0xE5, 0xB0, 0x06, 0x0D, 0x7B, 0xC0,  // .#....{.
                /* 0238 */  0x2F, 0x1C, 0x3E, 0x31, 0x78, 0x66, 0xC6, 0x08,  // /.>1xf..
                /* 0240 */  0xEB, 0xD1, 0xFA, 0x4A, 0x01, 0x9E, 0x2B, 0xCD,  // ...J..+.
                /* 0248 */  0x2B, 0x05, 0xE0, 0xE3, 0xFF, 0x7F, 0xA5, 0x00,  // +.......
                /* 0250 */  0xF8, 0x09, 0xCB, 0xAF, 0x14, 0xE0, 0x49, 0x70,  // ......Ip
                /* 0258 */  0xA5, 0x40, 0x0D, 0xCD, 0x3A, 0xAE, 0x14, 0x88,  // .@..:...
                /* 0260 */  0xA1, 0x9D, 0xC5, 0xE3, 0x13, 0xBB, 0x50, 0xE0,  // ......P.
                /* 0268 */  0xFE, 0xFF, 0x17, 0x0A, 0x70, 0x1C, 0xB9, 0x70,  // ....p..p
                /* 0270 */  0x17, 0x0A, 0x60, 0x7C, 0xDB, 0xC2, 0x5E, 0x28,  // ..`|..^(
                /* 0278 */  0x00, 0x3E, 0xFD, 0xFF, 0x2F, 0x14, 0x60, 0x10,  // .>../.`.
                /* 0280 */  0x10, 0xE0, 0x42, 0x01, 0x36, 0x85, 0x36, 0x7D,  // ..B.6.6}
                /* 0288 */  0x6A, 0x34, 0x6A, 0xD5, 0xA0, 0x4C, 0x8D, 0x32,  // j4j..L.2
                /* 0290 */  0x0D, 0x6A, 0xF5, 0xA9, 0xD4, 0x98, 0x31, 0x1D,  // .j....1.
                /* 0298 */  0x37, 0x48, 0x2F, 0x56, 0x63, 0xB1, 0x88, 0xE5,  // 7H/Vc...
                /* 02A0 */  0x08, 0xC4, 0x72, 0x29, 0x64, 0x04, 0x44, 0xDA,  // ..r)d.D.
                /* 02A8 */  0x41, 0x04, 0x64, 0xA5, 0x9F, 0x41, 0x01, 0x59,  // A.d..A.Y
                /* 02B0 */  0x37, 0x88, 0x80, 0x9C, 0xD9, 0x02, 0x10, 0xFB,  // 7.......
                /* 02B8 */  0x3A, 0x18, 0xC8, 0x71, 0x41, 0x04, 0xE4, 0xF0,  // :..qA...
                /* 02C0 */  0x40, 0x54, 0xF4, 0x1A, 0x05, 0xE4, 0x04, 0x20,  // @T..... 
                /* 02C8 */  0x02, 0xB2, 0x5E, 0x13, 0x40, 0x4C, 0x3D, 0x88,  // ..^.@L=.
                /* 02D0 */  0x80, 0xFC, 0xFF, 0x07                           // ....
            })
        }
    }
}

