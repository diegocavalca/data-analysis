#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Aug  5 16:02:30 2017
Updated on Sat Apr  6 14:28:42 2019

@author: diegocavalca
"""

from flask import Flask, render_template, request
from wtforms import Form, TextAreaField, validators
import pickle
import os
import numpy as np

from sklearn import metrics
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
import nltk
nltk.download('punkt')

######## PREPARANDO O CLASSIFICADOR / VECTORIZADOR ########
cur_dir = os.path.dirname(__file__)

# Tokenizer
def tokenizer(text):
    source = text.lower()
    source = nltk.word_tokenize(source)
    return source

# Stop words
with open(os.path.join(cur_dir, '../resources/stopwords.txt'), 'r', encoding='utf-8') as infile:
    stopwords = infile.read().splitlines()

# Vetorizador
with open(os.path.join(cur_dir, '../resources/vectorizer.pkl'), 'rb') as fid:
   vec = pickle.load(fid)

# Classificador
with open(os.path.join(cur_dir, '../resources/classifier.pkl'), 'rb') as fid:
    clf = pickle.load(fid)

######## PREPARANDO O CLASSIFICADOR / VECTORIZADOR ########   

def classify(lyric):
	label = {'bossa_nova': 'Bossa Nova', 'funk': 'Funk', 'gospel': 'Gospel', 'sertanejo': 'Sertanejo'}
	X = vec.transform([lyric])
	y = clf.predict(X)[0]
	proba = np.max(clf.predict_proba(X))
	return label[y], proba

app = Flask(__name__) 

class LyricForm(Form):
	musiclyric = TextAreaField('',
					[validators.DataRequired(), validators.length(min=15)])

@app.route('/')
def index():
	form = LyricForm(request.form)
	return render_template('index.html', form=form)

@app.route('/result', methods=['POST'])
def results():
	form = LyricForm(request.form)
	if request.method == 'POST' and form.validate():
		lyric = request.form['musiclyric']
		y, proba = classify(lyric)
		return render_template('result.html',
	content=lyric,
	prediction=y,
	probability=round(proba*100, 2))
	return render_template('index.html', form=form)

if __name__ == '__main__':
	app.run()