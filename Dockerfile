FROM debian:sid
MAINTAINER Sam Artuso <sam@highoctanedev.co.uk>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git wget bzip2 unzip && \

    >&2 echo '################################' && \
    >&2 echo '### Installing emscripten... ###' && \
    >&2 echo '################################' && \
    apt-get install -y build-essential cmake python2.7 nodejs default-jre && \
    cd /opt && \
    wget --quiet 'https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz' && \
    tar -xf emsdk-portable.tar.gz && \
    rm -f emsdk-portable.tar.gz && \
    cd emsdk_portable && \
    ./emsdk update && \
    ./emsdk install --build=MinSizeRel --shallow latest && \
    ./emsdk activate --build=MinSizeRel latest && \
    ./emsdk construct_env && \
    . ./emsdk_set_env.sh && \
    echo '. /opt/emsdk_portable/emsdk_set_env.sh' >> /root/.bashrc && \
    cd /opt && \
    ln -s /root/.emscripten . && \
    ln -s /root/.emscripten_cache . && \
    apt-get remove --purge -y build-essential cmake && \
    >&2 echo '#############################' && \
    >&2 echo '### Testing emscripten... ###' && \
    >&2 echo '#############################' && \
    emcc --version && \
    cd /opt/emsdk_portable && \
    emcc emscripten/master/tests/hello_world.cpp && \
    rm -f ./a.out.js && \

    >&2 echo '################################' && \
    >&2 echo '### Installing OwlProgram... ###' && \
    >&2 echo '################################' && \
    cd /opt && \
    git clone --depth=1 https://github.com/pingdynasty/OwlProgram.git OwlProgram.online && \

    >&2 echo '##################################' && \
    >&2 echo '### Installing ARM compiler... ###' && \
    >&2 echo '##################################' && \
    cd /opt/OwlProgram.online/Tools && \
    apt-get install -y lib32z1 lib32ncurses5 && \
    apt-get autoremove -y && \
    wget --quiet 'https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q2-update/+download/gcc-arm-none-eabi-5_4-2016q2-20160622-linux.tar.bz2' && \
    tar -xf gcc-arm-none-eabi-5_4-2016q2-20160622-linux.tar.bz2 && \
    rm -f gcc-arm-none-eabi-5_4-2016q2-20160622-linux.tar.bz2 && \

    >&2 echo '####################################' && \
    >&2 echo '### Installing FirmwareSender... ###' && \
    >&2 echo '####################################' && \
    cd /opt/OwlProgram.online/Tools && \
    wget --quiet https://github.com/pingdynasty/FirmwareSender/releases/download/v0.1/FirmwareSender-linux64.zip && \
    unzip FirmwareSender-linux64.zip && \
    rm -f FirmwareSender-linux64.zip

ENV EM_CACHE /opt/.emscripten_cache
ENV EM_CONFIG /opt/.emscripten
