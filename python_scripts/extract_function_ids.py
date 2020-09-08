import re
import pickle
import os



def extrac_code(file_path, classids, save_path):
    f  = open(file_path).read()
    
    save_list = []
    for i in map(str, classids):
        p = r'[\s\S]*?(<class classid="{}"[\s\S]*?<\/class>)[\s\S]*'.format(i)
        cs = re.findall(p, f, re.MULTILINE)
        p = r'[\s\S]*?<source[\s\S]*?(function[\s\S]*?)\{[\s\S]*<\/source>[\s\S]*?'
        all_fs = re.findall(p, cs[0], re.MULTILINE)
        if len(all_fs)==0:
            print(cs)
        save_list.append(all_fs)

    pickle.dump(save_list, open(save_path, 'wb'))

def get_classids(file_path)->int:
    a = open(file_path).read()
    b = re.findall('.*?classid="(\d+)".*', a)

    return b

def extract_functions_ids(config):
    original_paths = ['type-1', 'type-2', 'type-2c', 'type-3-1', 'type-3-2', 'type-3-2c']
    # file_path = 'duplicates/originals/2c.xml'
    #classids = ['1', '5', '7', '9', '11', '17', '19', '24', '30', '32', '35', '42', '49', '61', '62', '87', '90', '93', '94'] 
    # save_path = 'duplicates/code-filterGed/2c.p'
# extrac_code(file_path, classids, save_path)
    
    # classids = get_classids('duplicates/final/'+original_paths[0])
    # file_path = 'duplicates/originals/3.xml'
    # save_path_pickle = 'duplicates/code-filtered/3.p'
    # extrac_code(file_path, classids, save_path_pickle)
    
    # save_path_txt = open('duplicates/code-filtered/3.txt', 'w')
    # functions = pickle.load(open(save_path_pickle, 'rb'))

    # for f in functions:
    #     save_path_txt.write('function '+f[0]+'\n')        

    # classids = get_classids('duplicates/final/'+original_paths[1])
    # file_path = 'duplicates/originals/3b.xml'
    # save_path_pickle = 'duplicates/code-filtered/3b.p'
    # extrac_code(file_path, classids, save_path_pickle)
    
    # save_path_txt = open('duplicates/code-filtered/3b.txt', 'w')
    # functions = pickle.load(open(save_path_pickle, 'rb'))

    # for f in functions:
    #     save_path_txt.write('function '+f[0]+'\n')     


    # classids = get_classids('duplicates/final/'+original_paths[2])
    # file_path = 'duplicates/originals/3c.xml'
    # save_path_pickle = 'duplicates/code-filtered/3c.p'
    # extrac_code(file_path, classids, save_path_pickle)
    
    # save_path_txt = open('duplicates/code-filtered/3c.txt', 'w')
    # functions = pickle.load(open(save_path_pickle, 'rb'))

    # for f in functions:
    #     save_path_txt.write('function '+f[0]+'\n') 


    os.makedirs('duplicates/code-filtered', exist_ok=True)
    os.makedirs('duplicates/function-ids', exist_ok=True)
    for filepath in original_paths:
        classids = get_classids('duplicates/final/'+filepath+".xml")
        complete_file_path = 'data/{}/withsource/{}'.format(config, filepath+'.xml')
        save_path_pickle = 'duplicates/function-ids/{}'.format(filepath+'.p')
        extrac_code(complete_file_path, classids, save_path_pickle)
       
        save_path_txt = open('duplicates/function-ids/{}'.format(filepath+'.txt'), 'w')
        functions = pickle.load(open(save_path_pickle, 'rb'))

        for f in functions:
            save_path_txt.write(f[0]+'\n') 

        print('done', len(classids), len(functions))

if __name__ == "__main__":
    extract_functions_ids('min5')
    print('done')