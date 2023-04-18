FROM maven as build
WORKDIR /app
# now I need all my files to be store in /app f.t here first . is for all files and second . is for /app
COPY . .
RUN mvn clean install -U


#  -------- SECOND STAGE -------#

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 9090
CMD [ "java","-jar","Uber.jar" ]
