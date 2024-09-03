FROM registry.access.redhat.com/ubi8/python-36
#FROM registry.access.redhat.com/ubi9/python-311:1-72.1724040033

# Set the working directory in the container
WORKDIR /app-src

# Copy the content of the local src directory to the working directory
COPY . .

# Add application sources with correct permissions for OpenShift
USER 0
#COPY . .
RUN chown -R 1001:0 ./
USER 1001

# Install the dependencies
#RUN pip install -U "pip>=19.3.1" && \
#    pip install -r requirements.txt && \
#    python manage.py collectstatic --noinput && \
#    python manage.py migrate

#RUN python3 -m venv env &&\
#    source env/bin/activate &&\
RUN pip install -r requirements.txt &&\
    python manage.py migrate &&\
    chmod 777 db.sqlite3 &&\
    python manage.py custom_createsuperuser --username admin --email admin@example.com --password admin
#    python manage.py createsuperuser
#    python manage.py custom_createsuperuser --username admin --email admin@example.com --password admin

# Run the application
CMD python manage.py runserver 0.0.0.0:8080
