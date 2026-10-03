FROM rockylinux/rockylinux:9

LABEL "maintainer"="Stephen Arnold <nerdboy@gentoo.org>" \
      "repository"="https://github.com/sarnold/action-rpm2sbom" \
      "homepage"="https://github.com/sarnold/action-rpm2sbom" \
      "com.github.actions.name"="action-rpm2sbom" \
      "com.github.actions.description"="Run distro2sbom as github action" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="package"

# Rocky 9 ships with GCC 11 and Python 3.9 by default.
# Enable CRB (CodeReady Builder) repo for texinfo and related build tools.
RUN dnf install -y dnf-plugins-core epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf install --setopt=install_weak_deps=False -y \
        wget git dnf-utils yum-utils createrepo_c python3-pip && \
    rm -rf /var/cache/dnf/*

RUN sed -i -e 's|/github/home|${GITHUB_WORKSPACE}|' .github/file-repo && \
    dnf config-manager --add-repo .github/file.repo

ADD gensbom.sh /
ADD requirements.txt /

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /requirements.txt
RUN chmod +x /gensbom.sh

ENTRYPOINT ["/gensbom.sh"]
