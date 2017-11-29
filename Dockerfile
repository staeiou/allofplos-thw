FROM jupyter/datascience-notebook:latest

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# R packages
RUN conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.12*' \
    'r-tidyverse=1.0*' \
    'r-shiny=0.14*' \
    'r-rmarkdown=1.2*' \
    'r-forecast=7.3*' \
    'r-rsqlite=1.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

USER $NB_USER

RUN pip install --no-cache-dir bash_kernel seaborn jupyterhub==0.7.2 \
    lxml==4.1.1 unidecode==0.04.21 && \
    python -m bash_kernel.install --sys-prefix



# add files to home directory and rename/reown
USER root

RUN apt-get update && apt-get install -y curl tmux screen nano traceroute asciinema hollywood libmagic-dev

RUN git clone https://github.com/PLOS/allofplos && git remote add eseiver eseiver && git fetch eseiver && git checkout class_cleanup 

RUN pip install -e allofplos/ && python -c  "from allofplos.plos_corpus import create_test_plos_corpus; create_test_plos_corpus()"

ADD smoke_test.py .


