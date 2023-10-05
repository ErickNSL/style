# Use an official Python runtime based on Alpine Linux
FROM python:3.11.5-alpine3.18



RUN apk update \
    && pip install --upgrade pip
 
# Set environment variables for Python
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Create and set the working directory
RUN mkdir /app
WORKDIR /app

# Install any system dependencies (if needed)

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app/
COPY . /app/

#ENVIROMENT VARIABLES


# Expose port 8000
EXPOSE 8000

# Collect static files
RUN python manage.py collectstatic --noinput

# Run Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "style.wsgi"]
