FROM node:18-alpine AS build
LABEL maintainer="Stille <stille@ioiox.com>"

ENV VERSION=2.0

WORKDIR /app
RUN corepack enable && corepack prepare pnpm@8.15.9 --activate
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . /app
RUN pnpm dlx update-browserslist-db@latest latest
RUN pnpm run build

FROM nginx:1.27-alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY . /app
EXPOSE 80
CMD ["sh", "-c", "/app/start.sh"]
