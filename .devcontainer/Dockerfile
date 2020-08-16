# Symbiflow FPGA tools for basys3 FPGA
#
# Based on install instructions from github.com/antmicro/symbiflow-examples

# we need conda for the tools
FROM continuumio/miniconda3

LABEL maintainer="bakerjm@vmi.edu"
LABEL version="0.1"
LABEL description="For EE 228 at Virginia Military Institute"

# install symbiflow tools to /opt
ENV INSTALL_DIR="/opt"
RUN wget --no-verbose https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/4/20200416-002215/symbiflow-arch-defs-install-a321d9d9.tar.xz
RUN tar -x -v --xz --directory /opt --file symbiflow-arch-defs-install-a321d9d9.tar.xz
RUN rm -f symbiflow-arch-defs-install-a321d9d9.tar.xz

# copy our own scripts for pack and place-and-route
COPY pack /opt/install/bin/pack
COPY place_n_route /opt/install/bin/place_n_route

# update PATH to include symbiflow tools
ENV PATH="/opt/install/bin:${PATH}"

# create a dir for user files
RUN ["mkdir", "-p", "/workspace"]

# install symbiflow tools in conda environment
COPY environment.yml .
RUN conda update -n base conda
RUN conda env update --name base -f environment.yml

# set working directory
WORKDIR /workspace

#CMD tail -f /dev/null
CMD /bin/sh -c "while sleep 1000; do :; done"