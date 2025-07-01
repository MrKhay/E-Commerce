# load environment variable
from dotenv import load_dotenv
import os

load_dotenv()


class Settings:
    def __init__(self):
        self.ACCESS_TOKEN_EXPIRE_TIME: int = 60 * 24 * 8

        self.DATABASE_URL = os.getenv("DATABASE_URL")
        self.BACKEND_CORS_ORIGINS = os.getenv("BACKEND_CORS_ORIGINS", "").split(",")
        self.PROJECT_NAME = os.getenv("PROJECT_NAME")
        self.API_V1_STR = os.getenv("API_V1_STR")
        self.SECRET_KEY = os.getenv("SECRET_KEY")
        self.SMTP_USER = os.getenv("SMTP_USER")
        self.SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")
        self.SMTP_PORT = os.getenv("SMTP_PORT")
        self.EMAILS_FROM_EMAIL = os.getenv("EMAILS_FROM_EMAIL")
        self.SMTP_HOST = os.getenv("SMTP_HOST")
        self.USE_CREDENTIALS = os.getenv("USE_CREDENTIALS")
        self.SMTP_STARTTLS = os.getenv("SMTP_STARTTLS")
        self.SMTP_SSL_TLS = os.getenv("SMTP_SSL_TLS")

        class config:
            env_file = ".env"


settings = Settings()
