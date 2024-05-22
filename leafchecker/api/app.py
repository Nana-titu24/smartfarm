from flask import Flask, request, jsonify
from PIL import Image
import numpy as np

app = Flask(__name__)

# Function to check for yellow color in the image
def check_for_yellow(image):
    # Convert image to numpy array
    img_array = np.array(image)
    # Convert RGB to HSV color space
    hsv_img = np.array(Image.fromarray(img_array).convert('HSV'))
    # Define range for yellow color in HSV
    lower_yellow = np.array([20, 100, 100])
    upper_yellow = np.array([30, 255, 255])
    # Create a mask for yellow color
    mask = cv2.inRange(hsv_img, lower_yellow, upper_yellow)
    # Count non-zero pixels in the mask
    yellow_pixels = np.count_nonzero(mask)
    return yellow_pixels > 0

# Flask route to handle image uploads
@app.route('/check', methods=['POST'])
def check_color():
    if 'image' not in request.files:
        return jsonify({'error': 'No image found'}), 400

    image_file = request.files['image']
    if image_file.filename == '':
        return jsonify({'error': 'No image selected'}), 400

    try:
        image = Image.open(image_file)
    except Exception as e:
        return jsonify({'error': str(e)}), 400

    # Check for yellow color in the image
    is_yellow_present = check_for_yellow(image)

    if is_yellow_present:
        return jsonify({'message': 'Yellow color present'})
    else:
        return jsonify({'message': 'Healthy'})

if __name__ == '__main__':
    # Specify IP address and port
    app.run(debug=True, host='0.0.0.0', port=5000)
