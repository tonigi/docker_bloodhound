FROM ubuntu:14.04
RUN apt-get update && apt-get install -y  python python-virtualenv
RUN useradd --system -m bloodhound
RUN mkdir -p /opt/bloodhound && chown bloodhound:bloodhound /opt/bloodhound
RUN wget -O- http://www.carfab.com/apachesoftware/bloodhound/apache-bloodhound-0.8.tar.gz | tar -xvzf-
RUN { \
  cd apache-bloodhound-0.8/installer; \
  su - bloodhound; \
  virtualenv /opt/bloodhound/bhenv; \
  source /opt/bloodhound/bhenv/bin/activate; \
  pip install -r requirements.txt; \
  python bloodhound_setup.py --environments_directory=/opt/bloodhound/environments --default-product-prefix=DEF; \
  }
EXPOSE 8080
CMD tracd --port=8080 /opt/bloodhound/environments/main
