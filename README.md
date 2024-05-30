# Flutter & GraphQL with Authentication Tutorial.

## Place your Base URL

Global search on the project on VSCode or any IDE and replace the following with your base url.

http://localhost:8000/graphql

## Steps to download your graphql schema from the backend.

- Install packages from package.json file.
```bash
    yarn install
    
    # or
    
    npm install
```

- Give permission to run the script.
```bash
    chmod +x ./scripts/gen-schema.sh
```


- Run the script to download *your_app.schema.graphql*
 ```bash
    ./scripts/gen-schema.sh
```

- Run build_runner to convert graphql files from *lib/graphql/queries* to dart types.
```bash
    dart run build_runner build
```