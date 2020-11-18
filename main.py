from flask import Flask, render_template, request, session, redirect
from datetime import datetime
# from werkzeug import secure_filename
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  FileStorage
import os
import math
# From flask module we are importing FLASK class
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from bs4 import BeautifulSoup
import smtplib
import json
with open('config.json', 'r') as c:
    params=json.load(c)["params"]

app=Flask(__name__)
app.config['UPLOAD_FOLDER']= params['upload_location']
app.secret_key = 'super-secret-key'  #After using session this has been done.
local_server =True

if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri'] #login uri changes
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri'] #login uri changes
db = SQLAlchemy(app) #Initialisation



class Contacts(db.Model): #Table name jaisa rakha par first letter should be capital
    #sno, name, email, ph_num, mes, date
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), nullable=False)
    ph_num = db.Column(db.String(120), nullable=False)
    mes = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(120), nullable=False)

class Posts(db.Model): #Table name jaisa rakha par first letter should be capital
    #sno, title, slug, content, date
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    slug = db.Column(db.String(40), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    img_file = db.Column(db.String(20), nullable=False)
    date = db.Column(db.String(120), nullable=False)

@app.route("/")
def index():
    posts=Posts.query.filter_by().all()
    #[0:params['no_of_posts']] #isse index.html pe sirf 5 post hi aayenge maximum
    last= math.ceil(len(posts)/int(params['no_of_posts']))
    page=request.args.get('page')
    print(f"This is the page variable {page}")
    if(not str(page).isnumeric()):
        page=1
    page=int(page)
    posts=posts[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts']) + int(params['no_of_posts'])]
    if (page==1):
        prev="#"
        next="/?page="+ str(page+1)
    elif(page==last):
        prev="/?page="+ str(page-1)
        next="#"
    else:
        next = "/?page=" + str(page + 1)
        prev = "/?page=" + str(page - 1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if ('user' in session and session['user']==params['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method=="POST":
        username=request.form.get('uname')
        userpass=request.form.get('pass')
        if username==params['admin_user'] and userpass==params['admin_password']:
            #SET THE SESSION VARIABLE
            session['user'] = username
            posts=Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    else:
        return render_template('login.html', params=params)

@app.route("/post") #ye iska html waala naam h jo ki index.html file mein change karna hoga
def post():
    post = Posts.query.filter_by(sno=1).first()
    return render_template('post.html', params=params, post=post)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post=Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post) #post=post pass karne ke baad ab hum bootstrap pe jaate h sublime text mein to check hummara parameters whan pass h ke nhi

@app.route("/about") #ye iska html waala naam h jo ki index.html file mein change karna hoga
def about():
    return render_template('about.html', params=params)

@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method=='POST':
            box_title= request.form.get('TITLE')
            tagline=request.form.get('TAGLINE')
            slug=request.form.get('SLUG')
            content=request.form.get('CONTENT')
            img_file=request.form.get('IMGFILE')
            date=datetime.now()

            if sno=='0': #you can add any post from /edit/0
                post=Posts(title=box_title, tagline=tagline, slug=slug, content=content, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post=Posts.query.filter_by(sno=sno).first()
                post.title= box_title
                post.slug=slug
                post.tagline=tagline
                post.img_file=img_file
                post.date=date
                post.content=content
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post)

@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post=Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


def send_mail(namep, emailp, phonenump, messagep):
    server= smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login('hmntkpr723@gmail.com', 'XXXXX')
    subject='New Message from blog!!'
    body=f"{messagep}+ '\n' {phonenump}"
    msg=f"Subject: {subject}\n\n {body}"
    server.sendmail(
         f"{emailp}",
         'hmntkpr723@gmail.com',
         msg
    )
    print("THE EMAIL IS SENT")
    server.quit()

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user']==params['admin_user']):
        if (request.method=='POST'):
            f= request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)  ))
            return "UPloaded Successfully."

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/contact", methods=['GET', 'POST']) #ye iska html waala naam h jo ki index.html file mein change karna hoga
def contact():
    if (request.method=='POST'):
        '''Add Entry to the database'''
        namep=request.form.get('NAME') #Right names are defined in HTML and we are getiing with the names defined in contact.html
        emailp=request.form.get('EMAIL')
        phonenump=request.form.get('PHONENUM')
        messagep=request.form.get('MSG')
        # sno, name, email, ph_num, mes,  date
        entry=Contacts(name=namep, email=emailp, ph_num=phonenump, mes=messagep, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        send_mail(namep, emailp, phonenump, messagep)
    return render_template('contact.html', params=params)





app.run(debug=True) #For dynamic changes