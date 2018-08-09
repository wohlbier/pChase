#!/bin/bash

rm -rf .tau

tau init --mpi F --tau nightly

tau meas create stalls_1 --profile --mpi F --metrics PAPI_NATIVE:CPU_CLK_UNHALTED PAPI_NATIVE:CYCLE_ACTIVITY:CYCLES_NO_EXECUTE PAPI_NATIVE:RESOURCE_STALLS:SB PAPI_NATIVE:CYCLE_ACTIVITY:STALLS_L1D_PENDING --sample F --source-inst manual

#
# --source-inst automatic --select-file `pwd`/select.tau --keep-inst-files T
tau select stalls_1

tau meas copy stalls_1 stalls_2
tau meas edit stalls_2 --metrics PAPI_NATIVE:CYCLE_ACTIVITY:CYCLES_NO_EXECUTE PAPI_NATIVE:RESOURCE_STALLS:SB PAPI_NATIVE:L1D_PEND_MISS:FB_FULL PAPI_NATIVE:OFFCORE_REQUESTS_BUFFER:SQ_FULL
tau select stalls_2

tau select stalls_1

# mkdir build_tau_icpc
# cd build_tau_icpc
# CXX="`which tau` `which icpc`" cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS="-D__TAU_MANUAL_INST__ -DTAU_DOT_H_LESS_HEADERS" ../
# make VERBOSE=1
# tau ./chase -c 4294967296 -s 20
