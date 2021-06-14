#For Production purpose
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm config set registry http://registry.npmjs.org/
RUN npm set strict-ssl false
RUN npm install

COPY . .
RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html

#using volumes
#winpty docker run -it -p 3000:3000 -v /app/node_modules -v "/$(PWD)":/app bffe91d94dfd