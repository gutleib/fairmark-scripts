#! /bin/bash
cat $(ls ./|grep session|grep token|tail -1)
