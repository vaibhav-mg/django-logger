# Use an official Python runtime as the base image
FROM python:3.8

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev

# Install dependencies
COPY requirements.txt .
# RUN pip3 install --no-cache-dir -r requirements.txt

# RUN pip install --upgrade pip
# RUN pip --version
# RUN pip install -r requirements.txt

RUN pip install --upgrade pip 
RUN pip install -r requirements.txt
RUN uwsgi --version

# Copy the project code into the container
COPY . /app/


# Expose the port on which the Django app will run
EXPOSE 8080

COPY uwsgi.ini /app/

# Set the entrypoint command to start the Django development server
# CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
CMD [ "uwsgi","--ini","uwsgi.ini" ]

