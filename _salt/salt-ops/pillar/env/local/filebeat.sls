filebeat:
  config:
    filebeat:
      # List of prospectors to fetch data.
      prospectors:
        # Each - is a prospector. Below are the prospector specific configurations
        -
          # Paths that should be crawled and fetched. Glob based paths.
          # To fetch all ".log" files from a specific level of subdirectories
          # /var/log/*/*.log can be used.
          # For each file found under this path, a harvester is started.
          # Make sure no file is defined twice as this can lead to unexpected behaviour.
          paths:
            - /var/log/syslog
            - /var/log/auth.log
          input_type: log
          document_type: syslog

    output:
      ### Elasticsearch as output
      logstash:
        hosts: ["127.0.0.1:5044"]

    logging:
      files:
        rotateeverybytes: 10485760 # = 10MB
