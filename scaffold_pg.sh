#!/bin/bash

rm -rf model
dotnet ef dbcontext scaffold -o Model "Host=localhost;Username=test;Password=test" Npgsql.EntityFrameworkCore.PostgreSQL
