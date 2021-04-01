# Google Kubernetes Engine app authentication example
A sample rack application deployed to Google Kubernetes Engine (GKE). To demonstrate how Google Cloud Endpoints can be used to implement API key based authentication for the backend.

## Routing flow:
![routing_flow][routing_flow]

[routing_flow]: https://github.com/ajazfarhad/gke_app_authentication_example/raw/master/routing_flow.png "Routing Flow"

## Running in Production
If you already have cluster setup you can push your app image to the container registery.

```gcloud builds submit -t gcr.io/PROJECT-ID/rack-app```

And deploy that to GKE using ```deployment.yml``` file. You need to setup a new Cloud Endpoint and configure service account roles for ESP. Instructions are given in the following link.
https://cloud.google.com/endpoints/docs/openapi/get-started-kubernetes-engine

Sample application reads two paths.

`/` (root path)
`/hello` (authentication is applied on this path using API_KEY)

Once everyting is running you can make the following request.

```curl "http://IP_ADDRESS:80/hello"```

You should be able to see the following message.

```json
{
   "message":"UNAUTHENTICATED:Method doesn't allow unregistered callers (callers without established identity). Please use API Key or other form of API consumer identity to call this API.",
   "code":401
}
```

Now generate an api key from API & Services section in the console or use an existing one. Call the endpoint again.

```curl "http://IP_ADDRESS:80/hello?key=${API_KEY}"```

It should authenticate successfully and respond.

```{"message":"Hello World! - 127.0.0.1"}```
