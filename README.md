#### Purpose ####
- Sample Spring Boot Project created to use it in the hiring process of Cloud/DevOps  

### How to Start the application ###
- Run SpringBootSampleMain class

### Tech Requirements ###
- Java 1.8
- Maven

### Documentation ###
- This Project exposes 3 apis - Create/Delete/View User
- Server starts on http://localhost:8080

- Create User is a Post Request and the url for it is http://localhost:8080/user/create
   - Sample for create - "curl --location --request POST 'http://localhost:8080/user/create' --header 'Content-Type: application/json' --data-raw '{"name":"devops"}'"

- View User is a Get Request and the url for it is http://localhost:8080/user/{name}
   - Sample for view - "curl --location --request GET 'http://localhost:8080/user/devops'"

- Delete User is a Delete Request and the url for it is http://localhost:8080/user/delete/{name}
   - Sample for delete - "curl --location --request DELETE 'http://localhost:8080/user/delete/devops'"


