FROM fedora:32

RUN curl https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/30/Everything/x86_64/os/Packages/u/unzip-6.0-43.fc30.x86_64.rpm --output unzip.rpm
RUN yum install -yq ./unzip.rpm 

RUN mkdir /deno-entrypoint
RUN mkdir /scripts
COPY ./autostart.sh /scripts/autostart.sh
RUN chmod +x /scripts/autostart.sh

ENV HOME /home/deno

RUN adduser --uid 1000 --home $HOME --shell /bin/bash --user-group deno

RUN chown -R deno /deno-entrypoint
RUN chown -R deno /scripts
RUN chmod a+rwx $HOME

USER 1000:1000

RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.0.2

ENV DENO_INSTALL /$HOME/.deno
ENV PATH $DENO_INSTALL/bin:$PATH

WORKDIR /deno-entrypoint

CMD ["sh", "/scripts/autostart.sh"]