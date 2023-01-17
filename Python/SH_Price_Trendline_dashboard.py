#Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress
import pandas as pd
from datetime import datetime
import plotly.express as px
import seaborn as sns
import plotly.graph_objects as go
from plotnine import *
import streamlit as st
from plotnine import ggplot, geom_point, aes, stat_smooth, geom_line

#Importing the dataset
df = pd.read_excel(r'C:\Users\admin\OneDrive\Desktop\Prajesh\Office\datasets\Book2_excel.xlsx')

#Filtering only the required columns
df2 = df[["Section","Display_Price_Per_Ticket_Amount","Transaction_Date"]]

#Sorting by date
df3 = df2.sort_values(by = "Transaction_Date")

#Finding the mean price of ticket in a section per date
df4 = df3.groupby(['Section','Transaction_Date'],as_index =  False)['Display_Price_Per_Ticket_Amount'].mean()

#Heading
st.title("Trend Visualisation for Price of tickets")

#Selecting the section
section = st.sidebar.multiselect('Select a Sections',list(df4.Section.unique()))

#Start date
start_date = st.sidebar.date_input('Select the Start date',value =pd.to_datetime("2021-03-23", format="%Y-%m-%d") ,min_value = pd.to_datetime("2021-03-23", format="%Y-%m-%d"),max_value=pd.to_datetime("2021-05-10", format="%Y-%m-%d"))

#End date
end_date = st.sidebar.date_input('Select the End date',value =pd.to_datetime("2021-03-23", format="%Y-%m-%d") ,min_value = pd.to_datetime("2021-03-23", format="%Y-%m-%d"),max_value=pd.to_datetime("2021-05-10", format="%Y-%m-%d"))

#Converting the date as string
start = start_date.strftime("%Y-%m-%d")
end = end_date.strftime("%Y-%m-%d")

#Filtering with the input date
df5 = df4.loc[(df4["Transaction_Date"]>= start)&(df4["Transaction_Date"]<= end)]

#Filtering with input sections
names = section
df6 = df5[df5.Section.isin(names)]

#Ploting the graph
trend = (ggplot(df6, aes("Transaction_Date", "Display_Price_Per_Ticket_Amount", color="Section"))
 +  geom_line()
 +  stat_smooth(method="lm")
 + labs(y = "Price", x = "Date"))

#Displaying the graph
st.pyplot(ggplot.draw(trend))

