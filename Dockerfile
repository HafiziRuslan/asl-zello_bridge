FROM python:slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install dependencies
RUN apt-get update \
    && apt-get install -y git libogg-dev libopusenc-dev libflac-dev libopusfile-dev libopus-dev libvorbis-dev libopus0 \
    && apt-get clean

# Create virtual environment for bridge
ENV VIRTUAL_ENV=/opt/asl-zello_bridge/venv
RUN uv venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install bridge
ADD . /opt/asl-zello_bridge
RUN cd /opt/asl-zello_bridge \
    && uv sync

CMD ["asl-zello_bridge"]
