FROM node:20-alpine as builder
# Creacion de directorio de trabajo
RUN echo "Creación del directorio de trabajo"
WORKDIR /home/node/app
# Copia el codigo
RUN echo "Copia el codigo"
COPY . .
# npm i o npm install Ejecutar la instalación de los módulos
RUN echo "Instalación de los módulos"
RUN npm ci
RUN npm run build

FROM nginx:1.24-alpine as server
EXPOSE 80
COPY --from=builder /home/node/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

