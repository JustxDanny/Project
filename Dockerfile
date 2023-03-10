FROM python:3.9-slim-buster

# Add jenkins user to the docker group
RUN groupadd -g 999 docker && useradd -r -u 999 -g docker jenkins && echo "jenkins:jenkins" | chpasswd && usermod -aG docker jenkins

WORKDIR /app

# Copy app.py and requirements.txt to working directory
COPY app.py .
COPY requirements.txt .

# Install Flask and other required packages
RUN pip install -r requirements.txt

# Install pytest
RUN pip install pytest
# install Npm
RUN apt-get update && \
    apt-get install -y npm

# Expose port 80 for Flask app
EXPOSE 80

# Set the user to jenkins
USER jenkins

# Start the Flask app with prompt for name input
CMD ["python", "app.py"]
