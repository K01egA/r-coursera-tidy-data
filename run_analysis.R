readData <- function(path, fsuffix) {
    fname <- file.path(path, paste0("y_", fsuffix, ".txt"))
    yData <- read.table(fname, header=F, col.names=c("ActivityId"))

    fname <- file.path(path, paste0("subject_", fsuffix, ".txt"))
    subjectData <- read.table(fname, header=F, col.names=c("SubjectId"))

    features <- read.table("features.txt", header=F, as.is=T, col.names=c("FeatureId", "FeatureName"))

    fname <- file.path(path, paste0("X_", fsuffix, ".txt"))
    data <- read.table(fname, header=F, col.names=features$FeatureName)

    # find requered features
    featuresSubset <- grep(".*mean\\(\\)|.*std\\(\\)", features$FeatureName)
    data <- data[, featuresSubset]

    # append ActivityId and SubjectId
    data$ActivityId <- yData$ActivityId
    data$SubjectId <- subjectData$SubjectId

    data
}

prepareMeanAndStdData <- function() {
    data <- rbind(readData("test", "test"), readData("train", "train"))
    features <- colnames(data)
    features <- gsub("\\.+mean\\.+", "Mean", features)
    features <- gsub("\\.+std\\.+", "Std", features)
    colnames(data) <- features
    data
}

appendActivityLabels <- function(data) {
    activityLabels <- read.table("activity_labels.txt", header=F, col.names=c("ActivityId", "ActivityName"))
    subset(merge(data, activityLabels), select=-ActivityId)
}

prepareTidyData <- function(rawData) {
    data <- sapply(split(rawData, list(rawData$ActivityId, rawData$SubjectId)), colMeans)
    data.frame(t(data), row.names=NULL)
}

prepareTidyData2 <- function(rawData) {
    library(reshape2)
    ids = c("ActivityId", "SubjectId")
    vars = setdiff(colnames(rawData), ids)
    meltedData <- melt(rawData, id=ids, measure.vars=vars)
    dcast(meltedData, ActivityId + SubjectId ~ variable, mean)
}

rawData <- prepareMeanAndStdData()
rawDataLabeled <- appendActivityLabels(rawData)

tidyData <- prepareTidyData(rawData)
tidyDataLabeled <- appendActivityLabels(tidyData)

write.table(tidyDataLabeled, "tidy.txt")
