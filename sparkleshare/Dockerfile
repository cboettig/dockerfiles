FROM ubuntu

ENV PROJECT_NAME sparkle

# Fetch the Dazzle script
RUN curl https://raw.githubusercontent.com/hbons/Dazzle/master/dazzle.sh --output /usr/bin/dazzle && chmod +x /usr/bin/dazzle

# Run the initial setup
RUN dazzle setup

# Link SparkleShare clients using their Client ID found in the status menu
RUN dazzle link

# Create a new project. Add as many as you need
RUN dazzle create $PROJECT_NAME

# Alternatively, create a new encrypted project
# RUN dazzle create-encrypted PROJECT_NAME
