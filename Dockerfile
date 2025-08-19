# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies (can be useful for some Python libraries)
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# --- MODIFIED SECTION START ---

# Copy all application source files
COPY main.py .
COPY gemini.py .
COPY task_engine.py .
COPY api_key_rotator.py .
COPY frontend.html .

# Copy entrypoint script
COPY entrypoint.sh .

# --- MODIFIED SECTION END ---


# Copy environment file if it exists (for local builds)
# Note: For production, use managed environment variables instead.
COPY .env* ./

# Make entrypoint script executable
RUN chmod +x entrypoint.sh

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["./entrypoint.sh"]