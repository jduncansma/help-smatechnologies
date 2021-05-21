FROM node:14-alpine as builder
COPY . /builder/
WORKDIR /builder/
RUN yarn install
RUN yarn build
RUN echo -e "{\n  \"date\": \"`/bin/date -Is`\"\n}" > build/build.json

FROM nginx:alpine
COPY --from=builder /builder/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /builder/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

 