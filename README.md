
# ABC Roasters API

This is a Ruby on Rails application that provides a mock API for querying and managing orders. It uses token-based authentication to secure API requests. The front-end can be implemented using React to interact with this API.

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Getting Started](#getting-started)
- [Authentication](#authentication)
- [API Endpoints](#api-endpoints)
- [Testing the API](#testing-the-api)
- [Running Tests](#running-tests)
- [Development Notes](#development-notes)

## Architecture Overview

### 1. **Authentication System**
   - The application uses a token-based authentication system. Users authenticate by providing an email and password to the `/auth/sign_in` endpoint, which returns an access token, client token, expiry timestamp, and uid. These tokens must be included in the headers of subsequent API requests.

### 2. **Order Management**
   - The `/orders/:id` endpoint allows clients to query order details by ID. The API returns detailed information about the order, including the delivery method, dispatch status, and order items.
   - Each request to the `/orders/:id` endpoint also returns a new set of tokens, which must be used for the next request, ensuring that tokens are always refreshed.

### 3. **Token Handling**
   - Tokens are generated using `SecureRandom` and are stored in the User model along with the client and expiry data. The `tokens` method in the User model provides a structured way to access these tokens.

### 4. **Security**
   - The application uses `bcrypt` for password hashing and secure storage. The `has_secure_password` method in Rails ensures that passwords are never stored in plain text.

## Getting Started

### Prerequisites

- Ruby version: 3.2.2
- Rails version: 7.x
- Node.js and Yarn for asset management
- PostgreSQL or SQLite (default) for the database

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/syedirtaza/flexnet
   cd flexnet
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Set up the database**:
   ```bash
   rails db:create db:migrate
   ```

4. **Start the Rails server**:
   ```bash
   rails server
   ```

5. **Run the test suite** (optional):
   ```bash
   rails test
   ```

### Authentication

The authentication flow works as follows:

1. **Sign In**:
   - Users authenticate via the `/api/v1/auth/sign_in` endpoint using their email and password.
   - If successful, the API responds with an `access-token`, `client`, `expiry`, and `uid`.

2. **Subsequent Requests**:
   - Include the `access-token`, `client`, `expiry`, and `uid` headers in all subsequent API requests to access secured endpoints like `/api/v1/orders/:id`.
   - Each successful request will return a new set of tokens that must be used in the next request.

### API Endpoints

#### **POST /api/v1/auth/sign_in**

- **Description**: Authenticates a user and returns authentication tokens.
- **Headers**: `Content-Type: application/json`
- **Body**:
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```
- **Response**:
  ```json
  {
    "access-token": "AHeY1zBQm2IxWZDTZyd_2Q",
    "token-type": "Bearer",
    "client": "LtIJ-gl8TPXh2LZw_dLS1A",
    "expiry": "1445562461",
    "uid": "user@example.com"
  }
  ```

#### **GET /api/v1/orders/:id**

- **Description**: Retrieves order details by ID. Requires authentication.
- **Headers**:
  - `access-token`: from the sign-in response
  - `client`: from the sign-in response
  - `expiry`: from the sign-in response
  - `uid`: from the sign-in response
  - `Content-Type`: `application/json`
- **Response**:
  ```json
  {
    "id": 119191,
    "location_id": 1,
    "company_id": 2229,
    "delivery_method": "StarTrack Express",
    "dispatched_consignment_note": "5IK12342132",
    "dispatched": 1,
    "order_items": [
      {
        "sku_id": "XASD-3011",
        "sku_code": "ASDFGHG-1000",
        "remote_order_item_id": "119191-1",
        "name": "The Big Bag - 1kg",
        "quantity": 16
      }
    ]
  }
  ```

### Testing the API

To test the API endpoints, you can use tools like Postman or curl:

1. **Sign In**:
   - Use Postman to make a `POST` request to `http://127.0.0.1:3000/api/v1/auth/sign_in` with the user's credentials.
   - Copy the tokens from the response.

2. **Access Orders**:
   - Make a `GET` request to `http://127.0.0.1:3000/api/v1/orders/:id` with the tokens included in the headers.

### Running Tests

The application includes a suite of tests to ensure that the code behaves as expected. These tests cover models, controllers, and various features of the application.

#### **Model Tests**

- **Validation Tests**: Ensure that models are validating data correctly, such as ensuring that a `User` cannot be saved without an email.
- **Method Tests**: Test custom methods in models, such as the `generate_tokens` method in the `User` model.

#### **Controller Tests**

- **Action Tests**: Verify that controller actions work as expected, including testing the `sign_in` action in the `AuthController` and the `show` action in the `OrdersController`.
- **Response Tests**: Ensure that the correct responses and status codes are returned.

#### Running the Tests

To run the tests, use the following command:

```bash
rails test
```

This command will execute all the tests in the `test` directory and display the results, including any failures or errors.

### Development Notes

- **Token Expiry**: Tokens are valid for one hour. After expiry, you'll need to re-authenticate to get a new set of tokens.
- **Security**: Ensure that the `bcrypt` gem is installed and being used to hash passwords.
- **Testing**: The application includes basic tests, but you should expand test coverage as the application grows.
- **Error Handling**: Custom error messages are returned for invalid credentials or expired tokens.

### Future Enhancements

- **Token Revocation**: Implement a mechanism to revoke tokens upon user logout.
- **Rate Limiting**: Consider adding rate limiting to prevent abuse of the authentication system.
- **Frontend Integration**: Build a React front-end to interact with this API, possibly using Redux for state management.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for review.
