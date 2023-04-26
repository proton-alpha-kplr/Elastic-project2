# Importer les bibliothèques 'json' et 'os'
import json
import os

# Définir le dossier où se trouvent les fichiers .json
directory = '/workspace/Elastic-Project/enwiki20201020/json'

# Pour chaque fichier dans le dossier :
for filename in os.listdir(directory):
    # Si le fichier se termine par .json :

    if filename.endswith(".json"):
        print("file : ", filename)

        # Ouvrir le fichier et Charger les données JSON à partir du fichier
        with open(os.path.join(directory, filename), "r") as f:
            json_data = json.load(f)

        # Créer une liste vide pour stocker les données à envoyer à Elasticsearch
        elasticData = []

        # Pour chaque document dans les données JSON :

        i=0
        for docJson in elasticData:
            # Créer une action de type "index" pour chaque document
            #action est un dictionnaire avec un dictionnaire en valeur
            action = '{"index":{ "id":'+i+'}}'
            i+=1
            # Ajouter l'action à la liste des données
            elasticData.append(json.dumps(action))
            # Ajouter le document à la liste des données
            elasticData.append(json.dumps(docJson))
            # Ajouter un caractère de nouvelle ligne à la fin de la requête
            elasticData.append('\n')
            
        # Écrire les données dans un fichier .ndjson
        with open(os.path.join(directory, filename) + '.ndjson', "w") as f:
            f.write('\n'.join(elasticData))

        print("modified file: ", filename)



