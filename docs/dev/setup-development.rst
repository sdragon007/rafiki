.. _`setup-development`:

Setup & Development
====================================================================

.. contents:: Table of Contents

Installation
--------------------------------------------------------------------

We assume development or deployment in a MacOS or Linux environment.

1. Install Docker 18

2. Install Python 3.6


Quick Setup
--------------------------------------------------------------------

1. Setup Rafiki's complete stack with the init script:

.. code-block:: shell

    bash scripts/start.sh

2. To destroy Rafiki's complete stack:

.. code-block:: shell

    bash scripts/stop.sh


Development
--------------------------------------------------------------------

Before running any individual scripts, make sure to run the shell configuration script:

.. code-block:: shell

    source .env.sh

Refer to :ref:`architecture` and :ref:`folder-structure` for a developer's overview of Rafiki.

Starting Parts of the Stack
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The quickstart instructions set up a single node Docker Swarm on your machine. Separate shell scripts in the `./scripts/` folder configure and start parts of Rafiki's stack. Refer to the commands in
`./scripts/start.sh`.

Connecting to Rafiki's DB
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, you can connect to the PostgreSQL DB using a PostgreSQL client (e.g `Postico <https://eggerapps.at/postico/>`_) with these credentials:

::

    POSTGRES_HOST=localhost
    POSTGRES_PORT=5433
    POSTGRES_USER=rafiki
    POSTGRES_DB=rafiki
    POSTGRES_PASSWORD=rafiki

Connecting to Rafiki's Cache
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can connect to Redis DB with `rebrow <https://github.com/marians/rebrow>`_:

.. code-block:: shell

    bash scripts/start_rebrow.sh

...with these credentials by default:

::

    REDIS_HOST=rafiki_cache
    REDIS_PORT=6379

Building Images Locally
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The quickstart instructions pull pre-built `Rafiki's images <https://hub.docker.com/r/rafikiai/>`_ from Docker Hub. To build Rafiki's images locally (e.g. to reflect latest code changes):

.. code-block:: shell

    bash scripts/build_images.sh

.. note::

    If you're testing latest code changes on multiple nodes, you'll need to build Rafiki's images on those nodes as well.

Pushing Images to Docker Hub
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To push the Rafiki's latest images to Docker Hub (e.g. to reflect the latest code changes):

.. code-block:: shell

    bash scripts/push_images.sh

Building Rafiki's Documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Rafiki uses `Sphinx documentation <http://www.sphinx-doc.org>`_ and hosts the documentation with `Github Pages <https://pages.github.com/>`_ on the `gh-pages branch <https://github.com/nginyc/rafiki/tree/gh-pages>`_. Build & view Rafiki's Sphinx documentation on your machine with the following commands:

.. code-block:: shell

    bash scripts/build_docs.sh
    open docs/index.html


Reading Rafiki's logs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can read logs of Rafiki Admin, Rafiki Advisor & any of Rafiki's services in Rafiki's logs directory:

.. code-block:: shell

    open $LOGS_FOLDER_PATH


Using Rafiki Admin's HTTP interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To make calls to the HTTP endpoints, you'll need first authenticate with email & password against the `POST /tokens` endpoint to obtain an authentication token `token`, and subsequently add the `Authorization` header for every other call:

::

    Authorization: Bearer {{token}}


Troubleshooting
--------------------------------------------------------------------

While building Rafiki's images locally, if you encounter an error like "No space left on device", you might be running out of space allocated for Docker. Try removing all containers & images:

.. code-block:: shell

    # Delete all containers
    docker rm $(docker ps -a -q)
    # Delete all images
    docker rmi $(docker images -q)
