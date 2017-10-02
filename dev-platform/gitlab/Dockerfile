FROM gitlab/gitlab-ce:latest

# Set gitlab context path to match Kubernetes ingress
RUN sed -i 's/{host}/{host}\/gitlab/g' /assets/gitlab.rb