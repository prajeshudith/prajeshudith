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
from statsmodels.tools.eval_measures import rmse
from sklearn.preprocessing import MinMaxScaler
from keras.preprocessing.sequence import TimeseriesGenerator
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers import Dropout
import warnings
warnings.filterwarnings("ignore")


##FOR SALES##
#Importing the dataset
df = pd.read_excel(r'C:\Users\admin\OneDrive\Desktop\Prajesh\Office\datasets\Book2_excel.xlsx')

#Filtering only the required columns
df2 = df[["Section","Quantity","Transaction_Date"]]

#Sorting by date
df3 = df2.sort_values(by = "Transaction_Date")

#Finding the total sales of ticket in a section per date
df4 = df3.groupby(['Section','Transaction_Date'],as_index =  False)['Quantity'].sum()

#Combing then Clubs
club_1 = df4[df4.Section == "Club Hall of Fame"]
club_2 = df4[df4.Section == "Club Main"]
club_3 = df4[df4.Section == "Club Mezzanine"]
club_4 = [club_1,club_2,club_3]
club_5 = pd.concat(club_4)

Club = club_5.groupby(['Transaction_Date'],as_index =  False)['Quantity'].sum()

Club["Section"] = "Overall Club"
Club = Club[["Section","Transaction_Date","Quantity"]]

#Combining the Floors
floor_1 = df4[df4.Section == "FN5"]
floor_2 = df4[df4.Section == "Floor FE"]
floor_3 = df4[df4.Section == "Floor FN"]
floor_4 = df4[df4.Section == "Floor FS"]
floor_5 = df4[df4.Section == "Floor FW"]
floor_6 = [floor_1,floor_2,floor_3,floor_4,floor_5]
floor_7 = pd.concat(floor_6)

Floor = floor_7.groupby(['Transaction_Date'],as_index =  False)['Quantity'].sum()

Floor["Section"] = "Overall Floor"
Floor = Floor[["Section","Transaction_Date","Quantity"]]

#Combing the Halls
hall_1 = df4[df4.Section == "Hall of Fame"]
hall_2 = df4[df4.Section == "Hall of Fame Suite"]
hall_3 = [hall_1,hall_2]
hall_4 = pd.concat(hall_3)

Hall = hall_4.groupby(['Transaction_Date'],as_index =  False)['Quantity'].sum()

Hall["Section"] = "Overall Hall"
Hall = Hall[["Section","Transaction_Date","Quantity"]]

#Appending with the Old dataframe
df5 =[df4,Club,Floor,Hall]
df6 = pd.concat(df5)

#Heading
st.title("Trend Visualisation for sales of tickets")

#Selecting the section
section = st.sidebar.multiselect('Select a Sections',list(df6.Section.unique()))

#Start date
start_date = st.sidebar.date_input('Select the Start date',value =pd.to_datetime("2021-03-23", format="%Y-%m-%d") ,min_value = pd.to_datetime("2021-03-23", format="%Y-%m-%d"),max_value=pd.to_datetime("2021-05-10", format="%Y-%m-%d"))

#End date
end_date = st.sidebar.date_input('Select the End date',value =pd.to_datetime("2021-03-23", format="%Y-%m-%d") ,min_value = pd.to_datetime("2021-03-23", format="%Y-%m-%d"),max_value=pd.to_datetime("2021-05-10", format="%Y-%m-%d"))

#Converting the date as string
start = start_date.strftime("%Y-%m-%d")
end = end_date.strftime("%Y-%m-%d")

#Filtering with the input date
df8 = df6.loc[(df6["Transaction_Date"]>= start)&(df6["Transaction_Date"]<= end)]

#Filtering with input sections
names = section
df9 = df8[df8.Section.isin(names)]

#Selecting only dates and sales
df10 = df9[["Transaction_Date","Quantity"]]

#Converting dates as datetime format
df10.Transaction_Date = pd.to_datetime(df10.Transaction_Date)

#Converting date column as index
df11 = df10.set_index("Transaction_Date")

#Putting the dataframe into a variable "train"
train = df11

#Model fitting for prediction
scaler = MinMaxScaler()
scaler.fit(train)
train = scaler.transform(train)

n_input = 6
n_features = 1
generator = TimeseriesGenerator(train, train, length=n_input, batch_size=6)

model = Sequential()
model.add(LSTM(200, activation='relu', input_shape=(n_input, n_features)))
model.add(Dropout(0.15))
model.add(Dense(1))
model.compile(optimizer='adam', loss='mse')

model.fit_generator(generator,epochs=6)

pred_list = []

batch = train[-n_input:].reshape((1, n_input, n_features))

for i in range(n_input):   
    pred_list.append(model.predict(batch)[0]) 
    batch = np.append(batch[:,1:,:],[[pred_list[i]]],axis=1)

from pandas.tseries.offsets import DateOffset
add_dates = [df11.index[-1] + DateOffset(days = x) for x in range(0,7) ]
future_dates = pd.DataFrame(index=add_dates[1:],columns=df11.columns)

df_predict = pd.DataFrame(scaler.inverse_transform(pred_list),
                          index=future_dates[-n_input:].index, columns=['Prediction'])

df_proj = pd.concat([df11,df_predict], axis=1)

#Visualising the prediction graph
fig = px.scatter(df_proj,
    trendline_color_override='green'
                 
)

fig.update_traces(mode = 'lines')

#Editing date for acutual data
end_2 = end_date + DateOffset(days = 6)

#Filtering the data according to date (+6 days from the end date selected for prediction)
df12 = df6.loc[(df6["Transaction_Date"]>= start)&(df6["Transaction_Date"]<= end_2)]

#Filtering the sections
df13 = df12[df12.Section.isin(names)]

#Plotting the acutal sales
fig2 = px.scatter(df13,x="Transaction_Date",
    y="Quantity",
    trendline="ols",
    trendline_color_override='green',
    color="Section"
                 
)

fig2.update_traces(mode = 'lines')

##FOR PRICE##

#Filtering only the required columns
df14 = df[["Section","Display_Price_Per_Ticket_Amount","Transaction_Date"]]

#Sorting by date
df15 = df14.sort_values(by = "Transaction_Date")

#Finding the mean price of ticket in a section per date
df16 = df15.groupby(['Section','Transaction_Date'],as_index =  False)['Display_Price_Per_Ticket_Amount'].mean()

#Combing then Clubs
club_6 = df16[df16.Section == "Club Hall of Fame"]
club_7 = df16[df16.Section == "Club Main"]
club_8 = df16[df16.Section == "Club Mezzanine"]
club_9 = [club_6,club_7,club_8]
club_10 = pd.concat(club_9)

Club_11 = club_10.groupby(['Transaction_Date'],as_index =  False)['Display_Price_Per_Ticket_Amount'].mean()

Club_11["Section"] = "Overall Club"
Club_12 = Club_11[["Section","Transaction_Date","Display_Price_Per_Ticket_Amount"]]

#Combining the Floors
floor_8 = df16[df16.Section == "FN5"]
floor_9 = df16[df16.Section == "Floor FE"]
floor_10 = df16[df16.Section == "Floor FN"]
floor_11 = df16[df16.Section == "Floor FS"]
floor_12 = df16[df16.Section == "Floor FW"]
floor_13 = [floor_8,floor_9,floor_10,floor_11,floor_12]
floor_14 = pd.concat(floor_13)

Floor_15 = floor_14.groupby(['Transaction_Date'],as_index =  False)['Display_Price_Per_Ticket_Amount'].mean()

Floor_15["Section"] = "Overall Floor"
Floor_16 = Floor_15[["Section","Transaction_Date","Display_Price_Per_Ticket_Amount"]]

#Combing the Halls
hall_5 = df16[df16.Section == "Hall of Fame"]
hall_6 = df16[df16.Section == "Hall of Fame Suite"]
hall_7 = [hall_5,hall_6]
hall_8 = pd.concat(hall_7)

Hall_9 = hall_8.groupby(['Transaction_Date'],as_index =  False)['Display_Price_Per_Ticket_Amount'].mean()

Hall_9["Section"] = "Overall Hall"
Hall_10 = Hall_9[["Section","Transaction_Date","Display_Price_Per_Ticket_Amount"]]

#Appending with the Old dataframe
df17 =[df16,Club_12,Floor_16,Hall_10]
df18 = pd.concat(df17)

#Filtering the data according to date (+6 days from the end date selected for prediction)
df19 = df18.loc[(df18["Transaction_Date"]>= start)&(df18["Transaction_Date"]<= end_2)]

#Filtering the sections
df20 = df19[df19.Section.isin(names)]

#Ploting the graph
fig3 = px.scatter(df20,
    x="Transaction_Date",
    y="Display_Price_Per_Ticket_Amount",
    trendline="ols",
    trendline_color_override='green',
    color="Section"
                 
)

fig3.update_traces(mode = 'lines')

#Plotting all the graphs
st.plotly_chart(fig, use_container_width=True)
st.plotly_chart(fig2, use_container_width=True)
st.plotly_chart(fig3, use_container_width=True)