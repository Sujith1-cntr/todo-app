Stage 1: Build Stage

We use a Node base image only to perform the file copy and rename operations.

FROM node:20-alpine as builder

Set the working directory

WORKDIR /app

Copy the static assets from your project's 'src' folder

COPY src /app/src/

Rename the HTML file to index.html, which is the default entry point for Nginx

RUN mv /app/src/todo_app.html /app/src/index.html

---

Stage 2: Production Stage

Use a very small Nginx base image to keep the final image size minimal

FROM nginx:alpine

Copy the custom Nginx configuration file (nginx.conf must be created separately)

COPY nginx.conf /etc/nginx/conf.d/default.conf

Copy the finalized static content (the renamed index.html)

from the builder stage into the Nginx server directory

COPY --from=builder /app/src /usr/share/nginx/html

The default command runs Nginx

CMD ["nginx", "-g", "daemon off;"]