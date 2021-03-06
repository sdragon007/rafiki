FROM python:3.6

# Install PostgreSQL client
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib

RUN mkdir /root/rafiki/
WORKDIR /root/rafiki/

# Install python dependencies
COPY rafiki/utils/requirements.txt utils/requirements.txt
RUN pip install -r utils/requirements.txt
COPY rafiki/db/requirements.txt db/requirements.txt
RUN pip install -r db/requirements.txt
COPY rafiki/container/requirements.txt container/requirements.txt
RUN pip install -r container/requirements.txt
COPY rafiki/admin/requirements.txt admin/requirements.txt
RUN pip install -r admin/requirements.txt

COPY rafiki/ rafiki/

# Copy init script
COPY scripts/start_admin.py start_admin.py

ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH /root/rafiki/

EXPOSE 8000

CMD ["python", "start_admin.py"]