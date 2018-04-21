library(mlr)
library(dplyr)

set.seed(15390)

dat <- read.csv(file = "mieszkania_mlr.csv", encoding = "UTF-8")

predict_affordable <- makeClassifTask(id = "affordableApartments", 
                                      data = dat, target = "tanie")

all_learners <- listLearners()
listLearners("classif", properties = c("prob"))[1L:3, 1L:3]

learnerRF <- makeLearner("classif.randomForest", predict.type = "prob")
learnerNN <- makeLearner("classif.nnet", predict.type = "prob")

cv_scheme <- makeResampleDesc("CV", iters = 5, stratify = TRUE)

resample(learnerNN, predict_affordable, cv_scheme, measures = list(auc))

# 1. Przeprowadź walidację krzyżową learnerRF (3-krotna walidacja krzyżowa)
# 2. Sprawadź inne metody walidacji modelu, np. makeResampleDesc("Holdout", split = 1/2, stratify = TRUE)
# 3. Przewidź cenę mieszkania (regr.randomForest)

bench_affordable <- benchmark(learners = list(learnerRF, learnerNN),
                              tasks = predict_affordable,
                              resamplings = cv_scheme, 
                              measures = list(auc, acc))

plotBMRBoxplots(bench_affordable, auc)

model_rf <- train(learnerRF, predict_affordable, subset = 1L:5000)
#save(model_rf, file = "./cz2_shiny/model_rf.RData")

preds <- predict(model_rf, predict_affordable, subset = 5001L:5853)

calculateROCMeasures(preds)

# cz. 2 - strojenie ------------------------------------------------------------

getParamSet("classif.nnet")
getParamSet("classif.randomForest")

makeLearner("classif.nnet", predict.type = "prob", size = 5, decay = 0.2)


parameters_set <- makeParamSet(
  makeIntegerParam("size", lower = 1, upper = 15),
  makeNumericParam("decay", -5, 5, trafo = function(x) 2^x)
)

library(mlrMBO)

mbo_ctrl <- makeTuneControlMBO(mbo.control = setMBOControlTermination(makeMBOControl(), iters = 2))
optimal_nnet <- tuneParams(makeLearner("classif.nnet", predict.type = "prob"), predict_affordable, cv_scheme, 
                           par.set = parameters_set, measures = list(auc), control = mbo_ctrl, 
                           show.info = FALSE)

optimal_nnet <- mbo(nnet_function, control = mbo_ctrl, show.info = FALSE)

getOptPathY(optimal_nnet[["opt.path"]])

benchmark(learners = list(makeLearner("classif.nnet", id = "nonoptimal", predict.type = "prob"), 
                          makeLearner("classif.nnet", id = "optimal", predict.type = "prob", par.vals = optimal_nnet[["x"]]),
                          makeLearner("classif.randomForest", predict.type = "prob")),
          tasks = predict_affordable,
          resamplings = cv_scheme, 
          measures = list(auc))
