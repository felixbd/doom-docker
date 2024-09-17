# doom-docker

my configured doom (gnu/emacs) in docker

> Note:
> This container, which contains my doom emacs configuration, can be used to create pdf,
> adcii and html documentation and presentations from `.org` files. This is the primary
> use case, of course the preconfigured doom gnu/emacs editor can also be used to edit
> files (but for that the locale installation would be the better choice).
>
> see: 
>
> `#!/usr/bin/env doomscript` https://github.com/doomemacs/doomemacs/issues/6494
>
> - https://github.com/felixbd/org-presi
> - https://github.com/felixbd/thesis-template-in-org-mode

## pull

```sh=
docker pull ghcr.io/felixbd/doom-docker:master
```

## run

```sh=
sudo docker run --rm -it -u $(id -u):$(id -g) \
    -v "`pwd`":/app --workdir /app \
    ghcr.io/felixbd/doom-docker:master
```

> TODO:
> To provide a description, add the following line to your Dockerfile:
> `LABEL org.opencontainers.image.description DESCRIPTION`

</br>
</br>

### for the local build of the docker container

```sh
# pip3 install pre-commit
# pre-commit install

make db
make dr
emacs
# or use `doom run`
```
