 # Lab | Data manipulation and reporting in the cloud with data bricks #

- - - -

## Create a new cluster ##
First of all, we need to create a cluster to be able to run the queries. Without at least one cluster, we cannot run our code.

![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/02%20%20cluster.png "Cluster")

Databricks Cluster definition: _A Databricks cluster is a set of computation resources and configurations on which you run data engineering, data science, and data analytics workloads, such as production ETL pipelines, streaming analytics, ad-hoc analytics, and machine learning._

For creating a cluster, we have to go to the left column, to the plus symbol, and select create a cluster.
<br> <p align="center"> ![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/create%20cluster.png "Create Cluster") </p>

After select create a new cluster, it will appear a new blank page where we should fill the empty spaces with the required info (name, etc)
<br> <p align="center"> ![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/create%20cluster%202.png "New Cluster") </p>

When the cluster is ready to use, a full green circle will appear next to the name. 
<br> <p align="center"> ![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/cluster%20ready.png "Cluster Ready") </p>



## Import data ##
Next step is to import data into databricks from the local machine through the UI. We can do it from the databricks homepage, selecting the "import and explore data" (center)
<br> <p align="center"> ![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/import%20data.png "Import Data") </p>

Uploaded data can not be modified directly within Databricks. The only way is overwritting it. 

**Attention! Deleted data can not be recovered!**

After doing this all together in the class, we have to do three tutorials:
- Pandas to Koalas
- Spark SQL
- Market Basket

## Pandas to Koalas ##
The coding structure is very similar to the ones we already know 
<br> ![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/pandastokoalasplot.png "Import Data") 
![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/pandastokoalasplotbar.png "Import Data")


## Spark SQL ##
Using spark SQL is quite similar to mySQL so it's not difficult for us to use it. 
<br> <p align="center"> ![picture alt](https://github.com/GloriaiXIII/IronGloriai/blob/main/ironhack_week6/w6_labs/w6d5_lab_databricks/select%20query.png "Select Query") </p>

## Market Basket ##
This example was very fast to run in comparision to python taking in account the amount of data. 

- - - -

<p align="center"> Thank you for reading! </p>
