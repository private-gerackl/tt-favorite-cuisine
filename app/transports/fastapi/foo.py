from dishka import FromDishka
from dishka.integrations.fastapi import DishkaRoute
from fastapi import APIRouter

from app.meta.settings import EnvSettings

router = APIRouter(route_class=DishkaRoute)

@router.get('/')
async def bar(
    env_settings: FromDishka[EnvSettings],
) -> EnvSettings:
    return env_settings
