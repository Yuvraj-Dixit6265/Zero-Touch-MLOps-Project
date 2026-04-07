from fastapi import FastAPI
import random

app = FastAPI()

@app.get("/")
def home():
    return {"message": "MLOps API is running 🚀"}

@app.get("/predict")
def predict():
    prediction = random.choice([0, 1])
    return {"prediction": prediction}