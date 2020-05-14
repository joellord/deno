FROM fedora:32

RUN curl https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/30/Everything/x86_64/os/Packages/u/unzip-6.0-43.fc30.x86_64.rpm --output unzip.rpm
RUN yum install -yq ./unzip.rpm 

RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.0.0

ENV DENO_INSTALL="/root/.deno"
ENV PATH="$DENO_INSTALL/bin:$PATH"

RUN mkdir /deno-entrypoint
WORKDIR /deno-entrypoint

COPY ./autostart.sh /scripts/autostart.sh
RUN chmod +x /scripts/autostart.sh

CMD ["sh", "/scripts/autostart.sh"]