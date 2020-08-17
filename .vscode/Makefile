#mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))
current_dir = $(CURDIR)

# Default names for input and output files
VERILOG:=${current_dir}/design.sv
TOP:=basys3

# include a local makefile to override default names
-include ${current_dir}/Makefile

# default name for pcf file (pin connections)
ifndef PCF
PCF:=${current_dir}/${TOP}.pcf
endif

# default name for sdc file (clock info)
ifndef SDC
# does an sdc file exist? Only define SDC if so
ifneq ("$(wildcard ${TOP}.sdc)", "") 
SDC:=${TOP}.sdc
endif
endif

DEVICE  := xc7a50t_test
BITSTREAM_DEVICE := artix7
PARTNAME:= xc7a35tcpg236-1
BUILDDIR:=build

# should we include an SDC file?
ifdef SDC
SDC_OPTS:= -s ${SDC}
else
SDC_OPTS:=
SDC:=
endif

all: ${TOP}.bit

${BUILDDIR}:
	mkdir ${BUILDDIR}

${BUILDDIR}/${TOP}.eblif: | ${BUILDDIR} ${VERILOG}
	cd ${BUILDDIR} && synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME}

${BUILDDIR}/${TOP}.net: ${BUILDDIR}/${TOP}.eblif ${SDC}
	cd ${BUILDDIR} && pack -e ${TOP}.eblif -d ${DEVICE} ${SDC_OPTS}

${BUILDDIR}/${TOP}.route: ${BUILDDIR}/${TOP}.net ${PCF} ${SDC}
	cd ${BUILDDIR} && place_n_route -e ${TOP}.eblif -d ${DEVICE} -p ${PCF} -n ${TOP}.net -P ${PARTNAME} ${SDC_OPTS}

${BUILDDIR}/${TOP}.fasm: ${BUILDDIR}/${TOP}.route
	cd ${BUILDDIR} && write_fasm -e ${TOP}.eblif -d ${DEVICE}
	cd ${BUILDDIR} && mv -n *.fasm ${TOP}.fasm

${BUILDDIR}/${TOP}.bit: ${BUILDDIR}/${TOP}.fasm
	cd ${BUILDDIR} && write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

${TOP}.bit: ${BUILDDIR}/${TOP}.bit
	cp ${BUILDDIR}/${TOP}.bit ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}
	rm -f *.bit

