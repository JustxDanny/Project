FROM python:3.9-slim-buster

WORKDIR /app

# Copy app.py to working directory
COPY app.py .

# Install Flask
RUN pip install flask

# Expose port 80 for Flask app
EXPOSE 80

# Start the Flask app with prompt for name input
CMD ["sh", "-c", "echo 'Enter your name: ' && read name && export NAME=$name && python app.py"]

