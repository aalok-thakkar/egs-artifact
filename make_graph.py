#!/usr/bin/env python3

import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib

tools = "EGS, Scythe, ILASP(A), ILASP(S), ProSynth(A), ProSynth(S)"
tools = [bm.strip() for bm in tools.split(',')]

df = pd.read_csv('performance_runtimes.csv')
df = df.drop(columns=['Benchmarks'])
df.columns = pd.Index(tools)

results = {}
for tool in tools:
    sorted_df = df[tool].dropna().sort_values(axis=0).apply(lambda x : 1 if x <= 1 else x)
    sorted_df.index = pd.Index(range(1, len(sorted_df)+1))
    results[sorted_df.name]=sorted_df

plt.switch_backend('Agg') 

fig, ax = plt.subplots()
ax.plot(results['EGS'].index, results['EGS'].values, marker='x', markersize=5, color = 'darkblue', label='EGS')
ax.plot(results['Scythe'].index, results['Scythe'].values, marker='o',markersize=5, \
        markeredgecolor = 'red', color = 'red', label='Scythe')
ax.plot(results['ILASP(A)'].index, results['ILASP(A)'].values, \
        marker = 'v', markersize=5 ,markerfacecolor = 'white', markeredgecolor='.25',label='ILASP(A)')
ax.plot(results['ILASP(S)'].index , results['ILASP(S)'].values, marker='v', markersize=5, \
         markerfacecolor='green', markeredgecolor='.25', color='green',label='ILASP(S)')
ax.plot(results['ProSynth(A)'], results['ProSynth(A)'].values, linestyle='-', marker='s', markersize=5,
         color='.15',markerfacecolor='white', label='ProSynth(A)')
ax.plot(results['ProSynth(S)'], results['ProSynth(S)'].values, linestyle='-', marker='s', markersize=5,
        markerfacecolor='.15', markeredgecolor='.15', color='.15',label='ProSynth(S)')
#ax.plot(results['ProSynth(A)'], results['ProSynth(A)'].values, linestyle='-', marker='s', markersize=5,
       # markerfacecolor='.15', markeredgecolor='.15', color='.15',label='ProSynth(A)')
ax.set_yscale('log')
ax.set_yticks([1,10,100])
ax.get_yaxis().set_major_formatter(matplotlib.ticker.ScalarFormatter())
plt.axvline(x=79,linestyle='--')
plt.xlabel('solved instances')
plt.ylabel('time in seconds')
plt.legend(bbox_to_anchor=(0,-.7, 1, .5), loc='upper left', ncol=3, mode="expand", frameon=True)
plt.savefig('graph.jpg',
            dpi=300, bbox_inches='tight', transparent=False)

print('File 'graph.jpg' created')
