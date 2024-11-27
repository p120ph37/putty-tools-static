Static build of PuTTY-tools

Images on Dockerhub are available for `linux/amd64` and `linux/arm64`

You can run the tools like this:
```
docker run --rm -ti ameriwether/putty-tools-static /plink user@server
```

Or if you need to work with local files, like this:
```
docker run --rm -ti -v$PWD:$PWD -w$PWD ameriwether/putty-tools-static /pscp test.txt user@server:testdir/
```

You can include these binaries in your own Dockerfile like this:
```
COPY --from=ameriwether/putty-tools-static /* /usr/bin/
```

These are the files available:
- `pageant`
- `plink`
- `pscp`
- `psftp`
- `psusan`
- `puttygen`
