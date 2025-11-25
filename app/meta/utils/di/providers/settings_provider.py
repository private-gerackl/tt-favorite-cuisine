from dishka import provide, Scope, Provider

from app.meta.settings import EnvSettings, AppSettings


class SettingsProvider(Provider):
    @provide(scope=Scope.APP)
    def get_env_settings(
        self,
    ) -> EnvSettings:
        return EnvSettings()

    @provide(scope=Scope.REQUEST)
    def get_app_settings(
        self,
    ) -> AppSettings:
        return AppSettings()
