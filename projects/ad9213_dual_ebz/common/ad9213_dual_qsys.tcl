
set adc_data_width 1024
set adc_dma_data_width 1024

#
## IP instantiations and configuration
#

add_instance device_clk altera_clock_bridge 19.1
set_instance_parameter_value device_clk {EXPLICIT_CLOCK_RATE} {312500000}

# ad9213_rx_0 JESD204B phy-link layer

add_instance ad9213_rx_0 adi_jesd204
set_instance_parameter_value ad9213_rx_0 {ID} {0}
set_instance_parameter_value ad9213_rx_0 {TX_OR_RX_N} {0}
set_instance_parameter_value ad9213_rx_0 {SOFT_PCS} {true}
set_instance_parameter_value ad9213_rx_0 {LANE_RATE} {12500.0}
set_instance_parameter_value ad9213_rx_0 {SYSCLK_FREQUENCY} {100.0}
set_instance_parameter_value ad9213_rx_0 {REFCLK_FREQUENCY} {312.5}
set_instance_parameter_value ad9213_rx_0 {INPUT_PIPELINE_STAGES} {2}
set_instance_parameter_value ad9213_rx_0 {NUM_OF_LANES} {16}
set_instance_parameter_value ad9213_rx_0 {EXT_DEVICE_CLK_EN} {1}
set_instance_parameter_value ad9213_rx_0 {LANE_MAP} {0 1 2 7 14 13 15 4 8 3 10 6 12 5 9 11}

# ad9213_rx_1 JESD204B phy-link layer

add_instance ad9213_rx_1 adi_jesd204
set_instance_parameter_value ad9213_rx_1 {ID} {1}
set_instance_parameter_value ad9213_rx_1 {TX_OR_RX_N} {0}
set_instance_parameter_value ad9213_rx_1 {SOFT_PCS} {true}
set_instance_parameter_value ad9213_rx_1 {LANE_RATE} {12500.0}
set_instance_parameter_value ad9213_rx_1 {SYSCLK_FREQUENCY} {100.0}
set_instance_parameter_value ad9213_rx_1 {REFCLK_FREQUENCY} {312.5}
set_instance_parameter_value ad9213_rx_1 {INPUT_PIPELINE_STAGES} {2}
set_instance_parameter_value ad9213_rx_1 {NUM_OF_LANES} {16}
set_instance_parameter_value ad9213_rx_1 {EXT_DEVICE_CLK_EN} {1}
set_instance_parameter_value ad9213_rx_1 {LANE_MAP} {1 5 0 8 10 4 12 3 2 7 6 14 15 13 11 9}

# Link merger

add_instance ad9213_dual_link adi_jesd204_link_merge
set_instance_parameter_value ad9213_dual_link {NUM_OF_LANES_PER_LINK} {16}

# ad9213_tpl_0 JESD204B transport layer

add_instance axi_ad9213_dual ad_ip_jesd204_tpl_adc
set_instance_parameter_value axi_ad9213_dual {ID} {0}
set_instance_parameter_value axi_ad9213_dual {NUM_CHANNELS} {2}
set_instance_parameter_value axi_ad9213_dual {NUM_LANES} {32}
set_instance_parameter_value axi_ad9213_dual {BITS_PER_SAMPLE} {16}
set_instance_parameter_value axi_ad9213_dual {CONVERTER_RESOLUTION} {16}
set_instance_parameter_value axi_ad9213_dual {TWOS_COMPLEMENT} {1}
# NOTE: cpack is not used in this case, merge the output data streams
set_instance_parameter_value axi_ad9213_dual {COMMON_OUTPUT_IF} {1}

# DMA instances

add_instance axi_ad9213_dma axi_dmac
set_instance_parameter_value axi_ad9213_dma {ID} {0}
set_instance_parameter_value axi_ad9213_dma {DMA_DATA_WIDTH_SRC} {1024}
set_instance_parameter_value axi_ad9213_dma {DMA_DATA_WIDTH_DEST} {128}
set_instance_parameter_value axi_ad9213_dma {DMA_LENGTH_WIDTH} {24}
set_instance_parameter_value axi_ad9213_dma {DMA_2D_TRANSFER} {0}
set_instance_parameter_value axi_ad9213_dma {AXI_SLICE_DEST} {0}
set_instance_parameter_value axi_ad9213_dma {AXI_SLICE_SRC} {0}
set_instance_parameter_value axi_ad9213_dma {SYNC_TRANSFER_START} {0}
set_instance_parameter_value axi_ad9213_dma {CYCLIC} {0}
set_instance_parameter_value axi_ad9213_dma {DMA_TYPE_DEST} {0}
set_instance_parameter_value axi_ad9213_dma {DMA_TYPE_SRC} {2}
set_instance_parameter_value axi_ad9213_dma {FIFO_SIZE} {32}
set_instance_parameter_value axi_ad9213_dma {MAX_BYTES_PER_BURST} {256}

# SPI interfaces

add_instance adf4371_spi altera_avalon_spi
set_instance_parameter_value adf4371_spi {clockPhase} {0}
set_instance_parameter_value adf4371_spi {clockPolarity} {0}
set_instance_parameter_value adf4371_spi {dataWidth} {8}
set_instance_parameter_value adf4371_spi {masterSPI} {1}
set_instance_parameter_value adf4371_spi {numberOfSlaves} {2}
set_instance_parameter_value adf4371_spi {targetClockRate} {10000000.0}

add_instance ltc6952_spi altera_avalon_spi
set_instance_parameter_value ltc6952_spi {clockPhase} {0}
set_instance_parameter_value ltc6952_spi {clockPolarity} {0}
set_instance_parameter_value ltc6952_spi {dataWidth} {8}
set_instance_parameter_value ltc6952_spi {masterSPI} {1}
set_instance_parameter_value ltc6952_spi {numberOfSlaves} {2}
set_instance_parameter_value ltc6952_spi {targetClockRate} {10000000.0}

# ad9213x2 gpio

add_instance ad9213_dual_pio altera_avalon_pio
set_instance_parameter_value ad9213_dual_pio {direction} {Bidir}
set_instance_parameter_value ad9213_dual_pio {generateIRQ} {1}
set_instance_parameter_value ad9213_dual_pio {width} {10}
set_instance_parameter_value ad9213_dual_pio {edgeType} {RISING}

#
## clocks and resets
#

# system clock and reset

add_connection sys_clk.clk ad9213_rx_0.sys_clk
add_connection sys_clk.clk ad9213_rx_1.sys_clk
add_connection sys_clk.clk axi_ad9213_dual.s_axi_clock
add_connection sys_clk.clk axi_ad9213_dma.s_axi_clock
add_connection sys_clk.clk adf4371_spi.clk
add_connection sys_clk.clk ltc6952_spi.clk
add_connection sys_clk.clk ad9213_dual_pio.clk

add_connection sys_clk.clk_reset ad9213_rx_0.sys_resetn
add_connection sys_clk.clk_reset ad9213_rx_1.sys_resetn
add_connection sys_clk.clk_reset axi_ad9213_dual.s_axi_reset
add_connection sys_clk.clk_reset axi_ad9213_dma.s_axi_reset
add_connection sys_clk.clk_reset adf4371_spi.reset
add_connection sys_clk.clk_reset ltc6952_spi.reset
add_connection sys_clk.clk_reset ad9213_dual_pio.reset

# device clock and reset

add_connection device_clk.out_clk ad9213_rx_0.link_clk
add_connection device_clk.out_clk ad9213_rx_1.link_clk
add_connection device_clk.out_clk ad9213_dual_link.clk
add_connection device_clk.out_clk axi_ad9213_dual.link_clk
add_connection device_clk.out_clk axi_ad9213_dma.if_fifo_wr_clk

add_connection ad9213_rx_0.link_reset ad9213_dual_link.rst

# dma clock and reset

add_connection sys_dma_clk.clk axi_ad9213_dma.m_dest_axi_clock

add_connection sys_dma_clk.clk_reset axi_ad9213_dma.m_dest_axi_reset

#
## exported signals
#

add_interface rx_ref_clk_0            clock     sink
add_interface rx_ref_clk_1            clock     sink
add_interface rx_device_clk           clock     sink
add_interface rx_sysref_0             conduit   end
add_interface rx_sysref_1             conduit   end
add_interface rx_sync_0               conduit   end
add_interface rx_sync_1               conduit   end
add_interface ad9213_rx_0_serial_data conduit   end
add_interface ad9213_rx_1_serial_data conduit   end
add_interface ad9213_dual_pio         conduit   end
add_interface adf4371_spi             conduit   end
add_interface ltc6952_spi             conduit   end

set_interface_property rx_ref_clk_0            EXPORT_OF ad9213_rx_0.ref_clk
set_interface_property rx_ref_clk_1            EXPORT_OF ad9213_rx_1.ref_clk
set_interface_property rx_device_clk           EXPORT_OF device_clk.in_clk
set_interface_property rx_sysref_0             EXPORT_OF ad9213_rx_0.sysref
set_interface_property rx_sysref_1             EXPORT_OF ad9213_rx_1.sysref
set_interface_property rx_sync_0               EXPORT_OF ad9213_rx_0.sync
set_interface_property rx_sync_1               EXPORT_OF ad9213_rx_1.sync
set_interface_property ad9213_rx_0_serial_data EXPORT_OF ad9213_rx_0.serial_data
set_interface_property ad9213_rx_1_serial_data EXPORT_OF ad9213_rx_1.serial_data
set_interface_property ad9213_dual_pio         EXPORT_OF ad9213_dual_pio.external_connection
set_interface_property adf4371_spi             EXPORT_OF adf4371_spi.external
set_interface_property ltc6952_spi             EXPORT_OF ltc6952_spi.external

#
## data interfaces / data path
#

add_connection ad9213_rx_0.link_sof ad9213_dual_link.rx0_sof
add_connection ad9213_rx_1.link_sof ad9213_dual_link.rx1_sof
add_connection ad9213_rx_0.link_data ad9213_dual_link.rx0_data
add_connection ad9213_rx_1.link_data ad9213_dual_link.rx1_data
add_connection ad9213_dual_link.rx_sof axi_ad9213_dual.if_link_sof
add_connection ad9213_dual_link.rx_data axi_ad9213_dual.link_data

# TPL to DMA
add_connection axi_ad9213_dual.if_adc_valid axi_ad9213_dma.if_fifo_wr_en
add_connection axi_ad9213_dual.if_adc_data axi_ad9213_dma.if_fifo_wr_din
add_connection axi_ad9213_dual.if_adc_dovf axi_ad9213_dma.if_fifo_wr_overflow

# DMA to HPS memory
ad_dma_interconnect axi_ad9213_dma.m_dest_axi

#
## address Map
#

##
## NOTE: if bridge is used, the address will be bridge_base_addr + peripheral_base_addr
##

ad_cpu_interconnect 0x00000000 ad9213_rx_0.phy_reconfig_0    "avl_mm_bridge_0" 0x00040000
ad_cpu_interconnect 0x00002000 ad9213_rx_0.phy_reconfig_1    "avl_mm_bridge_0"
ad_cpu_interconnect 0x00004000 ad9213_rx_0.phy_reconfig_2    "avl_mm_bridge_0"
ad_cpu_interconnect 0x00006000 ad9213_rx_0.phy_reconfig_3    "avl_mm_bridge_0"
ad_cpu_interconnect 0x00008000 ad9213_rx_0.phy_reconfig_4    "avl_mm_bridge_0"
ad_cpu_interconnect 0x0000A000 ad9213_rx_0.phy_reconfig_5    "avl_mm_bridge_0"
ad_cpu_interconnect 0x0000C000 ad9213_rx_0.phy_reconfig_6    "avl_mm_bridge_0"
ad_cpu_interconnect 0x0000E000 ad9213_rx_0.phy_reconfig_7    "avl_mm_bridge_0"
ad_cpu_interconnect 0x00010000 ad9213_rx_0.phy_reconfig_8    "avl_mm_bridge_0"
ad_cpu_interconnect 0x00012000 ad9213_rx_0.phy_reconfig_9    "avl_mm_bridge_0"
ad_cpu_interconnect 0x00014000 ad9213_rx_0.phy_reconfig_10   "avl_mm_bridge_0"
ad_cpu_interconnect 0x00016000 ad9213_rx_0.phy_reconfig_11   "avl_mm_bridge_0"
ad_cpu_interconnect 0x00018000 ad9213_rx_0.phy_reconfig_12   "avl_mm_bridge_0"
ad_cpu_interconnect 0x0001A000 ad9213_rx_0.phy_reconfig_13   "avl_mm_bridge_0"
ad_cpu_interconnect 0x0001C000 ad9213_rx_0.phy_reconfig_14   "avl_mm_bridge_0"
ad_cpu_interconnect 0x0001E000 ad9213_rx_0.phy_reconfig_15   "avl_mm_bridge_0"

ad_cpu_interconnect 0x00000000 ad9213_rx_1.phy_reconfig_0    "avl_mm_bridge_1" 0x00080000
ad_cpu_interconnect 0x00002000 ad9213_rx_1.phy_reconfig_1    "avl_mm_bridge_1"
ad_cpu_interconnect 0x00004000 ad9213_rx_1.phy_reconfig_2    "avl_mm_bridge_1"
ad_cpu_interconnect 0x00006000 ad9213_rx_1.phy_reconfig_3    "avl_mm_bridge_1"
ad_cpu_interconnect 0x00008000 ad9213_rx_1.phy_reconfig_4    "avl_mm_bridge_1"
ad_cpu_interconnect 0x0000A000 ad9213_rx_1.phy_reconfig_5    "avl_mm_bridge_1"
ad_cpu_interconnect 0x0000C000 ad9213_rx_1.phy_reconfig_6    "avl_mm_bridge_1"
ad_cpu_interconnect 0x0000E000 ad9213_rx_1.phy_reconfig_7    "avl_mm_bridge_1"
ad_cpu_interconnect 0x00010000 ad9213_rx_1.phy_reconfig_8    "avl_mm_bridge_1"
ad_cpu_interconnect 0x00012000 ad9213_rx_1.phy_reconfig_9    "avl_mm_bridge_1"
ad_cpu_interconnect 0x00014000 ad9213_rx_1.phy_reconfig_10   "avl_mm_bridge_1"
ad_cpu_interconnect 0x00016000 ad9213_rx_1.phy_reconfig_11   "avl_mm_bridge_1"
ad_cpu_interconnect 0x00018000 ad9213_rx_1.phy_reconfig_12   "avl_mm_bridge_1"
ad_cpu_interconnect 0x0001A000 ad9213_rx_1.phy_reconfig_13   "avl_mm_bridge_1"
ad_cpu_interconnect 0x0001C000 ad9213_rx_1.phy_reconfig_14   "avl_mm_bridge_1"
ad_cpu_interconnect 0x0001E000 ad9213_rx_1.phy_reconfig_15   "avl_mm_bridge_1"

ad_cpu_interconnect 0x000C0000 ad9213_rx_0.link_reconfig
ad_cpu_interconnect 0x000C4000 ad9213_rx_0.link_management
ad_cpu_interconnect 0x000C8000 ad9213_rx_1.link_reconfig
ad_cpu_interconnect 0x000CC000 ad9213_rx_1.link_management
ad_cpu_interconnect 0x000D0000 axi_ad9213_dual.s_axi
ad_cpu_interconnect 0x000D2000 axi_ad9213_dma.s_axi

ad_cpu_interconnect 0x00000200 ltc6952_spi.spi_control_port "avl_peripheral_mm_bridge"
ad_cpu_interconnect 0x00000400 adf4371_spi.spi_control_port "avl_peripheral_mm_bridge"
ad_cpu_interconnect 0x00000800 ad9213_dual_pio.s1 "avl_peripheral_mm_bridge"

#
## interrupts
#

ad_cpu_interrupt 11 ad9213_rx_0.interrupt
ad_cpu_interrupt 12 ad9213_rx_1.interrupt
ad_cpu_interrupt 13 axi_ad9213_dma.interrupt_sender
ad_cpu_interrupt 15 ad9213_dual_pio.irq
ad_cpu_interrupt 16 adf4371_spi.irq
ad_cpu_interrupt 17 ltc6952_spi.irq

