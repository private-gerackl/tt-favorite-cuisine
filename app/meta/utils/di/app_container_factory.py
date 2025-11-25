from dishka import Provider, make_async_container, AsyncContainer
from dishka.integrations.fastapi import FastapiProvider

from app.meta.utils.di.providers.fastapi_service_provider import FastAPIServiceProvider
from app.meta.utils.di.providers.settings_provider import SettingsProvider
from app.meta.utils.di.providers.uvicorn_server_provider import UvicornServerProvider


class AppContainerFactory:
    @classmethod
    def build(
        cls,
    ) -> AsyncContainer:
        return make_async_container(*cls.get_providers())

    @classmethod
    def get_providers(
        cls,
    ) -> list[Provider]:
        return [
            # Custom
            SettingsProvider(),
            FastAPIServiceProvider(),
            UvicornServerProvider(),
            # System
            FastapiProvider(),
        ]
