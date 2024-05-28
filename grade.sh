CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'


rm -rf student-submission
rm -rf grading-area


mkdir grading-area

# step 1: clone the student's repo

git clone $1 student-submission
echo 'Finished cloning'

# step 2 check that the student code contains ListExamples.java
if [ -f student-submission/ListExamples.java ]; then
    echo "File Existed"
else
    echo "ListExamples.java does not exist"
    echo "Grade: 0"
    exit 1
fi

# step 3: put all relevant files in the grading-area directory
# ListExamples.java, TestListExamples.java, lib directory


cp student-submission/ListExamples.java TestListExamples.java grading-area
cp -r lib grading-area


# step 4: Compile tha java files and check that they compiled successfully
cd grading-area
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" ListExamples.java TestListExamples.java
echo "This is the exit code of javac: $?"


# step 5: Grade the student's code
touch output.txt
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > output.txt


tail -n 2 output.txt > output2.txt
LASTLINE=$(head -n 1 output2.txt)
echo "last line: " $LASTLINE


FAILS=$($LASTLINE | cut -d ' ' -f 5)
echo "num fails: " $FAILS
NUMTESTS=$($LASTLINE | cut -d ' ' -f 2)
echo "num tests: " $NUMTESTS
GRADE=`100 - ( $FAILS / $NUMTESTS ) * 100`
echo "Grade: " $GRADE


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point


# Then, add here code to compile and run, and do any post-processing of the
# tests


