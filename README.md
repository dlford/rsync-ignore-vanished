# rsync-ignore-vanished

A simple Docker image built from Alpine for copying files to be backed up.

## Why

Using rsync in pre-archive hooks with `docker-volume-backup` for example can fail due to `some files vanished before they could be transferred` error, causing the backup to not be uploaded because rsync returns code `24` instead of `0`.

## How

This image simply wraps rsync in a bash script `rsync-iv` that will return code `0` if rsync returns `24`, or return the same code that rsync returns. This way we can ignore the one error, but other errors will still cause a failure.

```sh
#!/bin/sh
rsync "$@"
e=$?
if [ $e -eq 24 ]; then
    exit 0
fi
exit $e
```

## Usage

```sh
docker run -v my_volume:/data:ro -v ~/backup:/bu ghcr.io/dlford/rsync-iv:latest rsync-iv /data/ /bu/
```
