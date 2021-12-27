FROM node:12

WORKDIR /app

RUN npm install -g nodemon

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install


COPY . .

EXPOSE 3000

CMD ["nodemon","index.js"]