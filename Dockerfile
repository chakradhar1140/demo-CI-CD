From tomcat:8-jre8 

# Maintainer
MAINTAINER "creddy1140@gmail.com" 

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
# copy war file on to container 
COPY **/*.war /usr/local/tomcat/webapps
            
# tell docker what port to expose
EXPOSE 8080

