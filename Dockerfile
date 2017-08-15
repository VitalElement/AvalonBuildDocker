FROM ubuntu:zesty

# Install mono
RUN apt-get update \
	&& apt-get install -y curl dirmngr \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/ubuntu xenial main" > /etc/apt/sources.list.d/mono-official.list \
	&& apt-get update \
	&& apt-get install -y mono-devel ca-certificates-mono fsharp mono-vbnc nuget \
	&& rm -rf /var/lib/apt/lists/*

# Install Git    
#RUN apt-get update && apt-get install -y git libcurl3 lib32z1 lib32ncurses5 libunwind8 libunwind8-dev gettext libicu-dev liblttng-ust-dev libcurl4-openssl-dev libssl-dev uuid-dev unzip
RUN apt-get update && apt-get install -y git apt-transport-https ca-certificates
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-zesty-prod zesty main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN apt-get update && apt-get install -y dotnet-sdk-2.0.0

#RUN curl -sSL -o dotnet.tar.gz https://download.microsoft.com/download/1/B/4/1B4DE605-8378-47A5-B01B-2C79D6C55519/dotnet-sdk-2.0.0-linux-x64.tar.gz
#RUN mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet && rm dotnet.tar.gz
#RUN ln -s /opt/dotnet/dotnet /usr/local/bin
RUN dotnet new -l
RUN dotnet --info
