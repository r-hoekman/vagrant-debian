activemq:
  instances:
    formulatest: # must be unique; used as an ID declaration in Salt; also passed to the template context as  id
      enabled: True
      brokers:
        broker0: # must be unique; used as an ID declaration in Salt; also passed to the template context as  id
          brokerName: "broker0"
          dataDirectory: "${activemq.base}/data" # This variable is actually processed outside of salt
          persistenceAdapters:
            persistenceAdapter0:
              persistenceAdapter: "kahaDB"
              persistenceAdapter_directory: "${activemq.base}/data/kahadb"
          transportConnectors:
            connector0: # use unique identifiers here as well as it is used by Salt as an ID declaration
              name: "openwire"
              uri: "tcp://0.0.0.0:61617"
            connector1:
              name: "stomp+nio"
              uri: "stomp+nio://0.0.0.0:61614?needClientAuth=false"
