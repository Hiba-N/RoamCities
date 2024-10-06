#Each layer in the image is stored as a SHA-256 has
# Layers are immutable (read-only) 

# The base layer is the first layer
FROM node:18-alpine 

# Set the equivalent docker working directory
WORKDIR /frontend

#copies all files that begin with the string package and end with the string .json
COPY package*.json ./

# Install dependencies, which is why we didnt need to manually copy over node_modules
RUN npm install

#COPY <source_path> <destination_path>
#keep source path relative to where you run docker build
COPY public/ /frontend/public
COPY src/ /frontend/src

#This instruction defines the command that will be executed when starting a container from the image.
#There can only be one CMD instruction in the Dockerfile. 
#If there are more than one, then only the last one will be considered.
CMD ["npm", "start"]


#command to build image: docker image build -t roamcities-frontend:latest frontend


# A note on the copy command
# One-time action: The COPY command copies files from your local machine into the image at the time of image building.
# Once the image is built, the container has its own copy of these files.
# Any changes you make to your local files after the image is built will not be reflected in the running container
# unless you rebuild the image.


#changes in the dockerfile require rebuilding of the image