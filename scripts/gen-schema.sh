#!/bin/sh

npx get-graphql-schema http://localhost:8000/graphql > lib/graphql/your_app.schema.graphql

dart run build_runner build --delete-conflicting-outputs