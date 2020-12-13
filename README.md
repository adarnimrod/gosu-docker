# Dockerized gosu

> Alpine Docker image with gosu installed.

## Usage

The image is based on the latest Alpine image with just `gosu` installed. If you
wish to use a different image as a base then you can just copy the binary from
this image so:

```
FROM adarnimrod/gosu as gosu

FROM alpine:latest
COPY --from=gosu /usr/local/bin/gosu /usr/local/bin/
```

## License

This software is licensed under the MIT license (see `LICENSE.txt`).

## Author Information

Nimrod Adar, [contact me](mailto:nimrod@shore.co.il) or visit my [website](
https://www.shore.co.il/). Patches are welcome via [`git send-email`](
http://git-scm.com/book/en/v2/Git-Commands-Email). The repository is located
at: <https://git.shore.co.il/explore/>.
