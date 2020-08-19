class GraphApi {
  // Singleton instance
  static final GraphApi _repo = new GraphApi._();

  // Singleton accessor
  static GraphApi get instance => _repo;

  GraphApi._();

  String forgetPassword(String email) {
    return """mutation {
  ForgetPassword(email:"$email"){
    code
    success
    message
  }
}
""";
  }

  String login(String email, String password, bool isBusiness) {
    return """mutation {
  Login(email:"$email",password:"$password", isBusiness:$isBusiness){
    	code
    	success
    	message
    	token
      user{
          _id
          firstname
          lastname
          mobile
          avater
          role
          uniqueId
          updatedAt
          isEmailVarified
          createdAt
          shopper{
            spendLimit
            availableBalance
            cards{
              _id
              exp_month
              exp_year
            }
          }
          business{
            bankName
            bankNumber
            verificationImg
          }
          email
          address
          status
    }
  }
}
""";
  }

  String register(dynamic userInput) {
    print(userInput);
    return """mutation{
  Register(userInput:$userInput){
    code
    success
    message
  }
}
""";
  }

  String feachFeature() {
    return """
    query{
        FetchFeature(limit:100,offset:0){
            code
            message
            count
            success
            hasNext 
            result{
                id
                price
                desc
                title
                img
                link
            }
        }
    }
    """;
  }

  //=====================Card===========//

  String addCard(String reference) {
    return """mutation {
  AddCard(reference:"$reference"){
    code
    success
    message
  }
}
""";
  }

  String fetchCards() {
    return """
   query{
  FetchCard{
    code
    message
    count
    result{
      _id
      exp_month
      exp_year
      card_type
      last4
      preferred
    }
  }
}
    """;
  }

  //========= Shopper ========//
  String upcomingPayments() {
    return """
 query{
  FetchOrder(limit:100,offset:0){
    code
    message
    count
    hasNext
    success
    result{
      orderId
      title
      attachment
      note
      shippingAddress
      createdAt
      desc
      quantity
      totalLateFee
      business{
        business{
          businessName
        }
      }
      amount
      status
      type
      isRequested
      authorizationCode
      currency
      transactions{
        _id
        transactionId
        status
        installment
        createdAt
        paymentDate
        reference
        isRequested
        createdAt
      }
  
    }
  }
}
    """;
  }

  //===============Transactions

  String fetchTransactions() {
    return """
 query {
  FetchTransaction(limit:100,offset:0,){
    code
    message
    success
    result{
      _id
      transactionId
      reference
      status
      installment
      paymentDate
      createdAt
      order{
        createdAt
        orderId
        attachment
        title
        note
        shippingAddress
        desc
        quantity
        amount
        status
        createdAt
        totalLateFee
        currency
        authorizationCode
        orderId
        isRequested
        type
      }
    }
  }
}
    """;
  }
}
