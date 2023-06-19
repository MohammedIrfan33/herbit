from django.shortcuts import render
from django.conf import settings
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from .models import testing
from .serializers import PlantDetectionSerializer
import io

from django.http import JsonResponse
from keras.models import load_model
from PIL import Image, ImageOps
import numpy as np

# Create your views here.
class PlantDetectionSerializerAPIView(GenericAPIView):
    serializer_class = PlantDetectionSerializer

    def post(self, request):
        # Load the model
        model = load_model("Medical_model.h5", compile=False)

        # Load the labels
        class_names = open("labels.txt", "r").readlines()

        # Create the array of the right shape to feed into the keras model
        # The 'length' or number of images you can put into the array is
        # determined by the first position in the shape tuple, in this case 1
        data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)

        # Get the image from the request
        image = Image.open(request.FILES['image']).convert("RGB")

        # resizing the image to be at least 224x224 and then cropping from the center
        size = (224, 224)
        image = ImageOps.fit(image, size, Image.Resampling.LANCZOS)

        # turn the image into a numpy array
        image_array = np.asarray(image)

        # Normalize the image
        normalized_image_array = (image_array.astype(np.float32) / 127.5) - 1

        # Load the image into the array
        data[0] = normalized_image_array

        # Predict the model
        prediction = model.predict(data)
        index = np.argmax(prediction)
        class_name = class_names[index]
        print(class_name)
        confidence_score = prediction[0][index]

        if class_name == "Tulsi\n":
            usage = "ulsi's broad-spectrum antimicrobial activity, which includes activity against a range of human and animal pathogens, suggests it can be used as a hand sanitizer, mouthwash and water purifier as well as in animal rearing, wound healing, the preservation of food stuffs and herbal raw materials and traveler's health."

        elif class_name == "Curry\n":
            usage = "Curry leaves (Murraya koenigii) or sweet neem leaves are extensively used in India for culinary and medicinal purposes."

        elif class_name == "Drumstick\n":
            usage = "Drumstick leaves are rich in antioxidants, such as vitamin C and beta-carotene, which protect us from many chronic oxidative diseases, including heart diseases, diabetes, cancer, and Alzheimer's disease."

        elif class_name == "Mint\n":
            usage = "Mint leaves create a cool sensation in the mouth. Toothpaste, mouthwash, breath mints, and chewing gum are all commonly flavored with mint."

        elif class_name == "Mango\n":
            usage = "Mango leaves have antibacterial properties that help treat bacterial skin infections such as staph Infections and skin burns."

        elif class_name == "Lemon\n":
            usage = "Lemon leaves can be wrapped around seafood and meats and can be roasted, steamed, or grilled."

        elif class_name == "Indian Mustard\n ":
            usage = "May help boost immunity- Mustard leaves are loaded with vitamin C that plays a major role in boosting immunity."

        elif class_name == "Neem\n":
            usage = "All parts of the neem tree- leaves, flowers, seeds, fruits, roots and bark have been used traditionally for the treatment of inflammation, infections, fever, skin diseases and dental disorders."

        elif class_name == "Jackfruit\n":
            usage = "It is a very effective anti-ageing herb since it slows down skin cell ageing, helps the skin regenerate, and makes the skin appear younger. It is a good source of calcium and vitamin A, both of which are crucial for youthful eye health and strong, healthy bones."

        elif class_name =="Rasna\n":
            usage = "Laden with plant-based compounds that showcase strong Ushna i.e. heat-inducing nature and Kapha dosha balancing qualities, rasna is useful in resolving respiratory issues of cough, cold, wheezing, bronchitis, asthma."

        else:
            usage = "Invalid"


        # Return the prediction result as JSON
        response_data = {
            'class_name': class_name[2:],
            'confidence_score': confidence_score,
            'usage':usage
        }
        return Response({'data':response_data,'message':'Medical Plant Detected successfully', 'success':True}, status = status.HTTP_201_CREATED)

  

# Create your views here.
