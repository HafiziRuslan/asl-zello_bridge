FROM python:slim-trixie

# Install uv
COPY --from=ghcr.io/astral-sh/uv:trixie-slim /uv /uvx /bin/

# Install dependencies
RUN apt-get update \
    && apt-get install -y git libogg-dev libopusenc-dev libflac-dev libopusfile-dev libopus-dev libvorbis-dev libopus0 \
    && apt-get clean

# Create virtual environment for bridge
ENV VIRTUAL_ENV=/opt/zello_brigde/venv
RUN uv venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install bridge
ADD . /opt/zello_brigde
RUN cd /opt/zello_brigde \
    && uv sync

CMD ["zello_brigde"]
