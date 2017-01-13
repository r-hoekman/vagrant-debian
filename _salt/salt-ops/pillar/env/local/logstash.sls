logstash:
#  java:
#    install: openjdk
#    install: oracle
  inputs:
    -
      plugin_name: beats
      port: 5044
  filters:
    -
      plugin_name: grok
      cond: 'if [type] == "syslog"'
      match:
        message: '%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}'
      add_field:
        received_at: '%{@timestamp}'
        received_from: '%{host}'
    -
      plugin_name: grok
      cond: 'else if [type] == "nginx"'
      match:
        message: '%{IPORHOST:clientip} %{USER:ident} %{USER:auth} \[%{HTTPDATE:timestamp}\] \"(?:%{WORD:verb} %{URIPATHPARAM:request}(?: HTTP/%{NUMBER:httpversion})?|-)\" %{NUMBER:response} (?:%{NUMBER:bytes}|-) \"(?:%{URI:referrer}|-)\" %{QS:agent}'
      add_field:
        received_at: '%{@timestamp}'
        received_from: '%{host}'
    -
      plugin_name: date
      match:
        - 'syslog_timestamp'
        - 'MMM  d HH:mm:ss'
        - 'MMM dd HH:mm:ss'
  outputs:
    -
      plugin_name: elasticsearch
      hosts:
        - "localhost:9200"
      #manage_template:
      index: "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
      document_type: "%{[@metadata][type]}"
