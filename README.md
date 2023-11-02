# Basic Dart RESTful API Example

This is a simple example of a RESTful API server implemented in Dart using the Shelf package. It provides endpoints for creating, retrieving, and listing articles.

## Getting Started

To get started, follow these steps:

### Prerequisites

Make sure you have Dart installed on your system. You can download Dart from [dart.dev](https://dart.dev/).

### Installation

1. Clone this repository to your local machine:

   ```shell
   git clone https://github.com/yourusername/dart-restful-api.git
   ```

2. Change to the project directory:
   ```shell
   cd dart-restful-api
   ```
   
3. Run the server:
   ```shell
   dart run bin/server.dart
   ```
The server will start and listen on the default port 8080. You can change the port by setting the `PORT` environment variable.

## Usage

### Endpoints
- `GET /`: Returns a "Hello, World!" message.

- `GET /articles`: Returns a JSON list of articles.

- `POST /articles`: Creates a new article.

### Running Tests
You can run tests for the server by executing the following command:
```shell
dart test
```

### Contributing
Feel free to contribute to this project by creating issues or pull requests. Your contributions are welcome!
