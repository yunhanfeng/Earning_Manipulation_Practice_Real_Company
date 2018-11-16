
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

### Revenue, Net Income and Total Asset of Amgen ###

df = pd.read_csv('amgen_compustate.csv')

y2017 = df[df['fyear']==2017]
y17_basic = pd.DataFrame(y2017[['revt','ni','at']])
print(y17_basic)

df2 = df[['fyear','revt','ni','at']]
df2 = df2.set_index('fyear')

plt.figure(figsize=(10,8))
plt.plot(df2['revt'], linestyle = 'solid')
plt.plot(df2['ni'], linestyle = 'dashed')
plt.plot(df2['at'], linestyle = 'dashdot')
plt.legend(df2.columns.values.tolist())
plt.title('Trend for Revenue, Net Income & Total Asset for Amgen Inc 1988-2017')
plt.show()
