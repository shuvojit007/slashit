class GraphApi {
  // Singleton instance
  static final GraphApi _repo = new GraphApi._();

  // Singleton accessor
  static GraphApi get instance => _repo;

  // A private constructor. Allows us to create instances of Repository
  // only from within the Repository class itself.
  GraphApi._();

//  static String login = """mutation (\$email:String!,\$password:String!){
//  Login(email:\$email,password:\$password){
//    	code
//    	success
//    	message
//    	token
//    	user{
//        firstname
//        lastname
//        email
//        role
//        createdAt
//        isEmailVarified
//        role
//        avater
//      }
//  }
//}
//""";

  String login(String email, String password) {
    return """mutation {
  Login(email:"$email",password:"$password"){
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

  String feachFeature() {
    return """
     query {
        FetchFeature(limit:100,offset:0){
          code
          message
          count
          hasNext
            result{
                id
                price
                desc
                img
            }
        }
}
    """;
  }
}
