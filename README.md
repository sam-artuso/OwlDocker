# What is the OWL?
The OWL is an open source, programmable audio platform made for musicians,
hackers and programmers alike. Users can program their own effects, or download
ready-made patches from our growing [online patch library](https://hoxtonowl.com/patch-library/).
It is available both as a guitar fx pedal and a [Eurorack synthesizer module](http://www.rebeltech.org/products/owl-modular/).

# About this Docker image
This image provides the complete environment needed to compile OWL patches. A
developer can copy it on its machine and use it straight away.

**NOTE:** You don't need Docker to build OWL patches. This is just an _optional
developer dependency_ that is provided for convenience.

## How to use it
To build the image:

    docker build -t rebeltechnology/owl-compiler .

The build takes time. If you need to share the image with someone else, export
it to a file:

    docker save -o owl-compiler.tar rebeltechnology/owl-compiler

And they'll be able to import with:

    docker load -i owl-compiler.tar

To start the container:

    docker run -dt -v /tmp/owl:/tmp/owl --name owl-compiler rebeltechnology/owl-compiler

To run a command within the container:

    docker exec owl-compiler ls /opt

To attach the container:

    docker exec -it owl-compiler /bin/bash
