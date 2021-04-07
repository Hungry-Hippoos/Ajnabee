from sentence_transformers import SentenceTransformer,util

def semantic_similarity_roberta(model,sentences1,sentences2):
        embeddings1 = model.encode(sentences1, convert_to_tensor=True)
        embeddings2 = model.encode(sentences2, convert_to_tensor=True)
        cosine_scores = util.pytorch_cos_sim(embeddings1, embeddings2)
        score = None
        for i in range(len(sentences1)):
            print("{} \t\t {} \t\t Score: {:.4f}".format(sentences1[i], sentences2[i], cosine_scores[i][i]))
            score = cosine_scores[i][i]
        if score <= 0.2767:
            return "Bad"
        elif score > 0.2767 and score < 0.5834:
            return "Average"
        else:
            return "Good"
