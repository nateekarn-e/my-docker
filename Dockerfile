FROM centos:7.5.1804
RUN yum install -y wget bzip2 make gcc zlib-devel readline-devel &&\
    wget https://ftp.postgresql.org/pub/source/v10.5/postgresql-10.5.tar.bz2 &&\
    tar -xf /postgresql-10.5.tar.bz2 &&\
    cd /postgresql-10.5 && ./configure && make && make install &&\
    rm -f /postgresql-10.5.tar.bz2 &&\
    rm -rf /postgresql-10.5
ENV PATH $PATH:/usr/local/pgsql/bin
RUN useradd postgres &&\
    mkdir /pg_data &&\
    chown postgres:postgres /pg_data &&\
    runuser postgres -c 'initdb /pg_data'
