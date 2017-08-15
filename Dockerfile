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
RUN apt-get update && apt-get install -y git apt-transport-https ca-certificates
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-zesty-prod zesty main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN apt-get update && apt-get install -y dotnet-sdk-2.0.0

RUN dotnet new -l
RUN dotnet --info

RUN echo 'root:password' | chpasswd
RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y openssh-server nano libc6:i386 libncurses5:i386 libstdc++6:i386
