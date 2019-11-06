FROM elasticsearch:6.7.2

RUN wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /usr/bin/jq
RUN chmod +x /usr/bin/jq

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-nori --verbose

COPY config/utils /root/utils

RUN mkdir -p /usr/share/elasticsearch/config/nori
RUN mkdir -p /usr/share/elasticsearch/config/synonym

# Add configuration
# COPY config/elasticsearch.yml config/log4j2.properties config/

# Install custom synonym
# COPY dict/synonym.txt /usr/share/elasticsearch/config/synonym.txt
# RUN chown elasticsearch.elasticsearch /usr/share/elasticsearch/config/synonym.txt

# Install user dictionary
# COPY dict/dict-service-noun /usr/share/elasticsearch/config/nori/dict-service-noun
# RUN chown elasticsearch.elasticsearch /usr/share/elasticsearch/config/nori/dict-service-noun

# RUN mkdir -p /usr/share/elasticsearch/config/nori
# # Install custom synonym
# RUN curl "https://daangn.s3.ap-northeast-2.amazonaws.com/search/synonym.txt" -o /usr/share/elasticsearch/config/synonym.txt
# RUN chown elasticsearch.elasticsearch /usr/share/elasticsearch/config/synonym.txt

# # Install user dictionary
# RUN curl "https://daangn.s3.ap-northeast-2.amazonaws.com/search/dict-service-noun" -o /usr/share/elasticsearch/config/nori/dict-service-noun
# RUN chown elasticsearch.elasticsearch /usr/share/elasticsearch/config/nori/dict-service-noun
