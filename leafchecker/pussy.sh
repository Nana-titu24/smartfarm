#!/bin/bash

# Check if virtual environment directory exists
if [ ! -d "venv" ]; then
  # Create a virtual environment
  python3 -m venv venv
  echo "Virtual environment created."
else
  echo "Virtual environment already exists."
fi

# Activate the virtual environment
source venv/bin/activate
echo "Virtual environment activated."

# Check if requirements.txt exists
if [ -f "requirements.txt" ]; then
  # Install the requirements
  pip install -r requirements.txt
  echo "Requirements installed."
else
  echo "requirements.txt not found."
fi

# Check if app.py exists
if [ -f "app.py" ]; then
  # Run the app.py script
  python3 app.py
  echo "app.py script executed."
else
  echo "app.py not found."
fi
