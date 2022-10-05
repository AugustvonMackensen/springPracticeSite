import os
import sys
import io
import re
from google.cloud import vision # 업그레이드로 인해 type 굳이 입력할 필요 없음

def image_to_text(googleJson, img):
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.path.abspath(googleJson)
    client = vision.ImageAnnotatorClient()
    # image 폴더 아래에 있는 이미지 파일 이름을 불러오기
    path = os.path.abspath(img)

    # Loads the image into memory
    with io.open(path, 'rb') as image_file:
        content = image_file.read()

    image = vision.Image(content=content)
    response = client.text_detection(image=image)
    annotations = response.text_annotations

    if(len(annotations) > 0):
        text = annotations[0].description
    else:
        text = ""

    text_lst = text.splitlines()
    # text_lst = [word for word in text_lst if len(word) != 0]
    for idx in text_lst:
        mail_value = re.search('^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$', idx)
        if mail_value is not None:
            if idx.find('E-mail:'):
                print(idx.replace('E-mail:', ''))
            else:
                print(idx)


if __name__ == '__main__':

    googleJson = sys.argv[1]
    img = sys.argv[2]
    
    image_to_text(googleJson, img)