#FROM registry.access.redhat.com/ubi9/python-39:1-117.1684741281
FROM registry.access.redhat.com/ubi9/python-311:1-72.1724040033

# Install any dependencies
#RUN pip install -r requirements.txt
#RUN \
#  if [ -f requirements.txt ]; \
#    then pip install -r requirements.txt; \
#  elif [ `ls -1q *.txt | wc -l` == 1 ]; \
#    then pip install -r *.txt; \
#  fi

# Set the working directory in the container
WORKDIR /projects

# Copy the content of the local src directory to the working directory
COPY . .

## Change directory to site/
#WORKDIR instant-django/

# Install any dependencies
#RUN python3 -m venv env
#RUN source env/bin/activate
#RUN pip install -r requirements.txt
RUN python manage.py migrate
RUN python manage.py createsuperuser

# By default, listen on port 8080
EXPOSE 8080/tcp

# Specify the command to run on container start
#CMD [ "python", "./app.py" ]
CMD [ "manage.py", "runserver" ]
