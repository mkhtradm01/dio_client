<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is a simplified implementation of (Dio)[https://pub.dev/dio]
it targets junior developers that need to quickly have http implementation in their 
applications.

## Features

This package has only four (4) methods for now, viz are:
1) getRequest
2) postRequest
3) updateRequest
4) deleteRequest

## Getting started

Kindly initialize the DioClient object with your baseUrl and start accessing the
methods. 

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
///[baseUrl]
const baseUrl = 'https://jsonplaceholder.typicode.com';
///[Dioclient] object instantiation
final dioClient = DioClient(baseUrl: baseUrl);
try{
    ///calling of the methods
    final response = await dioClient.getRequest(path: '/posts');
    if(response.statusCode == 200){
        debugPrint(response.data);
    }else{
        debugPrint(response.statusMessage);
    }
}on Exception catch(e){
    debugPrint('Error: $e');
}
```

## Additional information

TODO: This package will be improved from time to time. Contribution is highly welcomed, 
you can fork the repo and submit PR.
