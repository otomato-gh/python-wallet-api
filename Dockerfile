FROM python:3.8-slim-buster

RUN useradd --create-home appuser
RUN mkdir /home/appuser/.pip && chown -R appuser /home/appuser
COPY --chown=appuser:appuser pip.conf /home/appuser/.pip/pip.conf

WORKDIR /home/appuser

USER appuser

COPY --chown=appuser:appuser requirements.txt requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install myWallet==0.2 --user
RUN rm /home/appuser/.pip/pip.conf
RUN pip install --user -r requirements.txt
RUN rm /home/appuser/requirements.txt
ENV PATH="/home/appuser/.local/bin:${PATH}"
COPY api.py /home/appuser/

CMD [ "python", "./api.py" ]

