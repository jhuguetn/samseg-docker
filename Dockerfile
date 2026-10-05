FROM freesurfer/freesurfer:7.4.1@sha256:10b6468cbd9fcd2db3708f4651d59ad75d4da849a2c5d8bb6dba217f08b8c46b AS fs7
FROM ubuntu:20.04 AS runtime

LABEL org.opencontainers.image.title="SAMSEG"
LABEL org.opencontainers.image.description="Lightweight Docker image for FreeSurfer SAMSEG, derived from FreeSurfer 7.4.1"
LABEL org.opencontainers.image.authors="jhuguet@barcelonabeta.org"
LABEL org.opencontainers.image.source="https://github.com/jhuguetn/samseg-docker"
LABEL org.opencontainers.image.base.name="docker.io/freesurfer/freesurfer:7.4.1"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.version="7.4.1"
LABEL freesurfer.version="7.4.1"

ENV DEBIAN_FRONTEND=noninteractive \
    FREESURFER_HOME=/opt/freesurfer \
    PATH=/opt/freesurfer/bin:${PATH} \
    PYTHONUNBUFFERED=1

# Install minimal runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libglib2.0-0 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy SAMSEG executables/utilities and Python distribution from official FreeSurfer 7.4.1 image
COPY --from=fs7 /usr/local/freesurfer/bin/run_samseg ${FREESURFER_HOME}/bin/run_samseg
COPY --from=fs7 /usr/local/freesurfer/bin/samseg ${FREESURFER_HOME}/bin/samseg
COPY --from=fs7 /usr/local/freesurfer/bin/fspython ${FREESURFER_HOME}/bin/fspython
COPY --from=fs7 /usr/local/freesurfer/python ${FREESURFER_HOME}/python
COPY --from=fs7 /usr/local/freesurfer/FreeSurferColorLUT.txt ${FREESURFER_HOME}/FreeSurferColorLUT.txt
COPY --from=fs7 /usr/local/freesurfer/subjects/fsaverage/mri/orig.mgz ${FREESURFER_HOME}/subjects/fsaverage/mri/orig.mgz

WORKDIR /work

# Build-time sanity check
RUN run_samseg --help > /dev/null

ENTRYPOINT ["run_samseg"]
