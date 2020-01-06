FROM openjdk:8-jre-alpine
RUN apk add bash coreutils --no-cache
COPY findsecbugs /findsecbugs
COPY run-findsecbugs.sh /findsecbugs/run-findsecbugs.sh
RUN chmod +x /findsecbugs/run-findsecbugs.sh
RUN ln -s /findsecbugs/run-findsecbugs.sh /bin/findsecbugs
WORKDIR /workspace