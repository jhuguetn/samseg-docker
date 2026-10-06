# SAMSEG Docker image

[![GitHub release](https://img.shields.io/github/v/release/jhuguetn/samseg-docker?logo=github)](https://github.com/jhuguetn/samseg-docker/releases)
[![DockerHub pulls](https://img.shields.io/docker/pulls/jhuguetn/samseg?logo=docker)](https://hub.docker.com/r/jhuguetn/samseg/tags)

Lightweight Docker image for reproducible **FreeSurfer SAMSEG** execution.

- FreeSurfer SAMSEG: https://surfer.nmr.mgh.harvard.edu/fswiki/Samseg

Find the image in Docker Hub [here](https://hub.docker.com/r/jhuguetn/samseg).

## Components

* Ubuntu 20.04
* FreeSurfer 7.4.1
* SAMSEG  (bundled with the official FreeSurfer 7.4.1 image) 

The image is derived from the official `freesurfer/freesurfer:7.4.1` Docker image 
while excluding unrelated FreeSurfer components.

## Usage

```bash
docker run --rm -it jhuguetn/samseg:7.4.1 --help
```

Example T1w segmentation:

```bash
mkdir -p ./data/out

docker run --rm -it \
  -v $(pwd)/data:/data \
  jhuguetn/samseg:7.4.1 \
  --input /data/T1w.nii.gz \
  --output /data/out \
  --threads 4
```

## License

FreeSurfer, SAMSEG and associated resources included in the resulting image remain 
governed by their respective upstream license terms.

## Notes

* Derived from [FreeSurfer 7.4.1](https://hub.docker.com/layers/freesurfer/freesurfer/7.4.1/images/sha256-10b6468cbd9fcd2db3708f4651d59ad75d4da849a2c5d8bb6dba217f08b8c46b)
* Intended for reproducible research workflows and as a base image for workflow-specific containers

## Credits

Jordi Huguet ([BarcelonaBeta Brain Research Center](http://barcelonabeta.org))
