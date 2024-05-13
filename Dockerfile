FROM jupyter/base-notebook
RUN pip install mysql-connector-python
COPY . /home/jovyan/work/
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

