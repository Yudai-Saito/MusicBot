FROM ubuntu

# Add project source
WORKDIR /usr/src/musicbot
COPY . ./

# Install dependencies
RUN apt update \
&& apt install -y \
  curl \
  ca-certificates \
  ffmpeg \
  libsodium-dev \
\
# Install build dependencies
&& apt install -y \
  build-essential \
  libffi-dev \
  libssl-dev \
  zlib1g-dev \
  liblzma-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libopencv-dev \
  tk-dev \
  git \
\
# Install pyenv
&& git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
&& PYENV_ROOT="$HOME/.pyenv" \
&& export PATH="$PYENV_ROOT/bin:$PATH" \
&& eval "$(pyenv init --path)" \
&& pyenv install 3.7.11 \
&& pyenv global 3.7.11 \
\
# Install pip dependencies
&& pip install --upgrade pip \
&& pip install -r requirements.txt \
\
# Clean up build dependencies
&& pip cache purge

# Create volume for mapping the config
VOLUME /usr/src/musicbot/config

# Set pyenv environment variable
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

ENV APP_ENV docker

ENTRYPOINT ["bash", "/usr/src/musicbot/start.sh"]
