import os

ROOT_DIR = os.path.realpath(os.path.join(os.path.dirname(__file__), '..'))
MOVIE_NAMES = os.path.join(ROOT_DIR, 'config', 'movieNames.csv')
MOVIE_DATA = os.path.join(ROOT_DIR, 'output', 'movieData.xlsx')