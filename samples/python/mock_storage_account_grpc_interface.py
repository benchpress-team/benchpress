class Response():
    def __init__(self) -> None:
        self.SUCCESS = False
        self.a = None
        self.b = None
        self.c = None
        pass

def create(resource_group: str, params: dict) -> Response:
    if resource_group and params:
        response = Response()
        response.SUCCESS = True
        return response
    return Response()