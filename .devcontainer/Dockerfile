# Symbiflow FPGA tools for basys3 FPGA
#
# Based on install instructions from github.com/antmicro/symbiflow-examples

# we need conda for the tools
FROM continuumio/miniconda3

LABEL maintainer="bakerjm@vmi.edu"
LABEL version="0.1"
LABEL description="For EE 228 at Virginia Military Institute"

# install symbiflow tools to /opt
# These instructions were adapted from https://symbiflow-examples.readthedocs.io/en/latest/getting-symbiflow.html
#  See that URL for updated names of the .tar.xz files as needed
ENV INSTALL_DIR="/opt"
RUN wget --no-verbose https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/367/20210822-000315/symbiflow-arch-defs-install-709cac78.tar.xz
RUN tar -x -v --xz --directory /opt --file symbiflow-arch-defs-install-709cac78.tar.xz
RUN rm -f symbiflow-arch-defs-install-709cac78.tar.xz

RUN wget --no-verbose https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/367/20210822-000315/symbiflow-arch-defs-xc7a50t_test-709cac78.tar.xz
RUN tar -x -v --xz --directory /opt --file symbiflow-arch-defs-xc7a50t_test-709cac78.tar.xz
RUN rm -f symbiflow-arch-defs-xc7a50t_test-709cac78.tar.xz

#RUN wget --no-verbose https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/367/20210822-000315/symbiflow-arch-defs-xc7z010_test-709cac78.tar.xz
#RUN tar -x -v --xz --directory /opt --file symbiflow-arch-defs-xc7z010_test-709cac78.tar.xz
#RUN rm -f symbiflow-arch-defs-xc7z010_test-709cac78.tar.xz



# copy our own scripts for pack and place-and-route
COPY symbiflow_pack /opt/bin/symbiflow_pack
COPY symbiflow_place_n_route /opt/bin/symbiflow_place_n_route

# update PATH to include symbiflow tools
ENV PATH="/opt/bin:${PATH}"

# create a dir for user files
RUN ["mkdir", "-p", "/workspace"]

# copy list of requirements for symbiflow's conda environment
COPY requirements.txt .
COPY environment.yml .

# update conda itself
RUN conda update -n base conda

# update the environments
#RUN conda env update --name base --prune
RUN conda env update --name xc7 --file environment.yml --prune

# activate the xc7 environment in each shel
RUN echo "source activate xc7" > ~/.bashrc

# set working directory
WORKDIR /workspace

#CMD tail -f /dev/null
CMD /bin/sh -c "while sleep 1000; do :; done"