import pandas as pd
import xml.etree.ElementTree as ET
import re
import pickle
def extract_total_functions(path):

    tree = ET.parse(path)

    root = tree.getroot()

    elements =[]
    for i, elem in enumerate(root):
        d={}
        d['startline'] = elem.attrib['startline']
        d['endline'] = elem.attrib['endline']

        d['lines'] = d['endline']-d['startline']
        elements.append(d)

    df = pd.DataFrame(elements)

    print(df.size)



def extract_total_functions_using_regex(path):
    xml = open(path).read()
    p = r'^<source file=[\s\S]*? startline=([\s\S]*?) endline=([\s\S]*?)\>[\s\S]*?<\/source>'
    sources = re.findall(p, xml, re.MULTILINE)

    df = pd.DataFrame(sources)
    df.columns = ['startline', 'endline']
    pickle.dump(df, open('all_functions.p', 'wb'))
    return len(sources)

if __name__=="__main__":

    path = "data/smart_contracts_functions.xml"
    # path = "data/min1/type-1.xml"
    print(extract_total_functions_using_regex(path))