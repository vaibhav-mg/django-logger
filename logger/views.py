
# Create your views here.
from django.shortcuts import render
import logging,requests,random
from django.http import JsonResponse

# Create your views here.
logger = logging.getLogger(__name__)


def fetch_api():
    response = requests.get(random.choice(['https://random-data-api.com/api/v2/users', 'https://random-data-api.com/api/v2/beers']))
    print(response)
    if response.status_code == 200:
        return response.json()
    else:
        return None

def get_data(request):
    data = fetch_api()
    # print(data)
    if data:
        logger.info('API call successful: %s', data)
        return JsonResponse(data)
    else:
        logger.error('API call failed')
        return JsonResponse({'error': 'API call failed'}, status=500)

def infinite_data(request):
    i=0
    while i<pow(10,6):
        get_data(request)
