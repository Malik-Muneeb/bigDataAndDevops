import sys


def readfile(file_name):
    """
    :param file_name: Name of file which is enter by user or use default
    :return: handle to iterate file
    """
    try:
        handle = open(file_name)
    except Exception as err:
        print("Incorrect File Name - ", err)
        sys.exit(0)
    return handle


def generate_sent(verbs, objects):
    """
    :param verbs: It contains list of verbs 
    :param objects: It contains list ob objects
    :return: 
    """
    sentence_list = list()
    for sub in handle:
        sub = sub.strip('\n')
        for veb in verbs:
            clause = sub + " " + veb
            for obj in objects:
                sentence_list.append(clause + " " + obj)
    return sentence_list



file_name = input("Enter Name of File or Press Enter Key: ")
if len(file_name) < 1:
    file_name = "subjects.txt"
handle = readfile(file_name)

verbs = ["Play", "Love"]
objects = ["Hockey", "Football"]

for sent in generate_sent(verbs, objects):
    print(sent)
