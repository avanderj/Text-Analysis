#Wordcloud of Top 75 Words in Hamlet

#Set the working directory
<<<<<<< Updated upstream
setwd("~/Text-Analysis/")
=======
setwd("~/Desktop/Text-Analysis/")
>>>>>>> Stashed changes

#Call libraries used in the script
library(wordcloud)
library(tm)
library(RColorBrewer)

#Create a corpus -- this creates a wordcloud of the entire Shakesperean corpus
#corpus <- Corpus(DirSource("data/shakespeareFolger"))
# Hamlet Only
text_raw<-scan("data/shakespeareFolger/Hamlet.txt", what="character", sep="\n")

#Create corpus from Hamlet only 
corpus <- Corpus(VectorSource(text_raw))

#Clean the corpus
corpus <- tm_map(corpus, content_transformer(tolower))
#To change the stopword list, use other dictionaries available with the tm package
#Add early modern stopwords by u adding "myStopWords
myStopWords <- scan("data/earlyModernStopword.txt", what="character", sep="\n")
corpus <- tm_map(corpus, removeWords, c(stopwords("english"), myStopWords))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)

dtm <- DocumentTermMatrix(corpus)
freq <- sort(colSums(as.matrix(dtm)), decreasing = TRUE)
write.csv(freq, file = "~/Desktop/R/Text_AnalysisNotGIT/ShinyApps/HamletWordcloud/hamletFreq.csv")
write.csv(names(head(freq)), file="~/Desktop/R/Text_AnalysisNotGIT/ShinyApps/HamletWordcloud/hamletWords.csv")

wordcloud(corpus,random.order=FALSE,scale=c(4,1),rot.per=0,
          max.words=75,colors=brewer.pal(8, "Dark2"))

#plot(head(freq, 10), type="b", lwd=2, col="blue", col.lab="red", main="Lear, Entire Play", xlab="Top Ten Words", ylab="Number of Occurences", xaxt="n",)
#axis(1,1:10, cex=.5, labels=names(head(freq, 10)))
