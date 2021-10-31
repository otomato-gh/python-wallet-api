FROM python:3.8-slim-buster AS intermediate
ARG PYPI_INDEX_URL
ENV URL=${PYPI_INDEX_URL}
# comes as an argument for 'docker build --build-arg ... ' 
RUN python -m pip install --upgrade pip
RUN mkdir /root/.pip && touch /root/.pip/pip.conf && \
    printf "[global]\nindex-url = ${URL}\n" > /root/.pip/pip.conf && \
    cat /root/.pip/pip.conf
RUN pip install myWallet==0.2

FROM python:3.8-slim-buster
RUN useradd --create-home appuser
RUN chown -R appuser /home/appuser
# path where pip looks for packages is '/usr/local/lib/python3.8/site-packages'
COPY --from=intermediate /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages 
WORKDIR /home/appuser
USER appuser
COPY --chown=appuser:appuser requirements.txt requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install myWallet==0.2
RUN pip install --user -r requirements.txt
RUN rm /home/appuser/requirements.txt
ENV PATH="/home/appuser/.local/bin:${PATH}"
COPY api.py /home/appuser/

EXPOSE 5000

CMD [ "python", "./api.py" ]

