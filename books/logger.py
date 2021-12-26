from pydantic import BaseModel
from logging.config import dictConfig
import logging


class LogConfig(BaseModel):

    LOGGER_NAME: str = "app"
    LOG_FORMAT: str = "%(levelprefix)s | %(asctime)s | %(message)s"
    LOG_LEVEL: str = "DEBUG"

    version = 1
    disable_existing_loggers = False
    formatters = {
        "default": {
            "()": "uvicorn.logging.DefaultFormatter",
            "fmt": LOG_FORMAT,
            "datefmt": "%Y-%m-%d %H:%M:%S",
        },
    }
    handlers = {
        "default": {
            "formatter": "default",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stderr",
        },
    }
    loggers = {
        "app": {"handlers": ["default"], "level": LOG_LEVEL},
        "uvicorn": {"handlers": ["default"], "level": LOG_LEVEL},
    }


def _setup_logging():
    dictConfig(LogConfig().dict())
    logger = logging.getLogger()
    return logger
