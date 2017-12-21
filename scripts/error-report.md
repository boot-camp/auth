### Expected behavior

> Docker compose will build new image before loading it.

### Actual behavior

> Produce error message  
ERROR: Service xxx failed to build: failed to get layer for image

### Information

  - Diagnostic ID from "Diagnose & Feedback" in the menu.

> F2099E05-3DBA-47DC-974B-B993D6042D1E/2017-12-20_01-47-21

  - a reproducible case if this is a bug, Dockerfiles FTW

``` dockerfile
# Dockerfile

FROM node:carbon-alpine
ENV NODE_ENV production
WORKDIR /usr/src/app

# docker-compose.yml

version: '3'

services:
  web:
    image: webtest
    build: .
    environment:
      NODE_ENV: production
    ports:
      - 8080:8080
```
  - page URL if this is a docs issue or the name of a man page

> N/A

  - host distribution and version (Windows version, build number, etc)

> OS Name:	Microsoft Windows 10 Pro x64
Version	10.0.16299 Build 16299
Processor	Intel(R) Core(TM) i7-3687U CPU @ 2.10GHz, 2101 Mhz, 2 Core(s), 4 Logical Processor(s)
Storage: SSD 7GB free
No proxy

> Docker version
Client:
 Version:      17.11.0-ce
 API version:  1.34
 Go version:   go1.8.3
 Git commit:   1caf76c
 Built:        Mon Nov 20 18:37:39 2017
 OS/Arch:      linux/amd64
Server:
 Version:      17.12.0-ce-rc2
 API version:  1.35 (minimum version 1.24)
 Go version:   go1.9.2
 Git commit:   f9cde63
 Built:        Tue Dec 12 06:52:05 2017
 OS/Arch:      windows/amd64
 Experimental: true
docker-compose version 1.18.0-rc2, build 189468b

### Steps to reproduce the behavior

  1. docker pull node:carbon-alpine
  2. docker-compose --verbose -f docker-compose.yml up -d --build

output:
``` shell
compose.config.config.find: Using configuration files: .\docker-compose.yml
docker.auth.find_config_file: Trying paths: ['C:\\Users\\xxx\\.docker\\config.json', 'C:\\Users\\xxx\\.dockercfg']
docker.auth.find_config_file: Found file at path: C:\Users\xxx\.docker\config.json
docker.auth.load_config: Found 'auths' section
docker.auth.parse_auth: Auth data for {0} is absent. Client might be using a credentials store instead.
docker.auth.load_config: Found 'credsStore' section
urllib3.connectionpool._make_request: http://localhost:None "GET /v1.25/version HTTP/1.1" 200 646
compose.cli.command.get_client: docker-compose version 1.18.0-rc2, build 189468b0
docker-py version: 2.6.1
CPython version: 2.7.14
OpenSSL version: OpenSSL 1.0.2k  26 Jan 2017
compose.cli.command.get_client: Docker base_url: http+docker://localnpipe
compose.cli.command.get_client: Docker version: KernelVersion=10.0 16299 (16299.15.amd64fre.rs3_release.170928-1534), Components=[{u'Version': u'17.12.0-ce-rc2', u'Name': u'Engine', u'Details': {u'KernelVersion': u'10.0 16299 (16299.15.amd64fre.rs3_release.170928-1534)', u'Os': u'windows', u'BuildTime': u'2017-12-12T06:52:05.000000000+00:00', u'ApiVersion': u'1.35', u'MinAPIVersion': u'1.24', u'GitCommit': u'f9cde63', u'Arch': u'amd64', u'Experimental': u'true', u'GoVersion': u'go1.9.2'}}], Arch=amd64, BuildTime=2017-12-12T06:52:05.000000000+00:00, ApiVersion=1.35, Platform={u'Name': u''}, Version=17.12.0-ce-rc2, MinAPIVersion=1.24, GitCommit=f9cde63, Os=windows, Experimental=True, GoVersion=go1.9.2
compose.cli.verbose_proxy.proxy_callable: docker info <- ()
urllib3.connectionpool._make_request: http://localhost:None "GET /v1.25/info HTTP/1.1" 200 1944
compose.cli.verbose_proxy.proxy_callable: docker info -> {u'Architecture': u'x86_64',
 u'BridgeNfIp6tables': True,
 u'BridgeNfIptables': True,
 u'CPUSet': False,
 u'CPUShares': False,
 u'CgroupDriver': u'',
 u'ClusterAdvertise': u'',
 u'ClusterStore': u'',
 u'ContainerdCommit': {u'Expected': u'', u'ID': u''},
 u'Containers': 1,
...
compose.cli.verbose_proxy.proxy_callable: docker inspect_network <- (u'easynodeauthentication_default')
urllib3.connectionpool._make_request: http://localhost:None "GET /v1.25/networks/easynodeauthentication_default HTTP/1.1" 200 615
compose.cli.verbose_proxy.proxy_callable: docker inspect_network -> {u'Attachable': True,
 u'ConfigFrom': {u'Network': u''},
 u'ConfigOnly': False,
 u'Containers': {},
 u'Created': u'2017-12-20T01:32:30.7112664+08:00',
 u'Driver': u'nat',
 u'EnableIPv6': False,
 u'IPAM': {u'Config': [{u'Gateway': u'0.0.0.0', u'Subnet': u'0.0.0.0/0'}],
           u'Driver': u'windows',
           u'Options': None},
...
compose.cli.verbose_proxy.proxy_callable: docker containers <- (all=False, filters={u'label': [u'com.docker.compose.project=easynodeauthentication', u'com.docker.compose.oneoff=False']})
urllib3.connectionpool._make_request: http://localhost:None "GET /v1.25/containers/json?all=0&limit=-1&filters=%7B%22label%22%3A+%5B%22com.docker.compose.project%3Deasynodeauthentication%22%2C+%22com.docker.compose.oneoff%3DFalse%22%5D%7D&trunc_cmd=0&size=0 HTTP/1.1" 200 3
compose.cli.verbose_proxy.proxy_callable: docker containers -> (list with 0 items)
compose.cli.verbose_proxy.proxy_callable: docker containers <- (all=True, filters={u'label': [u'com.docker.compose.project=easynodeauthentication', u'com.docker.compose.service=web', u'com.docker.compose.oneoff=False']})
urllib3.connectionpool._make_request: http://localhost:None "GET /v1.25/containers/json?all=1&limit=-1&filters=%7B%22label%22%3A+%5B%22com.docker.compose.project%3Deasynodeauthentication%22%2C+%22com.docker.compose.service%3Dweb%22%2C+%22com.docker.compose.oneoff%3DFalse%22%5D%7D&trunc_cmd=0&size=0 HTTP/1.1" 200 3
compose.cli.verbose_proxy.proxy_callable: docker containers -> (list with 0 items)
compose.service.build: Building web
compose.cli.verbose_proxy.proxy_callable: docker build <- (pull=False, labels=None, target=None, nocache=False, container_limits={u'memory': None}, cache_from=None, extra_hosts=None, network_mode=None, tag='webtest', buildargs={}, rm=True, stream=True, path=u'D:\\xxx\\easy-node-authentication', dockerfile=None, forcerm=False, shmsize=None)
docker.api.build._set_auth_headers: Looking for auth config
docker.auth.resolve_authconfig: Using credentials store "wincred"
docker.auth._resolve_authconfig_credstore: Looking for auth entry for u'https://index.docker.io/v1/'
docker.api.build._set_auth_headers: Sending auth config (u'https://index.docker.io/v1/')
urllib3.connectionpool._make_request: http://localhost:None "POST /v1.25/build?q=False&pull=False&t=webtest&nocache=False&forcerm=False&rm=True HTTP/1.1" 200 None
compose.cli.verbose_proxy.proxy_callable: docker build -> <generator object _stream_helper at 0x000000000619A3F0>
Step 1/3 : FROM node:carbon-alpine
ERROR: compose.cli.main.main: Service 'web' failed to build: failed to get layer for image sha256:144aaf4b136784e4e8a8418b9ff44827c283124b8b2f86bd65b8382b54162be4: layer does not exist
```

output from WSL:

``` shell
compose.config.config.find: Using configuration files: ./docker-compose.yml
docker.auth.find_config_file: Trying paths: ['/home/xxx/.docker/config.json', '/home/xxx/.dockercfg']
docker.auth.find_config_file: Found file at path: /home/xxx/.docker/config.json
docker.auth.load_config: Found 'auths' section
docker.auth.parse_auth: Found entry (registry=u'https://index.docker.io/v1/', username=u'xxx')
docker.auth.load_config: Found 'HttpHeaders' section
urllib3.connectionpool._new_conn: Starting new HTTP connection (1): localhost
urllib3.connectionpool._make_request: http://localhost:2375 "GET /v1.25/version HTTP/1.1" 200 646
compose.cli.command.get_client: docker-compose version 1.18.0-rc2, build 189468b
docker-py version: 2.6.1
CPython version: 2.7.13
OpenSSL version: OpenSSL 1.0.1t  3 May 2016
compose.cli.command.get_client: Docker base_url: http://localhost:2375
compose.cli.command.get_client: Docker version: KernelVersion=10.0 16299 (16299.15.amd64fre.rs3_release.170928-1534), Components=[{u'Version': u'17.12.0-ce-rc2', u'Name': u'Engine', u'Details': {u'KernelVersion': u'10.0 16299 (16299.15.amd64fre.rs3_release.170928-1534)', u'Os': u'windows', u'BuildTime': u'2017-12-12T06:52:05.000000000+00:00', u'ApiVersion': u'1.35', u'MinAPIVersion': u'1.24', u'GitCommit': u'f9cde63', u'Arch': u'amd64', u'Experimental': u'true', u'GoVersion': u'go1.9.2'}}], Arch=amd64, BuildTime=2017-12-12T06:52:05.000000000+00:00, ApiVersion=1.35, Platform={u'Name': u''}, Version=17.12.0-ce-rc2, MinAPIVersion=1.24, GitCommit=f9cde63, Os=windows, Experimental=True, GoVersion=go1.9.2
compose.cli.verbose_proxy.proxy_callable: docker info <- ()
urllib3.connectionpool._make_request: http://localhost:2375 "GET /v1.25/info HTTP/1.1" 200 1944
compose.cli.verbose_proxy.proxy_callable: docker info -> {u'Architecture': u'x86_64',
 u'BridgeNfIp6tables': True,
 u'BridgeNfIptables': True,
 u'CPUSet': False,
 u'CPUShares': False,
 u'CgroupDriver': u'',
 u'ClusterAdvertise': u'',
 u'ClusterStore': u'',
 u'ContainerdCommit': {u'Expected': u'', u'ID': u''},
 u'Containers': 1,
...
compose.cli.verbose_proxy.proxy_callable: docker inspect_network <- (u'easynodeauthentication_default')
urllib3.connectionpool._make_request: http://localhost:2375 "GET /v1.25/networks/easynodeauthentication_default HTTP/1.1" 200
615
compose.cli.verbose_proxy.proxy_callable: docker inspect_network -> {u'Attachable': True,
 u'ConfigFrom': {u'Network': u''},
 u'ConfigOnly': False,
 u'Containers': {},
 u'Created': u'2017-12-20T01:32:30.7112664+08:00',
 u'Driver': u'nat',
 u'EnableIPv6': False,
 u'IPAM': {u'Config': [{u'Gateway': u'0.0.0.0', u'Subnet': u'0.0.0.0/0'}],
           u'Driver': u'windows',
           u'Options': None},
...
compose.cli.verbose_proxy.proxy_callable: docker containers <- (all=False, filters={u'label': [u'com.docker.compose.project=easynodeauthentication', u'com.docker.compose.oneoff=False']})
urllib3.connectionpool._make_request: http://localhost:2375 "GET /v1.25/containers/json?all=0&limit=-1&filters=%7B%22label%22%3A+%5B%22com.docker.compose.project%3Deasynodeauthentication%22%2C+%22com.docker.compose.oneoff%3DFalse%22%5D%7D&trunc_cmd=0&size=0 HTTP/1.1" 200 3
compose.cli.verbose_proxy.proxy_callable: docker containers -> (list with 0 items)
compose.cli.verbose_proxy.proxy_callable: docker containers <- (all=True, filters={u'label': [u'com.docker.compose.project=easynodeauthentication', u'com.docker.compose.service=web', u'com.docker.compose.oneoff=False']})
urllib3.connectionpool._make_request: http://localhost:2375 "GET /v1.25/containers/json?all=1&limit=-1&filters=%7B%22label%22%3A+%5B%22com.docker.compose.project%3Deasynodeauthentication%22%2C+%22com.docker.compose.service%3Dweb%22%2C+%22com.docker.compose.oneoff%3DFalse%22%5D%7D&trunc_cmd=0&size=0 HTTP/1.1" 200 3
compose.cli.verbose_proxy.proxy_callable: docker containers -> (list with 0 items)
compose.service.build: Building web
compose.cli.verbose_proxy.proxy_callable: docker build <- (pull=False, labels=None, target=None, nocache=False, container_limits={u'memory': None}, cache_from=None, extra_hosts=None, network_mode=None, tag='webtest', buildargs={}, rm=True, stream=True, path='/mnt/d/xxx/easy-node-authentication', dockerfile=None, forcerm=False, shmsize=None)
docker.api.build._set_auth_headers: Looking for auth config
docker.api.build._set_auth_headers: Sending auth config (u'https://index.docker.io/v1/', 'HttpHeaders')
urllib3.connectionpool._make_request: http://localhost:2375 "POST /v1.25/build?q=False&pull=False&t=webtest&nocache=False&forcerm=False&rm=True HTTP/1.1" 200 None
compose.cli.verbose_proxy.proxy_callable: docker build -> <generator object _stream_helper at 0x7fa024be1190>
Step 1/3 : FROM node:carbon-alpine
ERROR: compose.cli.main.main: Service 'web' failed to build: failed to get layer for image sha256:144aaf4b136784e4e8a8418b9ff44827c283124b8b2f86bd65b8382b54162be4: layer does not exist
```

``` shell
$ docker inspect node:carbon-alpine
[
    {
        "Id": "sha256:144aaf4b136784e4e8a8418b9ff44827c283124b8b2f86bd65b8382b54162be4",
        "RepoTags": [
            "node:carbon-alpine"
        ],
        "RepoDigests": [
            "node@sha256:40201c973cf40708f06205b22067f952dd46a29cecb7a74b873ce303ad0d11a5"
        ],
        "Parent": "",
        "Comment": "",
        "Created": "2017-12-08T23:44:12.533598213Z",
        "Container": "1896cc30a71f85695a1b7af2876d431209cc877ed0825019a0279f0d8acd300f",
        "ContainerConfig": {
            "Hostname": "1896cc30a71f",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "NODE_VERSION=8.9.3",
                "YARN_VERSION=1.3.2"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"node\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:990eb6dd43ce9b7ad331c243f7122ac2af01b3ec915dcb9c479a208d6920fc9c",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": {}
        },
        "DockerVersion": "17.06.2-ce",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "NODE_VERSION=8.9.3",
                "YARN_VERSION=1.3.2"
            ],
            "Cmd": [
                "node"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:990eb6dd43ce9b7ad331c243f7122ac2af01b3ec915dcb9c479a208d6920fc9c",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 124257792,
        "VirtualSize": 124257792,
        "GraphDriver": {
            "Data": {
                "dir": "C:\\ProgramData\\Docker\\lcow\\lcow\\532fa54e4a32ce26d2b55c7dec67570731c9a303f364fb3968879c2f80a0488a"            },
            "Name": "lcow"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:6dfaec39e726d242fcd42e9fffac82c3079a1aa20fc39420b662507b163ee4da",
                "sha256:2ec940494cc034235e73238691fe0604b01449f5ce1015061c863e47019ca991",
                "sha256:1dfbdf308b77ba401f9f9d078461b61ed818e7b1b70ea211459967893b3a4187"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        }
    }
]
```


