(Gihub) action-rpm2sbom
=======================

|CI| |pre|

|tag| |license|

What is distro2SBOM?
--------------------

The distro2SBOM_ tool generates an SBOM (Software Bill of Materials) for
either an installed application or a complete system installation in a
number of formats including SPDX and CycloneDX. An SBOM for an
installed package will identify all of its dependent components.

What you can do with action-rpm2sbom:

* generate a nicely-formatted (and optionally machine-readable) release
  document to use with something like `softprops/action-gh-release`_

By default this action will create a CycloneDX_ SBOM using pretty-printed
JSON as the output format.  The full option list is shown below.


.. _distro2SBOM: https://github.com/anthonyharrison/distro2SBOM
.. _CycloneDX: https://www.cyclonedx.org/
.. _softprops/action-gh-release: https://github.com/softprops/action-gh-release

Examples
--------



Usage
-----

To enable the default release page SBOM file, create a .yml file under
.github/workflows with the following contents.

.. note:: Be sure to use the latest tag for this action if you're not
          tracking 'v1' or the ``master`` branch.

Default configuration
~~~~~~~~~~~~~~~~~~~~~

::

    name: MyPkgSBOM
    on: [push]

    jobs:
      release:
        name: MyPkg
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v6
            with:
              fetch-depth: 0

          # download all artifacts to rpms dir
          - uses: actions/download-artifact@v8
            with:
              name: rpms
              path: rpms

          - name: rpm2sbom action step
            uses: sarnold/action-rpm2sbom@v1
            with:
              artifact_path: "rpms"
              package_name: python3-statemachine
              github_token: ${{ secrets.GITHUB_TOKEN}}


The above is enough to generate the default output, but should be paired
with an upload-artifact or release action to deploy the resulting
artifact somewhere.

Full configuration
~~~~~~~~~~~~~~~~~~



Input Options
-------------

.. note:: All input options are optional *except* ``github_token``.


:github_token: GITHUB_TOKEN secret (automatically provided by Github)


Output Constraints
------------------

* If you need to generate SBOMs outside the github release context,
  the workaround for now is using `actions/upload-artifact`_.


.. _actions/upload-artifact: https://github.com/actions/upload-artifact

Operating System Support
------------------------

This action runs in a Docker container and requires the Ubuntu_ CI runner.
In your workflow job configuration, you should set the ``runs-on``
property to ``ubuntu-latest``::

    jobs:
      release:
        runs-on: ubuntu-latest



.. _Ubuntu: https://ubuntu.com/


.. |CI| image:: https://github.com/sarnold/action-rpm2sbom/actions/workflows/main.yml/badge.svg
    :target: https://github.com/sarnold/action-rpm2sbom/actions/workflows/main.yml
    :alt: CI test status

.. |pre| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&amp;logoColor=white
   :target: https://github.com/pre-commit/pre-commit
   :alt: pre-commit

.. |tag| image:: https://img.shields.io/github/v/tag/sarnold/action-rpm2sbom?color=green&include_prereleases&label=latest%20release
    :target: https://github.com/sarnold/action-rpm2sbom/releases
    :alt: GitHub tag

.. |license| image:: https://img.shields.io/github/license/sarnold/action-rpm2sbom
    :target: https://github.com/sarnold/action-rpm2sbom/blob/master/LICENSE
    :alt: License
