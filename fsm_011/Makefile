mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

# Change these to match your module name and file name(s)
TOP:=top
VERILOG:=${current_dir}/design.sv

PCF:=${current_dir}/${TOP}.pcf
SDC:=${current_dir}/${TOP}.sdc

DEVICE  := xc7a50t_test
BITSTREAM_DEVICE := artix7
PARTNAME:= xc7a35tcpg236-1
BUILDDIR:=build

all: ${TOP}.bit

${BUILDDIR}:
	mkdir ${BUILDDIR}

${BUILDDIR}/${TOP}.eblif: ${VERILOG} | ${BUILDDIR}
	cd ${BUILDDIR} && synth -t ${TOP} -v ${VERILOG} -d ${BITSTREAM_DEVICE} -p ${PARTNAME}

${BUILDDIR}/${TOP}.net: ${BUILDDIR}/${TOP}.eblif
	cd ${BUILDDIR} && pack -e ${TOP}.eblif -d ${DEVICE} -s ${SDC}

${BUILDDIR}/${TOP}.route: ${BUILDDIR}/${TOP}.net
	cd ${BUILDDIR} && place_n_route -e ${TOP}.eblif -d ${DEVICE} -p ${PCF} -n ${TOP}.net -P ${PARTNAME} -s ${SDC}

${BUILDDIR}/${TOP}.fasm: ${BUILDDIR}/${TOP}.route
	cd ${BUILDDIR} && write_fasm -e ${TOP}.eblif -d ${DEVICE}

${BUILDDIR}/${TOP}.bit: ${BUILDDIR}/${TOP}.fasm
	cd ${BUILDDIR} && write_bitstream -d ${BITSTREAM_DEVICE} -f ${TOP}.fasm -p ${PARTNAME} -b ${TOP}.bit

${TOP}.bit: ${BUILDDIR}/${TOP}.bit
	cp ${BUILDDIR}/${TOP}.bit ${TOP}.bit

clean:
	rm -rf ${BUILDDIR}
	rm -f ${TOP}.bit

