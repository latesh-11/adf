FROM maven as build
WORKDIR /app
COPY . .

#  -------- SECOND STAGE -------#

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 9090
CMD [ "java","-jar","Uber.jar" ]
