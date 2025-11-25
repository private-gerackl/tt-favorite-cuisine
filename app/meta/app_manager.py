from dishka import AsyncContainer
from dishka.integrations.fastapi import setup_dishka
from fastapi import FastAPI
from uvicorn import Server


class AppManager:

    def __init__(
        self,
        app_container: AsyncContainer,
    ):
        self._app_container = app_container

    async def run(
        self,
    ) -> None:
        setup_dishka(
            container=self._app_container,
            app=await self._app_container.get(FastAPI),
        )
        uvicorn_server = await self._app_container.get(Server)
        await uvicorn_server.serve()
