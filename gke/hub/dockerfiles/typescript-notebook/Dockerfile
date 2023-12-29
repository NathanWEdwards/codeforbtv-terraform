FROM quay.io/jupyter/minimal-notebook

USER root

RUN sudo apt update -y && sudo apt upgrade -y

RUN pip install ipykernel --upgrade

RUN npm install -g tslab

RUN tslab install

USER ${NB_UID}
