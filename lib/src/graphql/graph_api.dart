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
               billing{
          address
          city
          state
          postalCode
          country
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
     serviceFee{
      currency
      symbol
      serviceChargeFlat
      serviceChargePercentage
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

  String feachFeature(int limit, int offset) {
    return """
    query{
        FetchFeature(limit:$limit,offset:$offset){
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
  String upcomingPayments(int limit, offset) {
    return """
 query{
  FetchOrder(limit:$limit,offset:$offset){
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
      amount
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
      totalLateFee
      currency
      transactions{
        _id
        transactionId
        status
        installment
        createdAt
        paymentDate
        reference
        amount
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

  String payNow(String id) {
    return """mutation{
  Paynow(id:"$id"){
    code
    success
    message
  }
}
""";
  }

  String payLateFee(String id) {
    return """mutation{
  PayLateFee(orderId:"$id"){
    code
    success
    message
  }
}
""";
  }

  //===============Transactions

  String fetchTransactions(int limit, int offset) {
    return """
  query {
  FetchTransaction(limit:$limit,offset:$offset,){
    code
    message
    count
    success
    result{
      _id
      transactionId
      reference
      status
      installment
      paymentDate
      amount
      createdAt
      shopper{
        firstname
        lastname
        email
        _id
        
      }
      business{
        business{
          bankName
        	bankNumber
          businessName
        }
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
  String fetchPaymentreq(int limit, int offeset) {
    return """
query{
  FetchPaymentReq(limit:$limit,offset:$offeset){
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

  String fetchPaymentreqShopper() {
    return """
query{
  FetchPaymentReq(limit:100,offset:0,status:PENDING){
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

  String fetchPaymentreqCount() {
    return """
query{
  FetchPaymentReq(limit:100000,offset:0,status:PENDING){
    count
    success
  }
}
    """;
  }

  String acceptPaymentReq(String id) {
    return """mutation{
  AcceptPaymentReq(orderId:"$id"){
    code
    success
    message
  }
}
""";
  }

  String resolveBankAccount(String bankcode, String accountNumber) {
    return """mutation{
  ResolveBankAccount(bankCode:"$bankcode",accountNumber:"$accountNumber"){
    code
    message
    success
    accountHolderName
  }
}
""";
  }

  String uploadImage() {
    return r"""mutation ($file:Upload!) {
  SingleUpload(file:$file){
    imageLink
  }
}
""";
  }

  String createPaymentReq(dynamic paymentInput, dynamic paymentMethod) {
    return """mutation {
  CreatePaymentReq(paymentInput:$paymentInput,paymentMethod:$paymentMethod){
    code
    message
    success
    orderId
  }
}
""";
  }

  String createPaymentReqByShopper(
      String title, int amount, String type, String uniqueId) {
    return """mutation{
  CreatePaymentReqByShopper(title:"$title", amount:$amount,type:$type, uniqueId:"$uniqueId"){
    code
    message
    success
  }
}
""";
  }

  String rejectPaymentReq(String id) {
    return """mutation{
  RejectPaymentReq(orderId:"$id"){
    code
    success
    message
  }
}
""";
  }

  //=============Bank========//

  String withDrawBalance(int amount, String accountNumber, String bankCode) {
    return """mutation{
  WithdrawBalance(amount:$amount,accountNumber:"$accountNumber",bankCode:"$bankCode"){
    code
    success
    message
  }
}
""";
  }

  //=============Subscriptions=============//

  String paymentSubscription(String id) {
    print(id);
    return """subscription {
  NewPaymentReq(shopperId: "$id"){
    currency
    createdAt
    desc
    authorizationCode
    title
    orderId
    amount
  }
}
""";
  }

  //=============Serach Website============
  String searchWebsite(int limit, int offset, String searchText) {
    return """query {
  FetchSearchForShopper(limit:$limit,offset:$offset,searchText:"$searchText"){
    code
    message
    success
    count
    result{
      title
      img
      link
    }
  }
}
""";
  }

  String updateBilling(String address, String city, String state,
      String country, String postal) {
    return """mutation {
  UpdateBilling(
    address: "$address"
    city: "$city"
    state: "$state"
    country: "$country"
    postalCode: "$postal"
  ) {
    code
    message
    success
  }
}
""";
  }

  String fetchVCard() {
    return """
query {
  FetchVCard {
    success
    message
    count
    results {
      _id
      cardId
      amount
      cardNo
      currency
      currency
      cvv
      expiration
      expiry_year
      expiry_month
      createdAt
    }
  }
}
""";
  }

  String deleteVcard(String id) {
    return """mutation {
  DeleteVCard(cardId: "$id") {
    success
    message
    code
  }
}
""";
  }

  String addVcard(String currency, int amount) {
    return """mutation {
  AddVCard(currency: "$currency", amount: $amount) {
    success
    message
    result {
      _id
      amount
      cardNo
      currency
      currency
    }
  }
}
""";
  }

  String featchSettings() {
    return """
query {
  FetchSettings {
    code
    success
    exchangeRate {
      baseCurrency
      exchangeCurrency
      rate
    }
  }
}
    """;
  }
}
