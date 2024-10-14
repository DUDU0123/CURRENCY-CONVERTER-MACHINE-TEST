class ApiEndPoints{
  static const apiUrl ="https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json";
  static const fallBackUrl ="https://latest.currency-api.pages.dev/v1/currencies/eur.json";
  static conversionEndPoint({required String fromCurrency}) => "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$fromCurrency.json";
}