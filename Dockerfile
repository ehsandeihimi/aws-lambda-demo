# AWS provided base image that includes LAMBDA_TASK_ROOT
FROM public.ecr.aws/lambda/python:3.8

# Copy function code. LAMBDA_TASK_ROOT is where all our code that we want to run in the lambda function will be 
COPY app.py ${LAMBDA_TASK_ROOT}

# Avoid cache purge by adding requirements first
COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN pip install --no-cache-dir -r requirements.txt

## ARG: Variables available during build time
# Our .env variables
ARG WEATHER_API_KEY
ARG EMAIL_USER
ARG EMAIL_PASSWORD

# AWS IAM identity and access management variables
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION

## ENV: variables available during run-time, and assigned by ARG variables avaiable in the image
ENV WEATHER_API_KEY $WEATHER_API_KEY
ENV EMAIL_USER $EMAIL_USER
ENV EMAIL_PASSWORD $EMAIL_PASSWORD
ENV AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION $AWS_DEFAULT_REGION

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]
