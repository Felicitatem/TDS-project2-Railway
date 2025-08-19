#!/bin/sh

# Use PORT from Railway if set, else default to 8000
UVICORN_PORT=${PORT:-8000}

echo "Starting server on port $UVICORN_PORT..."

uvicorn main:app --host 0.0.0.0 --port $UVICORN_PORT
