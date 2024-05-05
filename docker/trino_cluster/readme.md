# Set up Trino Cluster

## Create config files

1. Coordinator node

- create directory and files

    ```bash
    # create directory
    mkdir -p trino_cluster/coordinator/etc
    cd trino_cluster/coordinator/etc

    # create config files
    touch jvm.config
    touch config.properties
    touch node.properties
    ```

- sample files
  - jvm.config

    ```txt
    -server
    -Xmx16G
    -XX:InitialRAMPercentage=80
    -XX:MaxRAMPercentage=80
    -XX:G1HeapRegionSize=32M
    -XX:+ExplicitGCInvokesConcurrent
    -XX:+ExitOnOutOfMemoryError
    -XX:+HeapDumpOnOutOfMemoryError
    -XX:-OmitStackTraceInFastThrow
    -XX:ReservedCodeCacheSize=512M
    -XX:PerMethodRecompilationCutoff=10000
    -XX:PerBytecodeRecompilationCutoff=10000
    -Djdk.attach.allowAttachSelf=true
    -Djdk.nio.maxCachedBufferSize=2000000
    -XX:+UnlockDiagnosticVMOptions
    -XX:+UseAESCTRIntrinsics
    # Disable Preventive GC for performance reasons (JDK-8293861)
    -XX:-G1UsePreventiveGC
    -DHADOOP_USER_NAME=root
    ```

  - config.properties

    ```txt
    coordinator=true
    discovery-server.enabled=true
    node-scheduler.include-coordinator=true
    http-server.http.port=8080
    discovery.uri=http://localhost:8080
    query.max-total-memory=32GB
    query.max-memory-per-node=10GB
    query.max-memory=10GB
    scheduler.http-client.connect-timeout=600s
    http-server.process-forwarded=true
    ```

  - node.properties

    ```txt
    node.environment=docker
    node.data-dir=/data/trino
    plugin.dir=/usr/lib/trino/plugin
    ```

2. Worker nodes

- create directory and files

    ```bash
    # create directory
    mkdir -p trino_cluster/worker_1/etc
    mkdir -p trino_cluster/worker_2/etc

    # create config files
    cd trino_cluster/worker_1/etc
    touch jvm.config
    touch config.properties
    touch node.properties

    # create the same files for worker_2 as well
    ```

- sample files
  - jvm.config, node.properties
    - same as the coordinator's
  - config.properties for worker_1

    ```txt
    coordinator=false
    http-server.http.port=8081
    discovery.uri=http://<coordinator_host>:8080
    ```

  - config.properties for worker_2

    ```txt
    coordinator=false
    http-server.http.port=8082 # Each node must have different port
    discovery.uri=http://<coordinator_host>:8080
    ```
