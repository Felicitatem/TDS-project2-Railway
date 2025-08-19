# Use Python 3.12 slim
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies first for caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app source code
COPY main.py .
COPY gemini.py .
COPY task_engine.py .
COPY api_key_rotator.py .
COPY frontend.html .
COPY entrypoint.sh .

# Make entrypoint executable
RUN chmod +x entrypoint.sh

# Copy environment files (optional, for local dev)
COPY .env* ./

# Expose port (optional but recommended)
EXPOSE 8000

# Default command
CMD ["./entrypoint.sh"]
