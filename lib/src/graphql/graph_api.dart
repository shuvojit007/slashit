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
            availableBalance
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

  String setPrefferdCard(String id) {
    return """mutation{
  SetPreferredCard(id:"$id"){
    success
    message
    code
  }
}
""";
  }

  String deleteCard(String id) {
    return """mutation{
  DeleteCard(id:"$id"){
    success
    message
    code
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

  String fetchUser() {
    return """
query{
  FetchUserById{
    code
    success
  
    user{
      firstname
      lastname
      email
      role
      avater
      shopper{
       availableBalance
        spendLimit
      }
    }
  }
}
    """;
  }

  //===============Transactions

  String fetchTransactions(int limit) {
    return """
 query {
  FetchTransaction(limit:$limit,offset:0,){
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
      shopper{
        firstname
        lastname
        email
        _id
      }
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

  String addMony(double amount) {
    return """mutation{
  RechargeWallet(amount:$amount){
    code
    success
    message
  
  }
}
""";
  }

  //=========Business===========//
  String fetchPaymentreq() {
    return """
query{
  FetchPaymentReq(limit:100,offset:0){
    code
    success
    count
    message
    result{
      id
      title
      note
      desc
      amount
      attachment
      orderId
    	createdAt
      status
      shopper{
        email
        firstname
        lastname
        mobile
        address
        avater
        role
      }
    }
  }
}
    """;
  }
}
