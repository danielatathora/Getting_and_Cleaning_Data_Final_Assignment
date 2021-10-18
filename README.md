## Assignment Analysis Details
 <br />
 <br />

### Read in X data (train and test)
<br />

### Read in y data (train and test)

    set the y data column name to be 'FeatureId' for readability
 <br />

### Read in subject data (train and test)
    set the subject data column name to be 'SubjectId' for readability
 <br />

### Load features file 
    Renames columns to "FeatureId", "Feature" for readability
 <br />
 <br />

### Exclude features except type mean, std 
 <br />
 <br />

### Get the sub-set of required features names
 <br />
 <br />

### Clean up Feature names 
     * Remove the round brackets
     * Add Capitals
     * Remove '-' 
     * Change the name part from BodyBody to Body
 <br />
 <br />

### Load Activity Labels
    Make columns more readable
 <br />
 <br />

### Filter the feature data for the required features 
 <br />
 <br />

### Set the feature data column names to be more readable
 <br />
 <br />

### Add the SubjectId column to the feature data-set
 <br />
 <br />

### Add the Activity column to the feature data-set
 <br />
 <br />

### Group data by SubjectId and Activity averaging the other columns.
  using the dplyr library 
 <br />
 <br />

### Write the results to result.txt
 <br />
