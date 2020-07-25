class GraphApi {
  static String login = """mutation (\$email:String!,\$password:String!){
  Login(email:\$email,password:\$password){
    	code
    	success
    	message
    	token
    	user{
        firstname
        lastname
        email
        role
        createdAt
        isEmailVarified
        role
        avater
      }
  }
}
""";
}
